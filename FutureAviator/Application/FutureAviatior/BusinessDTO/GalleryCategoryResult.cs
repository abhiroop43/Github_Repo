using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class GalleryCategoryResult
    {
        public int PhotoGalleryCategoryID { get; set; }
        public long CategoryTitleTranslationID { get; set; }
        public string CategoryTitle { get; set; }
        public long CategoryDescriptionTranslationID { get; set; }
        public string CategoryDescription { get; set; }
        public string CategoryImage { get; set; }
        public DateTime CreateDate { get; set; }
        public bool IsActive { get; set; }
    }

    public class EditGalleryCategoryResult
    {
        public int PhotoGalleryCategoryID { get; set; }
        public long CategoryTitleTranslationID { get; set; }
        public string CategoryTitleEnglish { get; set; }
        public string CategoryTitleArabic { get; set; }
        public long CategoryDescriptionTranslationID { get; set; }
        public string CategoryDescriptionEnglish { get; set; }
        public string CategoryDescriptionArabic { get; set; }
        public string CategoryImage { get; set; }
        public DateTime CreateDate { get; set; }
        public bool IsActive { get; set; }
    }
}
