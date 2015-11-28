using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class NewsResult
    {
        public long NewsID { get; set; }
        public long NewsTitleTranslationID { get; set; }
        public string NewsTitle { get; set; }
        public string NewsDescription { get; set; }
        public long NewsDescriptionTranslationID { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
        public string ImagePath { get; set; }
        public DateTime? PressReleaseDate { get; set; }
    }

    public class EditNewsResult
    {
        public long NewsID { get; set; }
        public long NewsTitleTranslationID { get; set; }
        public string NewsTitleEnglish { get; set; }
        public string NewsTitleArabic { get; set; }
        public string NewsDescriptionEnglish { get; set; }
        public long NewsDescriptionTranslationID { get; set; }
        public string NewsDescriptionArabic { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
        public string ImagePath { get; set; }
        public DateTime? PressReleaseDate { get; set; }
    }
}
