using OptimaJet.DWKit.Core;
using OptimaJet.HRM.Model;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using OptimaJet.DWKit.Core.Model;

namespace OptimaJet.HRM
{
    public class SearchItem
    {
        public string Id;
        public string Type;
        public string Title;
        public string Text;
    }

    public class Search
    {
        public static async Task<IEnumerable<SearchItem>> GetAsync(string term)
        {
            if (string.IsNullOrWhiteSpace(term))
                return new List<SearchItem>();

            var employeeFilter = Filter.Or
                .LikeRightLeft(term, "Name")
                .LikeRightLeft(term, "Email")
                .LikeRightLeft(term, "PhoneWork")
                .LikeRightLeft(term, "OtherEmail")
                .LikeRightLeft(term, "PhoneMobile")
                .LikeRightLeft(term, "Title");

            EntityModel employeeModel = await MetadataToModelConverter.GetEntityModelByModelAsync("Employee", 0);

            int countLimit = 20;
            var employee = await employeeModel.GetAsync(employeeFilter);
            var res = employee.Select(c => new SearchItem()
            {
                Id = c.Dictionary["Id"].ToString(),
                Type = "employee",
                Text = c.Dictionary["Name"] as string,
                Title = string.Format("{0} {1} {2}", c.Dictionary["Name"], c.Dictionary["Email"], c.Dictionary["Title"])
            }).Take(countLimit).ToList();

            if(employee.Count > countLimit)
            {
                res.Add(new SearchItem() {
                        Text = "...",
                        Title = "..."
                });
            }
            
            return res;
        }
    }
}
