using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;
using FutureAviator.Utlitity;
using ExceptionLogger;

namespace FutureAviator.UserControls
{
    public partial class Admin_AllGalleryCategories : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MessageType"] != null)
                {
                    if (Convert.ToString(Request.QueryString["MessageType"]).Trim().ToLower() == "successupdate")
                    {
                        Helper.ShowNotification("Update Successfully", UINotificationType.Success);
                    }
                }
                BindGrid();
            }
        }

        protected void gv_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gv.Rows.Count > 0)
                {
                    gv.UseAccessibleHeader = true;
                    gv.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gv.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
        }
        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                string[] param = Convert.ToString(e.CommandArgument).Split('~');

                int CategoryID = Convert.ToInt32(param[0]);
                int TitleTranslationID = Convert.ToInt32(param[1]);
                int DescriptionTranslationID = Convert.ToInt32(param[2]);
                string ImageName = Convert.ToString(param[3]);

                bool CategoryHasImages = false;
                using (DAL_PhotoGallery dal = new DAL_PhotoGallery())
                {
                    GalleryResult result = dal.GetPhotoGallery(ApplicationLanguages.en, CategoryID);
                    if (result != null && result.GalleryPhotos != null && result.GalleryPhotos.Count > 0)
                    {
                        CategoryHasImages = true;
                    }
                }
                if (!CategoryHasImages)
                {
                    if (Helper.DeleteFile(FileUploadType.GalleryCategoryImage, ImageName))
                    {
                        using (DAL_PhotoGalleryCategory dal = new DAL_PhotoGalleryCategory())
                        {
                            if (dal.DeletePhotoGalleryCategory(CategoryID))
                            {
                                DBHelper.DeleteLanguageContent(TitleTranslationID);
                                DBHelper.DeleteLanguageContent(DescriptionTranslationID);
                                Helper.ShowNotification("Gallery Category deleted successfully.", UINotificationType.Success);
                                BindGrid();
                            }
                            else
                            {
                                Helper.ShowNotification("Gallery Category not deleted.", UINotificationType.Error);
                            }
                        }
                    }
                    else
                    {
                        Helper.ShowNotification("Error while deletion image.", UINotificationType.Error);
                    }
                }
                else
                {
                    Helper.ShowNotification("Current category has images.<br>Please delete its images before deletion of category.", UINotificationType.Notify);
                }

            }
        }
        #endregion
        #region Methods
        private void BindGrid()
        {
            try
            {
                using (DAL_PhotoGalleryCategory dalGalleryCategory = new DAL_PhotoGalleryCategory())
                {
                    List<GalleryCategoryResult> listResults = dalGalleryCategory.GetAllPhotoGalleryCategories();
                    if (listResults != null && listResults.Count > 0)
                    {
                        gv.DataSource = listResults;
                        gv.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }
        #endregion


    }
}