using System;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Configuration;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.CodeActions;
using OptimaJet.DWKit.Core.DataProvider;
using OptimaJet.DWKit.Core.Metadata;
using OptimaJet.DWKit.MSSQL;
using OptimaJet.DWKit.PostgreSQL;
using OptimaJet.DWKit.Security.Providers;
using OptimaJet.HRM.Model;
using OptimaJet.Workflow;
using OptimaJet.Workflow.Core.Runtime;
using static OptimaJet.HRM.HRMNotifier;

namespace OptimaJet.DWKit.Application
{
    public static class Configurator
    {
        public static void Configure(IHttpContextAccessor httpContextAccessor, IHubContext<ClientNotificationHub> notificationHubContext, IConfigurationRoot configuration,
            string connectionstringName = "default")
        {
            DWKitRuntime.HubContext = notificationHubContext;
            Configure(httpContextAccessor,configuration,connectionstringName);
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
            //CodeActionsCompiller.DebugMode = true;
#elif (RELEASE)
            DWKitRuntime.UseMetadataCache = true;
#endif

            DWKitRuntime.ConnectionStringData = configuration[$"ConnectionStrings:{connectionstringName}"];
            DWKitRuntime.DbProvider = AutoDetectProvider();
            DWKitRuntime.Security = new SecurityProvider(httpContextAccessor);
            DWKitRuntime.Metadata = new DefaultMetadataProvider("Metadata/metadata.json", "Metadata/Forms", "Metadata/Localization");

            if (configuration["DWKit:BlockMetadataChanges"] == "True")
            {
                DWKitRuntime.Metadata.BlockMetadataChanges = true;
            }

            CodeActionsCompiller.RegisterAssembly(typeof(WorkflowRuntime).Assembly);
            DWKitRuntime.CompileAllCodeActionsAsync().Wait();
            //It is necessery to have this assembly for compile code with dynamic
            CodeActionsCompiller.RegisterAssembly(typeof(Microsoft.CSharp.RuntimeBinder.Binder).Assembly);
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
            
            var runtime = WorkflowInit.Runtime;

        }

        public static IDbProvider AutoDetectProvider()
        {
            IDbProvider provider = null;

            try
            {
                using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(DWKitRuntime.ConnectionStringData)) { };
                provider = new SQLServerProvider();
                
            }
            catch (ArgumentException) { }

            if (provider == null)
            {
                try
                {
                    using (IDbConnection connection = new Npgsql.NpgsqlConnection(DWKitRuntime.ConnectionStringData)) { };
                    provider = new PostgreSqlProvider();
                }
                catch (ArgumentException) { }
            }

            return provider;
        }
    }
}
