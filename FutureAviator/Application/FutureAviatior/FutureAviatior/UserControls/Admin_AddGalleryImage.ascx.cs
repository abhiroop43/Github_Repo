using BusinessDTO;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FutureAviator.Utlitity;

namespace FutureAviator.UserControls
{
    public partial class Admin_AddGalleryImage : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropdown();
                if (Request.QueryString["id"] != null)
                {
                    imgGalleryPhoto.Visible = true;
                    SaveButtonArea.Visible = false;
                    UpdateButtonArea.Visible = true;
                    lblTitle.Text = "Update Gallery Image";
                    BingGalleryImage(Convert.ToInt64(Request.QueryString["id"]));
                }
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            AddUpdateGalleryImage(DBMethod.Add);
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdateGalleryImage(DBMethod.Update);
        }
        #endregion

        #region Methods
        private void BindDropdown()
        {
            try
            {

                using (DAL_PhotoGalleryCategory dalGalleryCategory = new DAL_PhotoGalleryCategory())
                {
                    List<GalleryCategoryResult> galleryCategories = dalGalleryCategory.GetAllActivePhotoGalleryCategories(SessionManager.CurrentUser().LanguageCode, LanguageContentType.GalleryCategoryTitle);
                    if (galleryCategories != null && galleryCategories.Count > 0)
                    {
                        ddlGalleryCategory.DataSource = galleryCategories;
                        ddlGalleryCategory.DataTextField = "CategoryTitle";
                        ddlGalleryCategory.DataValueField = "PhotoGalleryCategoryID";
                        ddlGalleryCategory.DataBind();
                        Helper.InsertSelectFirstItem(ddlGalleryCategory);
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
        private void AddUpdateGalleryImage(DBMethod method)
        {
            try
            {
                bool IsImageExtentionValid = true;
                string strImagePath = "";
                long PhotoGalleryID = 0;

                if (method == DBMethod.Add)
                {
                    if (!fuGalleryPhoto.HasFile)
                    {
                        Helper.ShowNotification("Please select image", UINotificationType.Error);
                        return;
                    }
                    else
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuGalleryPhoto.FileName);

                    if (IsImageExtentionValid)
                    {
                        strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.GalleryImage, fuGalleryPhoto);
                        Helper.CreateImageThumbnail(strImagePath, BusinessDTO.FileUploadType.GalleryImage);
                    }
                    else
                    {
                        Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                        return;
                    }
                }
                else
                {
                    PhotoGalleryID = Convert.ToInt64(hdnGalleryImageID.Value);
                    if (fuGalleryPhoto.HasFile)
                    {
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuGalleryPhoto.FileName);

                        if (IsImageExtentionValid)
                        {
                            strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.GalleryImage, fuGalleryPhoto);
                            Helper.CreateImageThumbnail(strImagePath, BusinessDTO.FileUploadType.GalleryImage);
                        }
                        else
                        {
                            Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                            return;
                        }
                    }
                    else
                    {
                        strImagePath = Convert.ToString(hdnImagePath.Value);

                    }

                }

                using (DAL_PhotoGallery dalPhotoGallery = new DAL_PhotoGallery())
                {
                    DataAccess.PhotoGallery photoGallery = new DataAccess.PhotoGallery();

                    if (method == DBMethod.Add)
                    {
                        photoGallery = Helper.AutoFill<DataAccess.PhotoGallery>(photoGallery, DBMethod.Add);
                    }
                    else
                    {
                        photoGallery = Helper.AutoFill<DataAccess.PhotoGallery>(photoGallery, DBMethod.Update);
                    }

                    photoGallery.PhotoGalleryCategoryID = Convert.ToInt32(ddlGalleryCategory.SelectedValue);
                    photoGallery.IsActive = chkbxIsActive.Checked;
                    photoGallery.PhotoPath = strImagePath;

                    if (method == DBMethod.Add)
                    {
                        if (dalPhotoGallery.AddPhotoToPhotoGallery(photoGallery) > 0)
                        {
                            Helper.ClearInputs(this.Controls);
                            Helper.ShowNotification("Record saved successfully", UINotificationType.Success);

                        }
                        else
                        {
                            Helper.ShowNotification("Record not saved", UINotificationType.Error);
                        }
                    }
                    else
                    {
                        if (dalPhotoGallery.UpdatePhotoToPhotoGallery(PhotoGalleryID, photoGallery))
                        {

                            Response.Redirect("AllGalleryImages.aspx?MessageType=SuccessUpdate");
                        }
                        else
                        {
                            Helper.ShowNotification("Record update failed!", UINotificationType.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        private void BingGalleryImage(long lngGalleryImageID)
        {
            try
            {
                using (DAL_PhotoGallery dalPhotoGallery = new DAL_PhotoGallery())
                {
                    DataAccess.PhotoGallery myGallery = dalPhotoGallery.GetPhotoGalleryImageByID(lngGalleryImageID);
                    if (myGallery != null)
                    {
                        chkbxIsActive.Checked = myGallery.IsActive;
                        imgGalleryPhoto.ImageUrl = Helper.GALLERY_IMAGE_PATH + myGallery.PhotoPath;
                        ddlGalleryCategory.Items.FindByValue(myGallery.PhotoGalleryCategoryID.ToString()).Selected = true;
                        hdnGalleryImageID.Value = lngGalleryImageID.ToString();
                        hdnImagePath.Value = myGallery.PhotoPath;
                    }
                    else
                    {
                        Helper.ShowNotification("Record not found", UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        #endregion



    }
}