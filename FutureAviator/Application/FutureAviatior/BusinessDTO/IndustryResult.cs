using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class IndustryResult
    {
        public int IndustryID { get; set; }
        public long IndustryNameTranslationID { get; set; }
        public string IndustryName { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
    }
    public class EditIndustryResult
    {
        public int IndustryID { get; set; }
        public long IndustryNameTranslationID { get; set; }
        public string IndustryNameEnglish { get; set; }
        public string IndustryNameArabic { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
    }
}
