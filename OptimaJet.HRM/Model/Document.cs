using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Metadata.DbObjects;
using OptimaJet.DWKit.Core.Model;
using OptimaJet.DWKit.Core.ORM;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace OptimaJet.HRM.Model
{
    public struct DocumentTypes
    {
        public const string BusinessTrip = "BusinessTrip";
        public const string Compensation = "Compensation";
        public const string SickLeave = "SickLeave";
        public const string Vacation = "Vacation";
        public const string Recruitment = "Recruitment";

        public static Filter GetFilter(string type)
        {
            return Filter.And.Equal(type, "Type");
        }
    }
    
  
    public class Document: DbObject<Document>
    {
        public Document() : base(true)
        {
        }

        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }

        [DbObjectModel]
        public int? NumberId
        {
            get => _entity.NumberId;
            set => _entity.NumberId = value;
        }

        [DbObjectModel]
        public DateTime Date
        {
            get => _entity.Date;
            set => _entity.Date = value;
        }

        [DbObjectModel]
        public DateTime? LastUpdatedDate
        {
            get => _entity.LastUpdatedDate;
            set => _entity.LastUpdatedDate = value;
        }

        [DbObjectModel]
        public string Type
        {
            get => _entity.Type;
            set => _entity.Type = value;
        }

        [DbObjectModel]
        public string Name
        {
            get => _entity.Name;
            set => _entity.Name = value;
        }

        [DbObjectModel]
        public Guid? AuthorId
        {
            get => _entity.AuthorId;
            set => _entity.AuthorId = value;
        }

        [DbObjectModel]
        public Guid? ManagerId
        {
            get => _entity.ManagerId;
            set => _entity.ManagerId = value;
        }

        [DbObjectModel]
        public string Comment
        {
            get => _entity.Comment;
            set => _entity.Comment = value;
        }

        [DbObjectModel]
        public string State
        {
            get => _entity.State;
            set => _entity.State = value;
        }

        [DbObjectModel]
        public decimal? Amount
        {
            get => _entity.Amount;
            set => _entity.Amount = value;
        }

        public async static Task<long> GetDocumentTypeCountAsync(string type)
        {
            return await GetDocumentTypeCountAsync(type, Filter.Empty);
        }
        public async static Task<long> GetDocumentTypeCountAsync(string type, Filter filter)
        {
            var model = await MetadataToModelConverter.GetEntityModelByModelAsync(type);
            return await model.GetCountAsync(Filter.And.Equal(type, "Type").Merge(filter));
        }

        public static List<Guid> GetAuthorManagers(Guid documentId)
        {
            List<Guid> res = new List<Guid>();
            var doc = SelectByKey(documentId).Result;

            var managers = V_Security_UserRole.SelectAsync(Filter.And.Equal("Managers", "RoleCode")).Result.Select(c=> c.UserId).ToList();
            if (managers.Count > 0)
            {
                if (doc != null && doc.AuthorId.HasValue)
                {
                    Guid authorId = doc.AuthorId.Value;
                    Employee author = Employee.SelectByKey(authorId).Result;
                    if (author.DepartmentId.HasValue)
                    {
                        var empManagers = Employee.SelectAsync(Filter.And.Equal(author.DepartmentId, "DepartmentId").In(managers, "Id")).Result;
                        res.AddRange(empManagers.Select(c=> c.Id));
                    }

                }
            }

            return res;
        }


        public static Filter GetViewFilterForUser(Guid userId, EntityModel model)
        {
            if (DWKitRuntime.Security.CheckPermission(userId, "Documents", "ViewAll"))
            {
                return Filter.Empty;
            }

            return GetViewFilterForUserPrivate(model, userId);
        }

        public static Filter GetViewFilterForCurrentUser(EntityModel model)
        {
            if (DWKitRuntime.Security.CheckPermission("Documents", "ViewAll"))
            {
                return Filter.Empty;
            }
            
            var userId = DWKitRuntime.Security.CurrentUser?.GetOperationUserId();
            
            return GetViewFilterForUserPrivate(model, userId);
        }

        private static Filter GetViewFilterForUserPrivate(EntityModel model, Guid? userId)
        {
            var filter = Filter.Or.Equal(userId, "AuthorId");
            var filter2 = Filter.Empty;
            if (model.Attributes.Any(c => c.Name == "EmployeeId"))
            {
                filter2 = filter2.Merge(Filter.Or.Equal(userId, "EmployeeId"));
            }

            if (model.Attributes.Any(c => c.Name == "Employees"))
            {
                filter2 = filter2.Merge(Filter.Or.LikeRightLeft(userId.ToString(), "Employees"));
            }

            return filter.Merge(filter2);
        }
    }
}
