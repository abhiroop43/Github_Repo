using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessDTO;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;


namespace FutureAviator.UserControls
{
    public partial class Admin_AddImageContentBox : System.Web.UI.UserControl
    {
        #region Public Properties
        public string MainTitle { get; set; }
        public string TitleLabel { get; set; }
        public string DescripationLabel { get; set; }
        public BoxContentType BoxType { get; set; }
        public BusinessDTO.ImageContentBoxType ImageContentBoxType { get; set; }
        public string AllRecordURL { get; set; }
        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                hdnContextBoxTypeID.Value = Convert.ToString((int)ImageContentBoxType);
                if (BoxType == BoxContentType.Detail)
                {
                    pnlDetails.Visible = true;
                    pnlLink.Visible = false;
                }
                else
                {
                    pnlDetails.Visible = false;
                    pnlLink.Visible = true;
                }
                if (Request.QueryString["id"] != null && Request.QueryString["type"] != null)
                {
                    ButtonSaveArea.Visible = false;
                    UpdateButtonArea.Visible = true;
                    hdnContextBoxTypeID.Value = Convert.ToString(Request.QueryString["type"]);
                    GetImageContent(Convert.ToInt32(Request.QueryString["id"]));
                    lblTitle.Text = MainTitle.Replace("Add", "Update");
                }
                else
                {
                    lblTitle.Text = MainTitle;
                }
                this.Page.Title = "Admin : " + lblTitle.Text;
                     
                if (Session["AllPageURL"] != null)
                {
                    AllRecord.HRef = (string)Session["AllPageURL"];
                    AllRecord2.HRef = (string)Session["AllPageURL"];
                }
                else
                {
                    AllRecord.Visible = false;
                    AllRecord2.Visible = false;
                }

            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            AddBox(DBMethod.Add);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddBox(DBMethod.Update);
        }
        #endregion

        #region Methods
        private void GetImageContent(int ImageContentBoxID)
        {
            try
            {
                using (DAL_ImageBoxContent dalImageContentBox = new DAL_ImageBoxContent())
                {
                    int ImageContentBoxTypeID = Convert.ToInt32(hdnContextBoxTypeID.Value);
                    EditImageContentBoxResult result = dalImageContentBox.GetImageContentBoxByIDAndTypeIDForEdit(ImageContentBoxID, ImageContentBoxTypeID);
                    if (result != null)
                    {
                        txtArabic.Text = result.DescriptionArabic;
                        txtEnglish.Text = result.DescriptionEnglish;
                        txtExternalURL.Text = result.LinkURL;
                        txtTitleArabic.Text = result.TitleArabic;
                        txtTitleEnglish.Text = result.TitleEnglish;
                        chkbxIsActive.Checked = result.IsActive;
                        imgPhoto.Visible = true;
                        imgPhoto.ImageUrl = Helper.CONTENT_BOX_IMAGE_PATH + result.ImagePath;


                        hdnDescriptionTranslationID.Value = result.DescriptionTranslationID.ToString();
                        hdnImageContentBoxID.Value = ImageContentBoxID.ToString();
                        hdnImagePath.Value = result.ImagePath;
                        hdnTitleTranslationID.Value = result.TitleTranslationID.ToString();
                    }
                    else
                        Helper.ShowNotification("Record not found!", UINotificationType.Error);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }
        private void AddBox(DBMethod method)
        {
            try
            {
                int ImageContentBoxID = 0;
                long TitleTranslationID = 0;
                long DescriptionTranslationID = 0;
                bool IsImageExtentionValid = false;
                string strImagePath = "";


                ImageContentBox contentBox = new ImageContentBox();
                contentBox = Helper.AutoFill<ImageContentBox>(contentBox, method);
                contentBox.ImageContentBoxTypeID = Convert.ToInt32(hdnContextBoxTypeID.Value);

                if (method == DBMethod.Add)
                {
                    if (!fuPhoto.HasFile)
                    {
                        Helper.ShowNotification("Please select image", UINotificationType.Error);
                        return;
                    }
                    else
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuPhoto.FileName);

                    if (IsImageExtentionValid)
                    {
                        strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.ContentBoxImage, fuPhoto);
                    }
                    else
                    {
                        Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                        return;
                    }


                }
                else
                {
                    ImageContentBoxID = Convert.ToInt32(hdnImageContentBoxID.Value);
                    TitleTranslationID = Convert.ToInt32(hdnTitleTranslationID.Value);
                    DescriptionTranslationID = Convert.ToInt32(hdnDescriptionTranslationID.Value);

                    if (fuPhoto.HasFile)
                    {
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuPhoto.FileName);

                        if (IsImageExtentionValid)
                        {
                            strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.ContentBoxImage, fuPhoto);
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

                contentBox.ImagePath = strImagePath;
                contentBox.IsActive = chkbxIsActive.Checked;
                contentBox.LinkURL = txtExternalURL.Text;

                using (DAL_ImageBoxContent dalImageContentBox = new DAL_ImageBoxContent())
                {
                    if (method == DBMethod.Add)
                    {
                        TitleTranslationID = DBHelper.GetUniqueID();
                        DescriptionTranslationID = DBHelper.GetUniqueID();
                        contentBox.TitleTranslationID = TitleTranslationID;
                        contentBox.DescriptionTranslatioonID = DescriptionTranslationID;

                        if (dalImageContentBox.AddImageContentBox(contentBox) > 0)
                        {


                            DBHelper.AddLanguageContent(TitleTranslationID, txtTitleEnglish.Text, txtTitleArabic.Text, LanguageContentType.ContentImageBoxTitle);
                            DBHelper.AddLanguageContent(DescriptionTranslationID, txtEnglish.Text, txtArabic.Text, LanguageContentType.ContentImageBoxTitle);

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
                        contentBox.ImageContentBoxID = ImageContentBoxID;
                        if (dalImageContentBox.UpdateImageContentBox(contentBox))
                        {
                            DBHelper.UpdateLanguageContent(TitleTranslationID, txtTitleEnglish.Text, txtTitleArabic.Text, LanguageContentType.ContentImageBoxTitle);
                            DBHelper.UpdateLanguageContent(DescriptionTranslationID, txtEnglish.Text, txtArabic.Text, LanguageContentType.ContentImageBoxTitle);

                            Response.Redirect(AllRecord.HRef + "?MessageType=SuccessUpdate", false);
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
                Logger.WriteErrorLog(ex);
            }
        }
        #endregion

    }
}