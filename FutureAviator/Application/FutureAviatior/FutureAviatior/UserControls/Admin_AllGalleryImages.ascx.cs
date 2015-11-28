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
    public partial class Admin_AllGalleryImages : System.Web.UI.UserControl
    {
        #region Global Veriables
        private int DefaultGalleryCategoryID = 0;
        #endregion
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
                BindDropdown();
                BindGrid(DefaultGalleryCategoryID);
            }
        }
        protected void ddlGalleryCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int GalleryCategoryID = Convert.ToInt32(ddlGalleryCategory.SelectedValue);
            BindGrid(GalleryCategoryID);
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

                long GalleryImageID = Convert.ToInt64(param[0]);
                string ImageName = Convert.ToString(param[1]);


                if (Helper.DeleteFile(FileUploadType.GalleryImage, ImageName))
                {
                    using (DAL_PhotoGallery dal = new DAL_PhotoGallery())
                    {
                        if (dal.DeletePhotoToPhotoGallery(GalleryImageID))
                        {

                            Helper.ShowNotification("Gallery image deleted successfully.", UINotificationType.Success);
                            BindGrid(Convert.ToInt32(ddlGalleryCategory.SelectedValue));
                        }
                        else
                        {
                            Helper.ShowNotification("Gallery image not deleted.", UINotificationType.Error);
                        }
                    }
                }
                else
                {
                    Helper.ShowNotification("Error while deletion image.", UINotificationType.Error);
                }
            }



        }
        #endregion
        #region Methods
        private void BindDropdown()
        {
            try
            {

                using (DAL_PhotoGalleryCategory dalGalleryCategory = new DAL_PhotoGalleryCategory())
                {
                    List<GalleryCategoryResult> galleryCategories = dalGalleryCategory.GetAllActivePhotoGalleryCategories(ApplicationLanguages.en, LanguageContentType.GalleryCategoryTitle);
                    if (galleryCategories != null && galleryCategories.Count > 0)
                    {
                        DefaultGalleryCategoryID = galleryCategories[0].PhotoGalleryCategoryID;
                        ddlGalleryCategory.DataSource = galleryCategories;
                        ddlGalleryCategory.DataTextField = "CategoryTitle";
                        ddlGalleryCategory.DataValueField = "PhotoGalleryCategoryID";
                        ddlGalleryCategory.DataBind();
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
        private void BindGrid(int id)
        {
            try
            {
                using (DAL_PhotoGallery dalPhotoGallery = new DAL_PhotoGallery())
                {
                    GalleryResult resultList = dalPhotoGallery.GetPhotoGallery(ApplicationLanguages.en, id);
                    if (resultList != null)
                    {
                        if (resultList.GalleryPhotos != null && resultList.GalleryPhotos.Count > 0)
                        {
                            gv.DataSource = resultList.GalleryPhotos;
                            gv.DataBind();
                            Helper.ShowNotification("", UINotificationType.Error);
                        }
                        else
                        {
                            gv.DataSource = null;
                            gv.DataBind();
                            Helper.ShowNotification("Record not found", UINotificationType.Error);
                        }
                    }
                    else
                    {
                        gv.DataSource = null;
                        gv.DataBind();
                        Helper.ShowNotification("Record not found", UINotificationType.Error);
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