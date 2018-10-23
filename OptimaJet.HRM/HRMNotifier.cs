using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.DataProvider;
using OptimaJet.DWKit.Core.Model;
using OptimaJet.HRM.Model;

namespace OptimaJet.HRM
{
    public static class HRMNotifier
    {
        public const string SideMenuPath = "app.sidemenu";
        public const string ViewAllGroupName = "DocumentsAll";
        
        public static async Task SideMenuInitialNotifier(string userId)
        {
            var userIdGuid = new Guid(userId);

            var tripFilter = Document.GetViewFilterForUser(userIdGuid, await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.BusinessTrip));
            var sickLeaveFilter = Document.GetViewFilterForUser(userIdGuid, await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.SickLeave));
            var vacationFilter = Document.GetViewFilterForUser(userIdGuid, await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Vacation));
            var compenstationFilter = Document.GetViewFilterForUser(userIdGuid, await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Compensation));
            var recruitmentFilter = Document.GetViewFilterForUser(userIdGuid, await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Recruitment));

            var status = new
            {
                businesstrip = await Document.GetDocumentTypeCountAsync(DocumentTypes.BusinessTrip, tripFilter),
                sickleave = await Document.GetDocumentTypeCountAsync(DocumentTypes.SickLeave, sickLeaveFilter),
                vacation = await Document.GetDocumentTypeCountAsync(DocumentTypes.Vacation, vacationFilter),
                compensation = await Document.GetDocumentTypeCountAsync(DocumentTypes.Compensation, compenstationFilter),
                recruitment = await Document.GetDocumentTypeCountAsync(DocumentTypes.Recruitment, recruitmentFilter),
                employeeform = DWKitRuntime.Security.CheckPermission(userIdGuid, "Employee", "View"),
                documentsform = DWKitRuntime.Security.CheckPermission("Documents", "View"),
                workflowreport = DWKitRuntime.Security.CheckPermission("WorkflowReport", "View"),
                employeereport = DWKitRuntime.Security.CheckPermission("EmployeeReport", "View"),
                workcalendar = DWKitRuntime.Security.CheckPermission("WorkCalendar", "View")
            };

            await DWKitRuntime.SendStateChangeToUserAsync(userId, SideMenuPath, status);
        }


        public static async Task<List<string>> SignalRGroupClassifier(string userId)
        {
            if (DWKitRuntime.Security.CheckPermission(new Guid(userId), "Documents", "ViewAll"))
            {
                return new List<string> {ViewAllGroupName};
            }
            
            return new List<string>();
        }

        public static async Task NotifyDocumentCountChange(EntityModel model, List<ChangeOperation> changes, bool isUpdate)
        {
            //Wide View All notification
            if (!isUpdate)
            {
                await SendNotificationToViewAllGroup(model);
            }

            var ids = new List<string>();

            foreach (var changeOperation in changes)
            {

                if (!isUpdate)
                {
                    if (model.Attributes.Any(a => a.Name.Equals("AuthorId", StringComparison.Ordinal)))
                    {
                        var item = changeOperation.Entity["AuthorId"]?.ToString();
                        if (item != null)
                            ids.Add(item);
                    }

                    if (model.Attributes.Any(a => a.Name.Equals("EmployeeId", StringComparison.Ordinal)))
                    {
                        var item = changeOperation.Entity["EmployeeId"]?.ToString();
                        if (item != null)
                            ids.Add(item);
                    }

                    if (model.Attributes.Any(a => a.Name.Equals("Employees", StringComparison.Ordinal)))
                    {
                        var employeesStr = changeOperation.Entity["Employees"]?.ToString();

                        if (employeesStr != null)
                        {
                            var employeeIds = JsonConvert.DeserializeObject<List<string>>(employeesStr);
                            ids.AddRange(employeeIds);
                        }
                    }
                }
                else
                {
                    AddUsersFromChangeOperation(changeOperation, "AuthorId", ids);
                    AddUsersFromChangeOperation(changeOperation, "EmployeeId", ids);
                    AddUsersFromChangeOperation(changeOperation, "Employees", ids, true);
                }
            }

            ids = ids.Distinct().ToList();

            foreach (var userId in ids)
            {
                var userChange = new Dictionary<string, long>();

                if (!DWKitRuntime.Security.CheckPermission(new Guid(userId), "Documents", "ViewAll"))
                {
                    userChange.Add(model.Name.ToLower(), await Document.GetDocumentTypeCountAsync(model.SourceDataModelName, Document.GetViewFilterForUser(new Guid(userId), model)));

                    await DWKitRuntime.SendStateChangeToUserAsync(userId, SideMenuPath, userChange);
                }
            }
        }

        private static async Task SendNotificationToViewAllGroup(EntityModel model)
        {
            var change = new Dictionary<string, long>();
            
            change.Add(model.Name.ToLower(), await Document.GetDocumentTypeCountAsync(model.SourceDataModelName, Filter.Empty));
          
            await DWKitRuntime.SendStateChangeToGroupAsync(ViewAllGroupName, SideMenuPath, change);
        }

        private static void AddUsersFromChangeOperation(ChangeOperation changeOperation, string propertyName, List<string> ids, bool isList = false)
        {
            var change = changeOperation.Data.FirstOrDefault(d => d.PropertyName.Equals(propertyName, StringComparison.Ordinal));

            if (change != null)
            {
                if (change.InitialValue != null)
                {
                    if (!isList)
                        ids.Add(change.InitialValue.ToString());
                    else
                        ids.AddRange(JsonConvert.DeserializeObject<List<string>>(change.InitialValue.ToString()));
                }

                if (change.NewValue != null)
                {
                    if (!isList)
                        ids.Add(change.NewValue.ToString());
                    else
                        ids.AddRange(JsonConvert.DeserializeObject<List<string>>(change.NewValue.ToString()));
                }
            }
        }
    }
}
