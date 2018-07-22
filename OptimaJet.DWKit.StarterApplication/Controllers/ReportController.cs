using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Newtonsoft.Json;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Model;
using OptimaJet.DWKit.Core.View;

namespace OptimaJet.DWKit.StarterApplication.Controllers
{
    [Authorize]
    public class ReportController : Controller
    {
        [Route("report/workcalendar")]
        public async Task<ActionResult> WorkCalendar(DateTime datefrom, DateTime dateto)
        {
            if (!DWKitRuntime.Security.CheckPermission("WorkCalendar", "View"))
            {
                return Content("You don't have the permission");
            }
            return Json(await HRM.Reports.WorkCalendar.Generate(datefrom, dateto));
        }

        [Route("report/employee")]
        public async Task<ActionResult> Employee(DateTime datefrom, DateTime dateto, string parameter, int period = 0)
        {
            if (!DWKitRuntime.Security.CheckPermission("EmployeeReport", "View"))
            {
                return Content("You don't have the permission");
            }
            return Json(await HRM.Reports.EmployeeReport.Generate(datefrom, dateto, parameter, period));
        }

        [Route("report/workflow")]
        public async Task<ActionResult> Workflow(DateTime? datefrom, DateTime? dateto)
        {
            if (!DWKitRuntime.Security.CheckPermission("WorkflowReport", "View"))
            {
                return Content("You don't have the permission");
            }
            return Json(await HRM.Reports.WorkflowReport.Generate(datefrom, dateto));
        }
    }
}
