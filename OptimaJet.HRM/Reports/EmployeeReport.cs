using OptimaJet.DWKit.Core;
using OptimaJet.DWKit.Core.Model;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using OptimaJet.HRM.Model;

namespace OptimaJet.HRM.Reports
{
    public class EmployeeReport
    {
        public static async Task<object> GenerateForDashboard(DateTime dateFrom, DateTime dateTo)
        {
            EntityModel employeeSalaryModel = await MetadataToModelConverter.GetEntityModelByModelAsync("EmployeeSalary", 0);

            var employees = await Employee.SelectAsync(Filter.Empty, Order.StartAsc("DepartmentName").Asc("LocationName").Asc("Name"));
            var employeeSalaryList = await employeeSalaryModel.GetAsync(Filter.Empty);

            DateTime start = new DateTime(dateFrom.Year, dateFrom.Month, 1);
            DateTime end = new DateTime(dateTo.Year, dateTo.Month, 1).AddMonths(1).AddSeconds(-1);

            DateTime currentDate = new DateTime(dateFrom.Year, dateFrom.Month, 1);

            var labels = new List<string>();
            var employeeData = new List<int>();
            var salaryData = new List<decimal>();
            var taxData = new List<decimal>();

            while (currentDate < dateTo)
            {
                var item = new Dictionary<string, object>();
                int employeeCount = 0;
                decimal salary = 0;
                decimal tax = 0;

                foreach (var emp in employees)
                {
                    if (emp.DateJoin > currentDate || currentDate > emp.DateLeft)
                        continue;

                    employeeCount++;
                    salary += GetSalary(emp, employeeSalaryList, currentDate, 0);
                    tax += GetTax(emp, employeeSalaryList, currentDate, 0);
                }

                labels.Add(currentDate.ToString("MM/yy"));
                employeeData.Add(employeeCount);
                salaryData.Add(salary);
                taxData.Add(tax);
                
                currentDate = currentDate.AddMonths(1);
            }

            return new {
                labels,
                datasets = new List<object>() {
                    new {
                        label = "Employees",
                        borderColor = "#1362E2",
                        backgroundColor = "#1362E2",
                        fill = false,
                        data = employeeData,
                        yAxisID = "y-axis-1",
                    },
                    new {
                        label = "Salary",
                        borderColor = "#FB617D",
                        backgroundColor = "#FB617D",
                        fill = false,
                        data = salaryData,
                        yAxisID = "y-axis-2",
                    },
                    new {
                        label = "Tax",
                        borderColor = "#FEB64D",
                        backgroundColor = "#FEB64D",
                        fill = false,
                        data = taxData,
                        yAxisID = "y-axis-2",
                    }
                }
            };
        }

        public static async Task<object> Generate(DateTime dateFrom, DateTime dateTo, string parameter, int period)
        {
            EntityModel employeeSalaryModel = await MetadataToModelConverter.GetEntityModelByModelAsync("EmployeeSalary", 0);
            
            var employees = await Employee.SelectAsync(Filter.Empty, Order.StartAsc("DepartmentName").Asc("LocationName").Asc("Name"));
            var employeeSalaryList = await employeeSalaryModel.GetAsync(Filter.Empty);

            DateTime start, end;
            if(period == 0)// month
            {
                start = new DateTime(dateFrom.Year, dateFrom.Month, 1);
                end = new DateTime(dateTo.Year, dateTo.Month, 1).AddMonths(1).AddSeconds(-1);
            }
            else //year
            {
                start = new DateTime(dateFrom.Year, 1, 1, 0, 0, 0);
                end = new DateTime(dateFrom.Year, 1, 1, 0, 0, 0).AddYears(1).AddSeconds(-1);
            }

            #region Documents
            EntityModel businessTripModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.BusinessTrip, 1);
            EntityModel sickLeaveModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.SickLeave, 1);
            EntityModel compensationModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Compensation, 1);
            EntityModel vacationModel = await MetadataToModelConverter.GetEntityModelByModelAsync(DocumentTypes.Vacation, 1);

            var periodFilter = Filter.And.LessOrEqual(end, "DateStart").GreaterOrEqual(start, "DateEnd");
            var dateFilter = Filter.And.GreaterOrEqual(start, "Date").LessOrEqual(end, "Date");

            var periodAndStateFilter = Filter.And.In(WorkflowReport.FinalStates, "State").Merge(periodFilter);
            var dateAndStateFilter = Filter.And.In(WorkflowReport.FinalStates, "State").Merge(dateFilter);
            var businessTrips = await businessTripModel.GetAsync(Filter.And.Equal("BusinessTrip", "Type").Merge(periodAndStateFilter));
            businessTrips.ForEach((item) =>
            {
                var i = (dynamic)item;
                if (!string.IsNullOrEmpty(i.Employees))
                {
                    i.EmployeesList = JsonConvert.DeserializeObject<List<Guid>>(i.Employees);
                }
            });
          
            var sickLeaves = await sickLeaveModel.GetAsync(DocumentTypes.GetFilter(DocumentTypes.SickLeave).Merge(periodAndStateFilter));
            var compensations = await compensationModel.GetAsync(DocumentTypes.GetFilter(DocumentTypes.Compensation).Merge(dateAndStateFilter));
            var vacations = await vacationModel.GetAsync(DocumentTypes.GetFilter(DocumentTypes.Vacation).Merge(periodAndStateFilter));

            #endregion

            var res = new List<Dictionary<string, object>>();
            foreach (var emp in employees)
            {
                var item = new Dictionary<string, object>();
                item["Id"] = emp.Id;
                item["Department"] = emp.DepartmentName;
                item["Location"] = emp.LocationName;
                item["Name"] = emp.Name;
                item["Title"] = emp.Title;

                DateTime currentDate = period == 0 ? 
                    new DateTime(dateFrom.Year, dateFrom.Month, 1) : 
                    new DateTime(dateFrom.Year, 1, 1);
                while (currentDate < dateTo)
                {
                    var key = period == 0 ? currentDate.ToString("MM/yy") : currentDate.ToString("yyyy") + "Y";
                    switch (parameter)
                    {
                        case "totalamount":
                            var salary = GetSalary(emp, employeeSalaryList, currentDate, period);
                            var tax = GetTax(emp, employeeSalaryList, currentDate, period);
                            var compensation = GetCompensation(emp.Id, compensations, currentDate, period);
                            item[key] = (salary + tax + compensation).ToString("N");
                            break;
                        case "salary":
                            item[key] = GetSalary(emp, employeeSalaryList, currentDate, period).ToString("N");
                            break;
                        case "tax":
                            item[key] = GetTax(emp, employeeSalaryList, currentDate, period).ToString("N");
                            break;
                        case "compensation":
                            item[key] = GetCompensation(emp.Id, compensations, currentDate, period).ToString("N");
                            break;
                        case "tripdays":
                            item[key] = GetTripDays(emp.Id, businessTrips, currentDate, period);
                            break;
                        case "sickleavedays":
                            item[key] = GetSickLeaveDays(emp.Id, sickLeaves, currentDate, period);
                            break;
                        case "vacationdays":
                            item[key] = GetVacationDays(emp.Id, vacations, currentDate, period);
                            break;
                    }
                    currentDate = period == 0 ? currentDate.AddMonths(1) : currentDate.AddYears(1);
                }

                res.Add(item);
            }

            return res;
        }

        private static decimal GetTax(Employee emp, List<DynamicEntity> employeeSalaryList, DateTime date, int period)
        {
            decimal tax = 0;
            if (emp.DateJoin > date || date > emp.DateLeft)
                return tax;

            if (period == 1)
            {
                for (int i = 1; i <= 12; i++)
                {
                    tax += GetTax(emp, employeeSalaryList, new DateTime(date.Year, i, 1, 0, 0, 0), 0);
                }
            }
            else
            {
                bool isFind = false;
                decimal salary = emp.Salary != null ? emp.Salary.Value : 0;
                decimal taxRate = 0;
                
                for (int i = 0; i < employeeSalaryList.Count; i++)
                {
                    var item = employeeSalaryList[i] as dynamic;
                    if (item.EmployeeId == emp.Id && InPeriod(item.DateFrom, item.DateTo, date, 0))
                    {
                        if (item.Salary != null)
                        {
                            salary = (decimal)item.Salary;
                            isFind = true;
                        }

                        if (item.AverageTaxRate != null)
                        {
                            taxRate = (decimal)(double)item.AverageTaxRate;
                            isFind = true;
                        }

                        if(isFind)
                            break;
                    }
                }

                if (!isFind)
                {
                    for (int i = 0; i < employeeSalaryList.Count; i++)
                    {
                        var item = employeeSalaryList[i] as dynamic;
                        if (item.EmployeeId == null && InPeriod(item.DateFrom, item.DateTo, date, 0))
                        {   
                            if (item.AverageTaxRate != null)
                            {
                                taxRate = (decimal)(double)item.AverageTaxRate;
                                isFind = true;
                            }

                            if (isFind)
                                break;
                        }
                    }
                }

                if (!isFind && emp.AverageTaxRate == null)
                {
                    var defaultItem = employeeSalaryList.Where(c => c.Dictionary["EmployeeId"] == null &&
                        c.Dictionary["DateFrom"] == null && c.Dictionary["DateTo"] == null).FirstOrDefault();
                    if(defaultItem != null && defaultItem.Dictionary["AverageTaxRate"] != null)
                    {
                        taxRate = (decimal)(double)defaultItem.Dictionary["AverageTaxRate"];
                    }
                }

                if (emp.AverageTaxRate != null)
                    taxRate = emp.AverageTaxRate.Value;

                tax = salary * (taxRate / 100);
            }
            return tax;
        }

        private static decimal GetSalary(Employee emp, List<DynamicEntity> employeeSalaryList, DateTime date, int period)
        {
            decimal salary = 0;

            if (emp.DateJoin > date || date > emp.DateLeft)
                return salary;

            if (period == 1)
            {
                for (int i = 1; i <= 12; i++)
                {
                    salary += GetSalary(emp, employeeSalaryList, new DateTime(date.Year, i, 1, 0, 0, 0), 0);
                }
            }
            else
            {
                bool isFind = false;
                for (int i = 0; i < employeeSalaryList.Count; i++)
                {
                    var item = employeeSalaryList[i] as dynamic;
                    if (item.EmployeeId == emp.Id && emp.Salary != null && InPeriod(item.DateFrom, item.DateTo, date, 0))
                    {
                        salary = (decimal)item.Salary;
                        isFind = true;
                        break;
                    }
                }

                if (!isFind && emp.Salary != null)
                {
                    salary = emp.Salary.Value;
                }
            }
            return salary;
        }

        private static decimal GetCompensation(Guid id, List<DynamicEntity> compensations, DateTime date, int period)
        {
            decimal res = 0;
            compensations.ForEach((item) =>
            {
                dynamic i = item as dynamic;
                if (i.EmployeeId == id)
                {
                    if (i.Date != null && i.Amount != null && InPeriod(i.Date, date, period))
                        res += i.Amount;
                }
            });
            return res;
        }

        private static int GetVacationDays(Guid id, List<DynamicEntity> vacations, DateTime date, int period)
        {
            int res = 0;
            vacations.ForEach((item) =>
            {
                dynamic i = item as dynamic;
                if (i.EmployeeId == id)
                {
                    if (i.DateStart != null && i.DateEnd != null && i.DateEnd > i.DateStart)
                    {
                        res += GetDaysInPeriod(i.DateStart, i.DateEnd, date, period);
                    }
                }
            });
            return res;
        }

        private static int GetSickLeaveDays(Guid id, List<DynamicEntity> sickLeaves, DateTime date, int period)
        {
            int res = 0;
            sickLeaves.ForEach((item) =>
            {
                dynamic i = item as dynamic;
                if (i.EmployeeId == id)
                {
                    if (i.DateStart != null && i.DateEnd != null && i.DateEnd > i.DateStart)
                    {
                        res += GetDaysInPeriod(i.DateStart, i.DateEnd, date, period);
                    }
                }
            });
            return res;
        }

        private static int GetTripDays(Guid id, List<DynamicEntity> businessTrips, DateTime date, int period)
        {
            int res = 0;
            businessTrips.ForEach((item) =>
            {
                dynamic i = item as dynamic;
                if (item.Dictionary.ContainsKey("EmployeesList") && item["EmployeesList"] != null) {
                    var list = (List<Guid>)i.EmployeesList;
                    if (list.Contains(id))
                    {
                        if(i.DateStart != null && i.DateEnd != null)
                        {
                            res += GetDaysInPeriod(i.DateStart, i.DateEnd, date, period);
                        }
                    }
                }
            });
            return res;
        }

        private static bool InPeriod(DateTime? dateFrom, DateTime? dateTo, DateTime date, int period)
        {
            if (dateFrom == null || dateTo == null)
                return false;

            if (period == 0)
            {
                var k1 = dateFrom.Value.Year * 12 + dateFrom.Value.Month;
                var k2 = dateTo.Value.Year * 12 + dateTo.Value.Month;
                var p = date.Year * 12 + date.Month;
                if (k1 <= p && p <= k2)
                {
                    return true;
                }
            }
            else if (period == 1)
            {
                if (dateFrom.Value.Year <= date.Year && date.Year <= dateTo.Value.Year)
                    return true;
            }

            return false;
        }

        private static bool InPeriod(DateTime date, DateTime? periodDate, int period)
        {
            if (periodDate == null)
                return false;

            if(period == 0)
            {
                if (date.Year == periodDate.Value.Year && date.Month == periodDate.Value.Month) 
                    return true;
            }
            else if(period == 1)
            {
                if (date.Year == periodDate.Value.Year)
                    return true;
            }

            return false;
        }

        private static int GetDaysInPeriod(DateTime dateStart, DateTime dateEnd, DateTime date, int period)
        {
            DateTime start, end;
            if(period == 0)
            {
                start = new DateTime(date.Year, date.Month, 1, 0, 0, 0);
                end = new DateTime(date.Year, date.Month, 1, 0, 0, 0).AddMonths(1).AddSeconds(-1);
            }
            else
            {
                start = new DateTime(date.Year, 1, 1);
                end = new DateTime(date.Year, 1, 1).AddYears(1).AddSeconds(-1);
            }

            if (dateEnd < start || dateStart > end)
                return 0;

            if (dateStart > start)
                start = dateStart;

            if (dateEnd < end)
                end = dateEnd;
            
            var res = (end - start).Days + 1;
            if (res < 0)
                res = 0;
            return res;
        }
    }
}
