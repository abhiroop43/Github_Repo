using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class PrivacyPolicyResult
    {
        public long ID { get; set; }
        public string PolicyContent { get; set; }
        public long CreateBy { get; set; }
        public DateTime CreateDate { get; set; }
        public long? UpdateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
    }
}
