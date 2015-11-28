using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;

namespace FutureAviator.UserControls
{
    public partial class GalleryCategory : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGalleryCategory();
                BindGalleryImages();
            }
        }

        private void BindGalleryCategory()
        {
            try
            {
                using (DAL_PhotoGalleryCategory dalGalleryCategory = new DAL_PhotoGalleryCategory())
                {
                    List<GalleryCategoryResult> galleryCategories = dalGalleryCategory.GetAllActivePhotoGalleryCategories(SessionManager.CurrentUser().LanguageCode, LanguageContentType.GalleryCategoryTitle);
                    if (galleryCategories != null && galleryCategories.Count > 0)
                    {

                        rptgalleryCategories.DataSource = galleryCategories;
                        rptgalleryCategories.DataBind();
                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        private void BindGalleryImages()
        {
            try
            {
                using (DAL_PhotoGallery dalGallery = new DAL_PhotoGallery())
                {
                    List<DataAccess.PhotoGallery> result = dalGallery.GetAllActiveGalleryPhotos();
                    if (result != null && result.Count > 0)
                    {
                        rptGalleryImages.DataSource = result;
                        rptGalleryImages.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
    }
}