using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class ImageContentBoxResult
    {
        public int ImageContentBoxID { get; set; }
        public int ImageContentBoxTypeID { get; set; }
        public long TitleTranslationID { get; set; }
        public long DescriptionTranslationID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string LinkURL { get; set; }
        public bool IsActive { get; set; }
        public string ImagePath { get; set; }
        public DateTime CreateDate { get; set; }
        public long CreateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
        public long? UpdateBy { get; set; }

    }

    public class EditImageContentBoxResult
    {
        public int ImageContentBoxID { get; set; }
        public int ImageContentBoxTypeID { get; set; }
        public long TitleTranslationID { get; set; }
        public long DescriptionTranslationID { get; set; }
        public string TitleEnglish { get; set; }
        public string TitleArabic { get; set; }
        public string DescriptionEnglish { get; set; }
        public string DescriptionArabic { get; set; }
        public string LinkURL { get; set; }
        public bool IsActive { get; set; }
        public string ImagePath { get; set; }
        public DateTime CreateDate { get; set; }
        public long CreateBy { get; set; }
        public DateTime? UpdateDate { get; set; }
        public long? UpdateBy { get; set; }

    }
}
