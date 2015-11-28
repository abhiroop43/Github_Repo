using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class SliderResult
    {
        public long SliderID { get; set; }
        public long TitleTranslationID { get; set; }
        public long SubTitleTranlationID { get; set; }
        public long ButtonTextTransaltionID { get; set; }
        public string Title { get; set; }
        public string SubTitle { get; set; }
        public string ButtonText { get; set; }
        public string ButtonLink { get; set; }
        public string ImagePath { get; set; }
        public string LanguageCode { get; set; }
        public bool IsActive { get; set; }

    }

    public class EditSliderResult
    {
        public long SliderID { get; set; }
        public long TitleTranslationID { get; set; }
        public long SubTitleTranlationID { get; set; }
        public long ButtonTextTransaltionID { get; set; }
        public string TitleEnglish { get; set; }
        public string TitleArabic { get; set; }
        public string SubTitleEnglish { get; set; }
        public string SubTitleArabic { get; set; }
        public string ButtonTextEnglish { get; set; }
        public string ButtonTextArabic { get; set; }
        public string ButtonLink { get; set; }
        public string ImagePath { get; set; }
        public bool IsActive { get; set; }

    }
}
