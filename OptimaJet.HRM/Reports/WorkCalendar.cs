using Newtonsoft.Json;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Model;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using OptimaJet.HRM.Model;

namespace OptimaJet.HRM.Reports
{
    public class WorkCalendarEvent
    {
        public WorkCalendarEvent()
        {

        }

        public WorkCalendarEvent(DynamicEntity item, string itemForm, string typeName)
        {
            dynamic d = item as dynamic;
            id = d.Id;
            form = itemForm;

            if (item.Dictionary.ContainsKey("EmployeeId_Name"))
            {
                if (string.IsNullOrEmpty(d.Name))
                {
                    title = string.Format("{0} ({1})", d.EmployeeId_Name, typeName);
                }
                else
                {
                    title = string.Format("{0}: {1} ({2})", d.Name, d.EmployeeId_Name, typeName);
                }
            }
            else if (item.Dictionary.ContainsKey("EmployeesNames"))
            {
                title = string.Format("{0}: {1} ({2})", d.Name, string.Join(", ", d.EmployeesNames), typeName);
            }
            else
            {
                title = string.Format("{0} ({1})", d.Name, typeName);
            }
                
            start = d.DateStart;
            end = d.DateEnd;
        }

        public Guid id;
        public string title;
        public string form;
        public bool allDay = true;
        public DateTime start;
        public DateTime end;
    }

    public class WorkCalendar
    {
        public async static Task<object> Generate(DateTime datefrom, DateTime dateto)
        {
            EntityModel employeeModel = await MetadataToModelConverter.GetEntityModelByModelAsync("Employee", 0);
            EntityModel businessTripModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.BusinessTrip);
            EntityModel sickLeaveModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.SickLeave);
            EntityModel vacationModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Vacation);

            var filter = Filter.And.In(WorkflowReport.FinalStates, "State").Merge(
                Filter.And.LessOrEqual(dateto, "DateStart").GreaterOrEqual(datefrom, "DateEnd"));
            
            var employees = await employeeModel.GetAsync(Filter.Empty);
            var businessTripFilter = DocumentTypes.GetFilter(DocumentTypes.BusinessTrip)
                .Merge(filter)
                .Merge(await Document.GetViewFilterForCurrentUser(businessTripModel));
            var businessTrips = await businessTripModel.GetAsync(businessTripFilter);
            businessTrips.ForEach((item) =>
            {
                var i = (dynamic)item;
                if (!string.IsNullOrEmpty(i.Employees))
                {
                    i.EmployeesList = JsonConvert.DeserializeObject<List<Guid>>(i.Employees);
                    var names = new List<string>();
                    foreach (Guid empId in i.EmployeesList)
                    {
                        var emp = employees.Select(c=> c as dynamic).Where(c => c.Id == empId).FirstOrDefault();
                        names.Add(emp?.Name);
                    }
                    i.EmployeesNames = names.OrderBy(c => c).ToList();
                }
            });

            var sickLeaveFilter = DocumentTypes.GetFilter(DocumentTypes.SickLeave)
                .Merge(filter)
                .Merge(await Document.GetViewFilterForCurrentUser(sickLeaveModel));
                
            var sickLeaves = await sickLeaveModel.GetAsync(sickLeaveFilter);

            var vacationFilter = DocumentTypes.GetFilter(DocumentTypes.Vacation)
                .Merge(filter)
                .Merge(await Document.GetViewFilterForCurrentUser(vacationModel));
            var vacations = await vacationModel.GetAsync(vacationFilter);

            var res = new List<WorkCalendarEvent>();
            res.AddRange(businessTrips.Select(c => new WorkCalendarEvent(c, "businesstrip", "Business Trip")));
            res.AddRange(sickLeaves.Select(c => new WorkCalendarEvent(c, "sickleave", "Sick Leave")));
            res.AddRange(vacations.Select(c => new WorkCalendarEvent(c, "vacation", "Vacation")));
            return res;
        }
    }
}
