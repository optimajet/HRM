using System;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Configuration;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.CodeActions;
using OptimaJet.DWKit.Core.DataProvider;
using OptimaJet.DWKit.Core.Metadata;
using OptimaJet.DWKit.Core.Utils;
using OptimaJet.DWKit.MSSQL;
using OptimaJet.DWKit.PostgreSQL;
using OptimaJet.DWKit.Security.Providers;
using OptimaJet.Workflow;
using OptimaJet.Workflow.Core.Runtime;
using static OptimaJet.HRM.HRMNotifier;

namespace OptimaJet.DWKit.Application
{
    public static class Configurator
    {
        public static void Configure(IHttpContextAccessor httpContextAccessor, IHubContext<ClientNotificationHub> notificationHubContext, IConfigurationRoot configuration,
            string connectionStringName = "default")
        {
            DWKitRuntime.HubContext = notificationHubContext;
            Configure(httpContextAccessor, configuration, connectionStringName);
        }

        public static void Configure(IHttpContextAccessor httpContextAccessor, IConfigurationRoot configuration, string connectionstringName = "default")
        {
            #region License

            var licensefile = "license.key";
            if (File.Exists(licensefile))
            {
                try
                {
                    var licenseText = File.ReadAllText(licensefile);
                    DWKitRuntime.RegisterLicense(licenseText);
                }
                catch
                {
                    //TODO add write to log
                }
            }

            #endregion

#if (DEBUG)
            DWKitRuntime.UseMetadataCache = false;
            //CodeActionsCompiler.DebugMode = true;
#elif (RELEASE)
            DWKitRuntime.UseMetadataCache = true;
#endif

            DWKitRuntime.ConnectionStringData = configuration[$"ConnectionStrings:{connectionstringName}"];
            DWKitRuntime.DbProvider = AutoDetectProvider();
            DWKitRuntime.Security = new SecurityProvider(httpContextAccessor);

            var path = configuration["Metadata:path"];

            if (string.IsNullOrEmpty(path))
            {
                path = "Metadata/metadata.json";
            }

            DWKitRuntime.Metadata = new DefaultMetadataProvider(path, "Metadata/Forms", "Metadata/Localization");

            if (configuration["DWKit:BlockMetadataChanges"] == "True")
            {
                DWKitRuntime.Metadata.BlockMetadataChanges = true;
            }

            if (configuration["DWKit:BlockMetadataChanges"] == "True")
            {
                DWKitRuntime.Metadata.BlockMetadataChanges = true;
                DWKitRuntime.Metadata.ResourceFolder = configuration["DWKit:ResourceFolder"];
            }

            CodeActionsCompiler.RegisterAssembly(typeof(WorkflowRuntime).Assembly);
            //It is necessary to have this assembly for compile code with dynamic
            CodeActionsCompiler.RegisterAssembly(typeof(Microsoft.CSharp.RuntimeBinder.Binder).Assembly);
            DWKitRuntime.CompileAllCodeActionsAsync().Wait();
            DWKitRuntime.ServerActions.RegisterUsersProvider("filters", new Filters());
            DWKitRuntime.ServerActions.RegisterUsersProvider("triggers", new Triggers());

            //Initial inbox/outbox notifiers
            DWKitRuntime.AddClientNotifier(typeof(ClientNotificationHub), ClientNotifiers.NotifyClientsAboutInboxStatus);

            //Initial document count notifier
            DWKitRuntime.AddClientNotifier(typeof(ClientNotificationHub), SideMenuInitialNotifier);
            //User group classifier for notifications
            DWKitRuntime.SignalRGroupClassifier = SignalRGroupClassifier;

            //Documents count change on Insert new document or update document
            DynamicEntityOperationNotifier.SubscribeToInsertByTableName("Document", "SideMenuNotification",
                (m, c) =>
                {
                    Func<Task> func = async () => { await NotifyDocumentCountChange(m, c, false); };
                    func.FireAndForgetWithDefaultExceptionLogger();
                });
            DynamicEntityOperationNotifier.SubscribeToUpdateByTableName("Document", "SideMenuNotification",
                (m, c) =>
                {
                    Func<Task> func = async () => { await NotifyDocumentCountChange(m, c, true); };
                    func.FireAndForgetWithDefaultExceptionLogger();
                });
            //Documents count change and inbox outbox change on document deletions
            DynamicEntityOperationNotifier.SubscribeToDeleteByTableName("Document", "SideMenuNotification",
                (m, c) =>
                {
                    Func<Task> func = async () =>
                    {
                        await ClientNotifiers.DeleteWokflowAndNotifyClients(m, c);
                        await NotifyDocumentCountChange(m, c, false);
                    };

                    func.FireAndForgetWithDefaultExceptionLogger();
                });

            //Forcing the creation of a WF runtime to initialize timers and the Flow.
            try
            {
                WorkflowInit.ForceInit();
            }
            catch (Exception e)
            { 
                if (Debugger.IsAttached)
                {
                    var info = ExceptionUtils.GetExceptionInfo(e);
                    var errorBuilder = new StringBuilder();
                    errorBuilder.AppendLine("Workflow engine start failed.");
                    errorBuilder.AppendLine($"Message: {info.Message}");
                    errorBuilder.AppendLine($"Exceptions: {info.Exeptions}");
                    errorBuilder.Append($"StackTrace: {info.StackTrace}");
                    Debug.WriteLine(errorBuilder);
                }
            }
          
        }

        public static IDbProvider AutoDetectProvider()
        {
            IDbProvider provider = null;

            try
            {
                using (new System.Data.SqlClient.SqlConnection(DWKitRuntime.ConnectionStringData))
                {}

                provider = new SQLServerProvider();
            }
            catch (ArgumentException)
            {
            }

            if (provider == null)
            {
                try
                {
                    using (IDbConnection connection = new Npgsql.NpgsqlConnection(DWKitRuntime.ConnectionStringData)) {}
                    provider = new PostgreSqlProvider();
                }
                catch (ArgumentException)
                {
                }
            }

            return provider;
        }
    }
}
