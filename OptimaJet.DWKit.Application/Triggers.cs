using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Metadata.DbObjects;
using OptimaJet.DWKit.Core.Model;
using OptimaJet.DWKit.Core.Security;
using OptimaJet.HRM;
using OptimaJet.Workflow.Core.Runtime;

namespace OptimaJet.DWKit.Application
{
    public class Triggers : IServerActionsProvider
    {
        #region IServerActionsProvider implementation

        private Dictionary<string, Func<EntityModel, List<dynamic>, dynamic, (string Message, bool IsCancelled)>> _triggers
            = new Dictionary<string, Func<EntityModel, List<dynamic>, dynamic, (string Message, bool IsCancelled)>>();

        private Dictionary<string, Func<EntityModel, List<dynamic>, dynamic, Task<(string Message, bool IsCancelled)>>> _triggersAsync
            = new Dictionary<string, Func<EntityModel, List<dynamic>, dynamic, Task<(string Message, bool IsCancelled)>>>();

        public List<string> GetFilterNames()
        {
            return new List<string>();
        }

        public bool IsFilterAsync(string name)
        {
            return false;
        }

        public bool ContainsFilter(string name)
        {
            return false;
        }

        public Filter GetFilter(string name, EntityModel model, List<dynamic> entities, dynamic options)
        {
            throw new NotImplementedException();
        }

        public Task<Filter> GetFilterAsync(string name, EntityModel model, List<dynamic> entities, dynamic options)
        {
            throw new NotImplementedException();
        }

        public List<string> GetTriggerNames()
        {
            return _triggers.Keys.Concat(_triggersAsync.Keys).ToList();
        }

        public bool IsTriggerAsync(string name)
        {
            return _triggersAsync.ContainsKey(name);
        }

        public bool ContainsTrigger(string name)
        {
            return _triggersAsync.ContainsKey(name) || _triggers.ContainsKey(name);
        }

        public (string Message, bool IsCancelled) ExecuteTrigger(string name, EntityModel model, List<dynamic> entities, dynamic options)
        {
            if (_triggers.ContainsKey(name))
                return _triggers[name](model, entities, options);

            throw new System.NotImplementedException();
        }

        public Task<(string Message, bool IsCancelled)> ExecuteTriggerAsync(string name, EntityModel model, List<dynamic> entities, dynamic options)
        {
            if (_triggersAsync.ContainsKey(name))
                return _triggersAsync[name](model, entities, options);

            throw new System.NotImplementedException();
        }

        public List<string> GetActionNames()
        {
            return new List<string>();
        }

        public bool IsActionAsync(string name)
        {
            return false;
        }

        public bool ContainsAction(string name)
        {
            return false;
        }

        public dynamic ExecuteAction(string name, dynamic request)
        {
            throw new System.NotImplementedException();
        }

        public async Task<dynamic> ExecuteActionAsync(string name, dynamic request)
        {
            throw new System.NotImplementedException();
        }

        #endregion

        public Triggers()
        {
            _triggersAsync.Add("SetFields", SetFields);
            _triggersAsync.Add("InitFields", InitFields);
            _triggersAsync.Add("CheckLinkedSecurityUser", CheckLinkedSecurityUser);
        }

        public async Task<(string Message, bool IsCancelled)> SetFields(EntityModel model, List<dynamic> entities, dynamic options)
        {
            DynamicEntity fields = options as DynamicEntity;
            if (fields != null)
            {
                foreach (DynamicEntity entity in entities)
                {
                    foreach (var field in fields.Dictionary)
                    {
                        entity.TrySetMember(field.Key, await ReplaceVariable(field.Value, model));
                    }
                }
            }

            return (null, false);
        }

        public async Task<(string Message, bool IsCancelled)> InitFields(EntityModel model, List<dynamic> entities, dynamic options)
        {
            DynamicEntity fields = options as DynamicEntity;
            if (fields != null)
            {
                foreach (var entity in entities)
                {
                    if (entity[model.PrimaryKeyAttributeName] == null)
                    {
                        foreach (var field in fields.Dictionary)
                        {
                            entity.TrySetMember(field.Key, await ReplaceVariable(field.Value, model));
                        }
                    }
                }
            }
            return (null, false);
        }

        public static async Task<object> ReplaceVariable(object val, EntityModel model)
        {
            if (val is string)
            {
                var str = (string)val;

                if (str == "@OperationUserId")
                    return DWKitRuntime.Security.CurrentUser.GetOperationUserId();
                else if (str == "@OperationUserName")
                    return DWKitRuntime.Security.CurrentUser.GetOperationUserName();
                if (str == "@CurrentUserId")
                    return DWKitRuntime.Security.CurrentUser.Id;
                else if (str == "@OperationUserName")
                    return DWKitRuntime.Security.CurrentUser.Name;
                else if (str == "@DateTimeNow" || str == "@DateNow")
                    return DateTime.Now;
                else if (str == "@DefaultState")
                {
                    var schemes = DWKitRuntime.Metadata.GetWorkflowByForm(model.Name);
                    var initialState = schemes.Count == 0 ?
                        new WorkflowState() { Name = "", SchemeCode = "", VisibleName = "" } :
                        await WorkflowInit.Runtime.GetInitialStateAsync(schemes[0]);
                    return initialState.VisibleName;
                }
            }

            return val;
        }

        public async Task<(string Message, bool IsCancelled)> CheckLinkedSecurityUser(EntityModel model, List<dynamic> entities, dynamic options)
        {
            foreach (var entity in entities)
            {
                entity.Name = entity.FirstName + " " + entity.LastName;
                SecurityUser user = await SecurityUser.SelectByKey(entity.Id);
                if (user == null)
                {
                    user = new SecurityUser()
                    {
                        Id = entity.Id,
                        Name = entity.Name,
                        Email = entity.Email
                    };
                    await user.ApplyAsync();
                }
                else
                {
                    if (user.Name != entity.Name || user.Email != entity.Email)
                    {
                        user.StartTracking();
                        user.Name = entity.Name;
                        user.Email = entity.Email;
                        await user.ApplyAsync();
                    }
                }

                await EmployeeBusiness.CheckDefaultRole(user.Id, "Users");
            }
            return (null, false);
        }
    }
}