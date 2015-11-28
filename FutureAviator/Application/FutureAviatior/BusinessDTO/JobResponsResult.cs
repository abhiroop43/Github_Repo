using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class JobResponsResult
    {
        public long ResponseID { get; set; }
        public long UserID { get; set; }
        public string UserDisplayName { get; set; }
        public long JobID { get; set; }
        public string JobTitle { get; set; }
        public DateTime AppliedDate { get; set; }
        public DateTime JobExpiryDate { get; set; }
        
    }
}
