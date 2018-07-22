using OptimaJet.DWKit.Core.ORM;
using System;
using System.Collections.Generic;
using System.Text;

namespace OptimaJet.HRM.Model
{
    public class DocumentTransitionHistory : DbObject<DocumentTransitionHistory>
    {
        public DocumentTransitionHistory() : base(true)
        {
        }

        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }

        [DbObjectModel]
        public Guid DocumentId
        {
            get => _entity.DocumentId;
            set => _entity.DocumentId = value;
        }

        [DbObjectModel(TableType = typeof(Document), ParentPropertyName = "DocumentId", ColumnName = "Date")]
        public DateTime DocumentDate
        {
            get => _entity.DocumentDate;
            set => _entity.DocumentDate = value;
        }

        [DbObjectModel(TableType = typeof(Document), ParentPropertyName = "DocumentId", ColumnName = "Type")]
        public string DocumentType
        {
            get => _entity.DocumentType;
            set => _entity.DocumentType = value;
        }

        [DbObjectModel]
        public Guid? EmployeeId
        {
            get => _entity.EmployeeId;
            set => _entity.EmployeeId = value;
        }

        [DbObjectModel]
        public DateTime? TransitionTime
        {
            get => _entity.TransitionTime;
            set => _entity.TransitionTime = value;
        }

        [DbObjectModel]
        public int? Order
        {
            get => _entity.Order;
            set => _entity.Order = value;
        }
        
        [DbObjectModel]
        public string InitialState
        {
            get => _entity.InitialState;
            set => _entity.InitialState = value;
        }

        [DbObjectModel]
        public string DestinationState
        {
            get => _entity.DestinationState;
            set => _entity.DestinationState = value;
        }

        [DbObjectModel]
        public string Command
        {
            get => _entity.Command;
            set => _entity.Command = value;
        }

        [DbObjectModel]
        public string AllowedToEmployeeNames
        {
            get => _entity.AllowedToEmployeeNames;
            set => _entity.AllowedToEmployeeNames = value;
        }
    }
}
