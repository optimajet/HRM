using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Metadata.DbObjects;
using OptimaJet.DWKit.Core.ORM;
using OptimaJet.HRM.Model;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using OptimaJet.DWKit.Core.Utils.OptimaJet.Common;

namespace OptimaJet.HRM
{
    public class EmployeeBusiness
    {
        public async static Task<Dictionary<string, string>> GenerateInvitation(Guid employeeId)
        {
            Employee emp = await Employee.SelectByKey(employeeId);
            if (emp == null)
                throw new Exception("The employee is not found!");

            var date = DateTime.Now;
            InvitationLetter letter = new InvitationLetter()
            {
                Id = Guid.NewGuid(),
                EmployeeId = employeeId,
                Date = date,
                DateExpired = date.AddDays(5)
            };

            await letter.ApplyAsync();

            var parameters = new Dictionary<string, string>();
            parameters.Add("Name", emp.Name);
            parameters.Add("Email", emp.Email);
            parameters.Add("Id", emp.Id.ToString());
            parameters.Add("Key", letter.Id.ToString());
            
            return parameters;
        }

        public async static Task SendInvitation(Guid employeeId)
        {
            var pars = await GenerateInvitation(employeeId);
            await DWKit.Core.Utils.Email.SendEmail("WelcomeLetter", pars["Email"], pars);
        }

        public async static Task Registration(Guid key, string domainLogin, string login, string password)
        {
            var invite = await InvitationLetter.SelectByKey(key);
            if(invite == null)
            {
                throw new Exception("The invitation key is incorrect!");
            }

            if(invite.DateExpired < DateTime.Now)
            {
                throw new Exception("The invitation key is expired!");
            }

            var employee = await Employee.SelectByKey(invite.EmployeeId);
            if (employee == null)
            {
                throw new Exception("The employee is not found!");
            }
            
            var su = await SecurityUser.SelectByKey(invite.EmployeeId);
            if (su == null)
            {
                su = new SecurityUser()
                {
                    Id = employee.Id,
                    Name = employee.Name,
                    Email = employee.Email
                };
                await su.ApplyAsync();
            }

            await CheckDefaultRole(employee.Id, "Users");

            var credentials = await SecurityUser.GetCredentialByUserId(su.Id);
            var containerCredential = new ObservableEntityContainer(credentials.Select(c => c.AsDynamicEntity), SecurityCredential.Model);
            containerCredential.RemoveAll();

            if (!string.IsNullOrEmpty(domainLogin))
            {
                var domainCredential = new SecurityCredential()
                {
                    Id = Guid.NewGuid(),
                    SecurityUserId = su.Id,
                    Login = domainLogin,
                    AuthenticationType = 1
                };
                containerCredential.Merge(new List<dynamic>() { domainCredential.AsDynamicEntity });
            }

            if (!string.IsNullOrEmpty(login) && !string.IsNullOrEmpty(password))
            {
                var passwordSalt = HashHelper.GenerateSalt();
                var passwordHash = HashHelper.GenerateStringHash(password, passwordSalt);
                
                var customCredential = new SecurityCredential()
                {
                    Id = Guid.NewGuid(),
                    SecurityUserId = su.Id,
                    Login = login,
                    PasswordHash = passwordHash,
                    PasswordSalt = passwordSalt,
                    AuthenticationType = 0
                };
                containerCredential.Merge(new List<dynamic>() { customCredential.AsDynamicEntity });
            }

            await containerCredential.ApplyAsync();
            await InvitationLetter.DeleteAsync(new Guid[] { key });
        }

        public static async Task CheckDefaultRole(Guid userId, string roleCode)
        {
            if (await SecurityUserToSecurityRole.HasUserRole(userId, roleCode))
                return;

            var role = await SecurityRole.SelectByCode(roleCode);
            if (role != null)
            {
                var suroles = new SecurityUserToSecurityRole()
                {
                    Id = Guid.NewGuid(),
                    SecurityRoleId = role.Id,
                    SecurityUserId = userId
                };
                await suroles.ApplyAsync();
            }
        }
    }
}
