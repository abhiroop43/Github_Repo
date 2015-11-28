using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;
using FutureAviator.Utlitity;

namespace FutureAviator.UserControls
{
    public partial class PhotoGallery : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                    BindGalleryImages(Convert.ToInt32(Request.QueryString["id"]));
            }
        }
        private void BindGalleryImages(int GalleryCategoryID)
        {
            try
            {
                using (DAL_PhotoGallery dalPhotoGallery = new DAL_PhotoGallery())
                {
                    GalleryResult galleryResult = dalPhotoGallery.GetPhotoGallery(SessionManager.CurrentUser().LanguageCode, GalleryCategoryID);
                    if (galleryResult != null)
                    {
                        lblCategoryTitle.Text = galleryResult.GalleryTitle;
                        lblCategoryDescription.Text = galleryResult.GalleryDescription;
                        if(galleryResult.GalleryPhotos != null && galleryResult.GalleryPhotos.Count > 0)
                        {
                            dlGallery.DataSource = galleryResult.GalleryPhotos;
                            dlGallery.DataBind();
                        }
                        else
                        {
                            lblStatus.Text = "No photo saved under this category.";
                        }
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