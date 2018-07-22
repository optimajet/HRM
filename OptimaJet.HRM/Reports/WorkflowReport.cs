using OptimaJet.DWKit.Core;
using OptimaJet.HRM.Model;
using System;
using System.Linq;
using System.Text;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace OptimaJet.HRM.Reports
{
    public class WorkflowReportItem
    {
        public string Type;
        public int Count = 0;
        public int DraftDocCount = 0;
        public int FinalDocCount = 0;
        public int OtherDocCount = 0;
        public string AvrApprovalStr;
        public string MinApprovalStr;
        public string MaxApprovalStr;
        public TimeSpan AvrApprovalTime;
        public TimeSpan MinApprovalTime;
        public TimeSpan MaxApprovalTime;
    }

    public class WorkflowReport
    {
        public readonly static List<string> DraftStates = new List<string>(){ "Draft" };
        public readonly static List<string> FinalStates = new List<string>(){ "Agreed", "Final", "Approved" };

        public async static Task<object> Generate(DateTime? datefrom, DateTime? dateto)
        {
            var res = new Dictionary<string, WorkflowReportItem>();

            var filter = Filter.Empty;
            var filter2 = Filter.Empty;
            if (datefrom.HasValue)
            {
                filter = Filter.And.GreaterOrEqual(datefrom.Value, "Date");
                filter2 = Filter.And.GreaterOrEqual(datefrom.Value, "DocumentDate");
            }

            if (dateto.HasValue)
            {
                filter = filter.Merge(Filter.And.LessOrEqual(dateto.Value, "Date"));
                filter2 = filter2.Merge(Filter.And.LessOrEqual(dateto.Value, "DocumentDate"));
            }

            var documents = await Document.SelectAsync(filter);
            filter2 = filter2.Merge(Filter.And.NotEqual(Null.Value, "TransitionTime"));
            var documentTransitions = await DocumentTransitionHistory.SelectAsync(filter2);

            var stats = new Dictionary<string, List<TimeSpan>>();
            foreach (var d in documents)
            {
                if (!res.ContainsKey(d.Type))
                    res[d.Type] = new WorkflowReportItem() { Type = d.Type };

                res[d.Type].Count++;

                if (DraftStates.Contains(d.State))
                    res[d.Type].DraftDocCount += 1;
                else if (FinalStates.Contains(d.State))
                {
                    res[d.Type].FinalDocCount += 1;
                    var history = documentTransitions.Where(c => c.DocumentId == d.Id && c.EmployeeId.HasValue);
                    var minDate = history.Min(c => c.TransitionTime);
                    var maxDate = history.Max(c => c.TransitionTime);
                    if (minDate.HasValue && maxDate.HasValue)
                    {
                        var delta = (maxDate - minDate).Value;
                        if (!stats.ContainsKey(d.Type))
                            stats[d.Type] = new List<TimeSpan>();

                        stats[d.Type].Add(delta);

                        if (res[d.Type].MinApprovalTime == null || res[d.Type].MinApprovalTime.Ticks == 0 || res[d.Type].MinApprovalTime > delta)
                            res[d.Type].MinApprovalTime = delta;

                        if (res[d.Type].MaxApprovalTime == null || res[d.Type].MaxApprovalTime < delta)
                            res[d.Type].MaxApprovalTime = delta;
                    }
                }
                else
                {
                    res[d.Type].OtherDocCount += 1;
                }
            }

            foreach(var s in stats)
            {
                var sumSpan = new TimeSpan();
                s.Value.ForEach(c => { sumSpan += c; });
                res[s.Key].AvrApprovalTime = new TimeSpan((long) (sumSpan.Ticks / s.Value.Count));

                res[s.Key].MinApprovalStr = TimeSpanFormat(res[s.Key].MinApprovalTime);
                res[s.Key].MaxApprovalStr = TimeSpanFormat(res[s.Key].MaxApprovalTime);
                res[s.Key].AvrApprovalStr = TimeSpanFormat(res[s.Key].AvrApprovalTime);
            }

            return res.OrderBy(c=>c.Key).Select(c => c.Value).ToList();
        }

        private static string TimeSpanFormat(TimeSpan p)
        {
            StringBuilder res = new StringBuilder();
            bool f = false;
            if (p.Days > 0)
            {
                res.AppendFormat("{0}d", p.Days);
                f = true;
            }
            if (f || p.Hours > 0)
            {
                res.AppendFormat("{0}{1}h", f ? " " : "", p.Hours);
                f = true;
            }
            if (f || p.Minutes > 0)
            {
                res.AppendFormat("{0}{1}m", f ? " " : "", p.Minutes);
                f = true;
            }
            if (f || p.Seconds > 0)
                res.AppendFormat("{0}{1}s", f ? " " : "", p.Seconds);

            return res.ToString();
        }
    }
}
