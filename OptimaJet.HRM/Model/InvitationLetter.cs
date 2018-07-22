using OptimaJet.DWKit.Core.ORM;
using System;
using System.Collections.Generic;
using System.Text;

namespace OptimaJet.HRM.Model
{
    public class InvitationLetter : DbObject<InvitationLetter>
    {
        public InvitationLetter() : base(true)
        {
        }
        
        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }
        
        [DbObjectModel]
        public Guid EmployeeId
        {
            get => _entity.EmployeeId;
            set => _entity.EmployeeId = value;
        }

        [DbObjectModel]
        public DateTime Date
        {
            get => _entity.Date;
            set => _entity.Date = value;
        }

        [DbObjectModel]
        public DateTime DateExpired
        {
            get => _entity.DateExpired;
            set => _entity.DateExpired = value;
        }
    }
}
