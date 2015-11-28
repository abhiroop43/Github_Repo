using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;


namespace FutureAviator.UserControls
{
    public partial class Admin_RegisterPhotoGalleryCategory : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    lblTitle.Text = "Update Photo Gallery Category";
                    SaveButtonArea.Visible = false;
                    UpdateButtonArea.Visible = true;
                    imgCategoryPhoto.Visible = true;
                    BindData(Convert.ToInt32(Request.QueryString["id"]));
                }
            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdatePhotogalleryCategory(DBMethod.Update);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            AddUpdatePhotogalleryCategory(DBMethod.Add);
        }

        #endregion

        #region Methods
        private void AddUpdatePhotogalleryCategory(DBMethod method)
        {
            try
            {
                bool IsImageExtentionValid = true;
                string strImagePath = "";
                long CategoryTitleTranslationID = 0;
                long CategoryDescriptionTranslationID = 0;
                Int32 PhotoGalleryCategoryID = 0;

                if (method == DBMethod.Add)
                {


                    if (!fuCategoryPhoto.HasFile)
                    {
                       // Helper.ShowNotification("Please select image", UINotificationType.Error);
                       // return;
                    }
                    else
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuCategoryPhoto.FileName);

                    if (IsImageExtentionValid)
                    {
                        strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.GalleryCategoryImage, fuCategoryPhoto);
                    }
                    else
                    {
                        Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                        return;
                    }
                }
                else
                {
                    if (fuCategoryPhoto.HasFile)
                    {

                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuCategoryPhoto.FileName);

                        if (IsImageExtentionValid)
                        {
                            strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.GalleryCategoryImage, fuCategoryPhoto);
                        }
                        else
                        {
                            Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                            return;
                        }
                    }
                    else
                    {
                        strImagePath = (Convert.ToString(hdnImagePath.Value));
                    }


                }


                using (DAL_PhotoGalleryCategory dalGalleryCategory = new DAL_PhotoGalleryCategory())
                {
                    PhotoGalleryCategory galleryCategory = new PhotoGalleryCategory();
                    if (method == DBMethod.Add)
                    {
                        CategoryTitleTranslationID = DataAccess.DBHelper.GetUniqueID();
                        CategoryDescriptionTranslationID = DataAccess.DBHelper.GetUniqueID();
                        galleryCategory = Helper.AutoFill<PhotoGalleryCategory>(galleryCategory, BusinessDTO.DBMethod.Add);

                        galleryCategory.CategoryTitleTranslationID = CategoryTitleTranslationID;
                        galleryCategory.CategoryDescriptionTranslationID = CategoryDescriptionTranslationID;
                    }
                    else
                    {
                        CategoryTitleTranslationID = Convert.ToInt64(hdnTranslationTitleID.Value);
                        CategoryDescriptionTranslationID = Convert.ToInt64(hdnTranslationDescriptionID.Value);
                        PhotoGalleryCategoryID = Convert.ToInt32(hdnGalleryCategoryID.Value);
                        galleryCategory = Helper.AutoFill<PhotoGalleryCategory>(galleryCategory, BusinessDTO.DBMethod.Update);
                    }

                    galleryCategory.IsActive = chkbxIsActive.Checked;
                    galleryCategory.CategoryImage = strImagePath;

                    if (method == DBMethod.Add)
                    {
                        if (dalGalleryCategory.AddPhotoGalleryCategory(galleryCategory) > 0)
                        {
                            DataAccess.DBHelper.AddLanguageContent(CategoryTitleTranslationID, txtCategoryTitleEnglish.Text, txtCategoryTitleArabic.Text, BusinessDTO.LanguageContentType.GalleryCategoryTitle);
                            DataAccess.DBHelper.AddLanguageContent(CategoryDescriptionTranslationID, txtDescriptionEnglish.Text, txtDescriptionArabic.Text, BusinessDTO.LanguageContentType.GalleryCategoryDescription);

                            Helper.ClearInputs(this.Controls);
                            Helper.ShowNotification("Saved successfully.", UINotificationType.Success);
                        }
                    }
                    else
                    {
                        if (dalGalleryCategory.UpdatePhotoGalleryCategory(PhotoGalleryCategoryID, galleryCategory))
                        {
                            DataAccess.DBHelper.UpdateLanguageContent(CategoryTitleTranslationID, txtCategoryTitleEnglish.Text, txtCategoryTitleArabic.Text, BusinessDTO.LanguageContentType.GalleryCategoryTitle);
                            DataAccess.DBHelper.UpdateLanguageContent(CategoryDescriptionTranslationID, txtDescriptionEnglish.Text, txtDescriptionArabic.Text, BusinessDTO.LanguageContentType.GalleryCategoryDescription);

                            Response.Redirect("AllGalleryCategories.aspx?MessageType=SuccessUpdate");

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

        private void BindData(Int32 PhotoGalleryCategoryID)
        {
            try
            {
                using (DAL_PhotoGalleryCategory dalPhotoCategory = new DAL_PhotoGalleryCategory())
                {
                    EditGalleryCategoryResult PhotoGalleryCategory = dalPhotoCategory.GetPhotoGalleryCategoryByIDForUpdate(PhotoGalleryCategoryID);
                    if (PhotoGalleryCategory != null)
                    {
                        txtDescriptionArabic.Text = PhotoGalleryCategory.CategoryDescriptionArabic;
                        txtCategoryTitleArabic.Text = PhotoGalleryCategory.CategoryTitleArabic;

                        txtDescriptionEnglish.Text = PhotoGalleryCategory.CategoryDescriptionEnglish;
                        txtCategoryTitleEnglish.Text = PhotoGalleryCategory.CategoryTitleEnglish;
                        chkbxIsActive.Checked = PhotoGalleryCategory.IsActive;
                        imgCategoryPhoto.ImageUrl = Helper.GALLERY_CATEGORY_IMAGE_PATH + PhotoGalleryCategory.CategoryImage;

                        //Setting Hidden Fields
                        hdnGalleryCategoryID.Value = PhotoGalleryCategoryID.ToString();
                        hdnTranslationDescriptionID.Value = PhotoGalleryCategory.CategoryDescriptionTranslationID.ToString();
                        hdnTranslationTitleID.Value = PhotoGalleryCategory.CategoryTitleTranslationID.ToString();
                        hdnImagePath.Value = PhotoGalleryCategory.CategoryImage;
                    }
                    else
                    {
                        Helper.ShowNotification("Data not found!", UINotificationType.Error);
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