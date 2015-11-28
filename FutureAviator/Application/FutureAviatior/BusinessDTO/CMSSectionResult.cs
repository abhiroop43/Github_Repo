using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class CMSSectionResult
    {
        public int ID { get; set; }
        public string SectionName { get; set; }
        public string SectionText { get; set; }
        public string Status { get; set; }
        public int SectionTypeID { get; set; }
    }
}
