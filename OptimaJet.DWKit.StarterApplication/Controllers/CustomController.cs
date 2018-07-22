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
    public class CustomController : Controller
    {   
        [Route("data/dashboard")]
        public async Task<ActionResult> Dashboard()
        {
            try
            {
                return Json(await HRM.Dashboard.Generate());
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
          
        }

        [Route("data/sidemenu")]
        public async Task<ActionResult> SideMenu()
        {
            try
            {
                return Json(await HRM.Dashboard.GetMenuData());
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }

        [Route("data/search")]
        public async Task<ActionResult> Search(string term)
        {
            try
            {
                return Json(await HRM.Search.GetAsync(term));
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }

        [Route("account/invite")]
        public async Task<ActionResult> AccountInvite(Guid employeeid)
        {
            try
            {
                await OptimaJet.HRM.EmployeeBusiness.SendInvitation(employeeid);
                return Json(new SuccessResponse("The invitation was sent!"));
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }
    }
}
