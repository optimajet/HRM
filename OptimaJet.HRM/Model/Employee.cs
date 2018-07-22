using OptimaJet.DWKit.Core.ORM;
using System;
using System.Collections.Generic;
using System.Text;

namespace OptimaJet.HRM.Model
{
    public class Employee : DbObject<Employee>
    {
        public Employee() : base(true)
        {
        }

        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }

        [DbObjectModel]
        public string FirstName
        {
            get => _entity.FirstName;
            set => _entity.FirstName = value;
        }

        [DbObjectModel]
        public string LastName
        {
            get => _entity.LastName;
            set => _entity.LastName = value;
        }

        [DbObjectModel]
        public string MiddleName
        {
            get => _entity.MiddleName;
            set => _entity.MiddleName = value;
        }

        [DbObjectModel]
        public string Name
        {
            get => _entity.Name;
            set => _entity.Name = value;
        }

        [DbObjectModel]
        public string Email
        {
            get => _entity.Email;
            set => _entity.Email = value;
        }

        [DbObjectModel]
        public Guid? LocationId
        {
            get => _entity.LocationId;
            set => _entity.LocationId = value;
        }

        [DbObjectModel(TableType = typeof(Location), ParentPropertyName = "LocationId", ColumnName = "Name")]
        public string LocationName
        {
            get => _entity.LocationName;
            set => _entity.LocationName = value;
        }

        [DbObjectModel]
        public string Groups
        {
            get => _entity.Groups;
            set => _entity.Groups = value;
        }

        [DbObjectModel]
        public Guid? DepartmentId
        {
            get => _entity.DepartmentId;
            set => _entity.DepartmentId = value;
        }

        [DbObjectModel(TableType = typeof(Department), ParentPropertyName = "DepartmentId", ColumnName = "Name")]
        public string DepartmentName
        {
            get => _entity.DepartmentName;
            set => _entity.DepartmentName = value;
        }
        
        [DbObjectModel]
        public string Title
        {
            get => _entity.Title;
            set => _entity.Title = value;
        }

        [DbObjectModel]
        public string SourceHire
        {
            get => _entity.SourceHire;
            set => _entity.SourceHire = value;
        }

        [DbObjectModel]
        public DateTime? DateJoin
        {
            get => _entity.DateJoin;
            set => _entity.DateJoin = value;
        }

        [DbObjectModel]
        public DateTime? DateLeft
        {
            get => _entity.DateLeft;
            set => _entity.DateLeft = value;
        }

        [DbObjectModel]
        public string SeatingLocation
        {
            get => _entity.SeatingLocation;
            set => _entity.SeatingLocation = value;
        }

        [DbObjectModel]
        public string Type
        {
            get => _entity.Type;
            set => _entity.Type = value;
        }

        [DbObjectModel]
        public DateTime BirthDate
        {
            get => _entity.BirthDate;
            set => _entity.BirthDate = value;
        }

        [DbObjectModel]
        public string State
        {
            get => _entity.State;
            set => _entity.State = value;
        }

        [DbObjectModel]
        public int? NumberId
        {
            get => _entity.NumberId;
            set => _entity.NumberId = value;
        }

        [DbObjectModel]
        public decimal? Rate
        {
            get => _entity.Rate;
            set => _entity.Rate = value;
        }

        [DbObjectModel]
        public decimal? Salary
        {
            get => _entity.Salary;
            set => _entity.Salary = value;
        }

        [DbObjectModel]
        public decimal? AverageTaxRate
        {
            get => _entity.AverageTaxRate;
            set => _entity.AverageTaxRate = value;
        }
    }

    public class Location : DbObject<Location>
    {
        public Location() : base(true)
        {
        }

        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }

        [DbObjectModel]
        public string Name
        {
            get => _entity.Name;
            set => _entity.Name = value;
        }
    }

    public class Department : DbObject<Department>
    {
        public Department() : base(true)
        {
        }

        [DbObjectModel(IsKey = true)]
        public Guid Id
        {
            get => _entity.Id;
            set => _entity.Id = value;
        }

        [DbObjectModel]
        public string Name
        {
            get => _entity.Name;
            set => _entity.Name = value;
        }
    }
}