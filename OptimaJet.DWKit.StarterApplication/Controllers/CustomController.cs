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
using Newtonsoft.Json.Linq;

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

        [Route("data/profile")]
        public async Task<ActionResult> Profile(string data)
        {
            var isPost = Request.Method.Equals("POST", StringComparison.OrdinalIgnoreCase);
            if (!isPost)
            {
                var cu = DWKitRuntime.Security.CurrentUser;
                if (cu == null)
                    return Json(new FailResponse("The current user is not found!"));

                object obj = null;
                obj = new
                {
                    cu.Name,
                    cu.Email,
                    cu.Localization,
                    Roles = string.Join(", ", cu.Roles),
                    Groups = string.Join(", ", cu.Groups)
                };
                return Json(obj);
            }
            else
            {
                var cu = DWKitRuntime.Security.CurrentUser;
                if (cu == null)
                    return Json(new FailResponse("The current user is not found!"));

                var su = await Core.Metadata.DbObjects.SecurityUser.SelectByKey(DWKitRuntime.Security.CurrentUser.Id);
                su.StartTracking();
                if (su == null)
                    return Json(new FailResponse("The current user is not found!"));

                var dataJson = JToken.Parse(data);

                su.Email = dataJson["email"].ToString();
                su.Localization = dataJson["localization"].ToString();
                await su.ApplyAsync();
                return Json(new SuccessResponse());
            }
        }
    }
}
