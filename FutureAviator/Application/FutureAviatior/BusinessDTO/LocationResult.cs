using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class LocationResult
    {
        public int LocationID { get; set; }
        public string LocationName { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
        public long LocationNameTranslationID { get; set; }
    }

    public class EditLocationResult
    {
        public int LocationID { get; set; }
        public long LocationNameTranslationID { get; set; }
        public string LocationNameEnglish { get; set; }
        public string LocationNameArabic { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
    }
}
