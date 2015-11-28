using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class EventResult
    {
        public int EventID { get; set; }
        public DateTime EventFromDate { get; set; }
        public DateTime EventToDate { get; set; }
        public string EventName { get; set; }
        public string EventVenue { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string EnglishFileName { get; set; }
        public string ArabicFileName { get; set; }
        public string DetailType { get; set; }
        public string ExternalURL { get; set; }
    }
}
