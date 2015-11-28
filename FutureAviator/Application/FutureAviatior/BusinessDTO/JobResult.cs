using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class JobResult
    {
        public long JobID { get; set; }
        public string JobTitle { get; set; }
        public long JobTitleTranslationID { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public int IndustryID { get; set; }
        public string IndustryName { get; set; }
        public string JobDescription { get; set; }
        public long JobDescriptionTranslationID { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ExpiryDate { get; set; }
        public string Keywords { get; set; }
        public bool IsAlreadyApplied { get; set; }
        public bool IsActive { get; set; }
        
    }

    public class EditJobResult
    {
        public long JobID { get; set; }
        public string JobTitleEnglish { get; set; }
        public string JobTitleArabic { get; set; }
        public long JobTitleTranslationID { get; set; }
        public int CountryID { get; set; }
        public string CountryName { get; set; }
        public int IndustryID { get; set; }
        public string IndustryName { get; set; }
        public string JobDescriptionEnglish { get; set; }
        public string JobDescriptionArabic { get; set; }
        public long JobDescriptionTranslationID { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime ExpiryDate { get; set; }
        public string Keywords { get; set; }
        public bool IsActive { get; set; }

    }
}
