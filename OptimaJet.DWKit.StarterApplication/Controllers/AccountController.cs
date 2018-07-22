using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Security;
using OptimaJet.DWKit.Core.View;
using OptimaJet.DWKit.StarterApplication.Models;
using OptimaJet.HRM;
using OptimaJet.HRM.Model;

namespace OptimaJet.DWKit.StarterApplication.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        [AllowAnonymous]
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> Login(string login, string password, bool remember)
        {
            try
            {
                if (await DWKitRuntime.Security.ValidateUserByLoginAsync(login, password))
                {
                    await DWKitRuntime.Security.SignInAsync(login, remember);
                    return Json(new SuccessResponse());
                }
            }
            catch(Exception ex)
            {
                return Json(new FailResponse(ex));
            }

            return Json(new FailResponse("Login or password is not correct."));
        }

        [AllowAnonymous]
        public ActionResult Registration()
        {
            return View("Login");            
        }

        [AllowAnonymous]
        public async Task<ActionResult> GetInviteInfo(string key)
        {
            if (string.IsNullOrEmpty(key))
            {
                return Json(new FailResponse("The key is invalid!"));
            }

            var invite = await OptimaJet.HRM.Model.InvitationLetter.SelectByKey(key);
            if(invite == null)
            {
                return Json(new FailResponse("The key is invalid!"));
            }

            if (invite.DateExpired < DateTime.Now)
            {
                return Json(new FailResponse("The key is expiried!"));
            }

            var employee = await Employee.SelectByKey(invite.EmployeeId);
            if(employee == null)
            {
                return Json(new FailResponse("Employee is not found!"));
            }
            var credential = await Core.Metadata.DbObjects.SecurityUser.GetCredentialByUserId(invite.EmployeeId);
            string login = credential.Where(c=> c.AuthenticationType == 0).Select(c=> c.Login).FirstOrDefault();
            string domainLogin = credential.Where(c => c.AuthenticationType == 1).Select(c => c.Login).FirstOrDefault();

            return Json(new ItemSuccessResponse<object>(new {
                name = employee.Name,
                login = login,
                domainLogin = domainLogin
            }));
        }

        [AllowAnonymous]
        [HttpPost]
        public async Task<ActionResult> Registration(Guid key, string domainLogin, string login, string password)
        {
            try
            {
                await EmployeeBusiness.Registration(key, domainLogin, login, password);
                return Json(new SuccessResponse());
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }

        [Route("account/get")]
        public async Task<ActionResult> GetUserInfo()
        {
            try
            {
                return Json(new ItemSuccessResponse<User>(await DWKitRuntime.Security.GetCurrentUserAsync()));
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }

        [Route("account/logoff")]
        public async Task<ActionResult> Logoff()
        {
            try
            {
                await DWKitRuntime.Security.SignOutAsync();
                return Redirect("/");
            }
            catch (Exception e)
            {
                return Json(new FailResponse(e));
            }
        }
    }
}
