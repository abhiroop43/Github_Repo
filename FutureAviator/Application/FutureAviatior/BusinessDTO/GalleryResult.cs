using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class GalleryResult
    {
        public string GalleryTitle { get; set; }
        public string GalleryDescription { get; set; }
        public List<GallaryPhoto> GalleryPhotos { get; set; }
    }


    public class GallaryPhoto
    {
        public long PhotoGalleryID { get; set; }
        public long PhotoGalleryCategoryID { get; set; }
        public string ImagePath { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }

    }
}
