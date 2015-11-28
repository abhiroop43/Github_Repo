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
    public partial class Admin_HomeSlider : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    BindSlideInformation(Convert.ToInt64(Request.QueryString["id"]));
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            AddUpdateSlide(DBMethod.Add);
        }


      

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdateSlide(DBMethod.Update);
        }
        #endregion
        #region Methods
        private void BindSlideInformation(long SlideID)
        {
            try
            {
                using (DAL_HomeSlider dalHomeSlider = new DAL_HomeSlider())
                {
                    EditSliderResult slide = dalHomeSlider.GetSlideByID(SlideID);
                    if (slide != null)
                    {
                        imgSlider.Visible = true;
                        SaveButtonArea.Visible = false;
                        UpdateButtonArea.Visible = true;

                        lblTitle.Text = "Update Home Page Slide";
                        imgSlider.ImageUrl = Helper.HOME_SLIDER_IMAGE_PATH + slide.ImagePath;
                        txtButtonTextArabic.Text = slide.ButtonTextArabic;
                        txtButtonTextEnglish.Text = slide.ButtonTextEnglish;
                        txtSliderTitleArabic.Text = slide.TitleArabic;
                        txtSliderTitleEnglish.Text = slide.TitleEnglish;
                        txtSubTitleArabic.Text = slide.SubTitleArabic;
                        txtSubTitleEnglish.Text = slide.SubTitleEnglish;
                        txtURL.Text = slide.ButtonLink;
                        chkbxIsActive.Checked = slide.IsActive;
                        //Set Hidden fields

                        hdnButtonTextTranslationID.Value = slide.ButtonTextTransaltionID.ToString();
                        hdnSlideID.Value = slide.SliderID.ToString();
                        hdnSubTitleTranslationID.Value = slide.SubTitleTranlationID.ToString();
                        hdnTitleTranslationID.Value = slide.TitleTranslationID.ToString();
                        hdnImagePath.Value = slide.ImagePath;

                    }
                    else
                    {
                        Helper.ShowNotification("Slide Not Exist", UINotificationType.Error);
                        imgSlider.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                Helper.ShowNotification(ex.Message, UINotificationType.Error);
            }
        }
        private void AddUpdateSlide(DBMethod method)
        {
            try
            {
                bool IsImageExtentionValid = true;

                long SliderTitleTranslationID = 0;
                long SliderSubTitleTranslationID = 0;
                long ButtonTextTranslationID = 0;
                long SlideID = 0;

                string strImagePath = "";

                if (method == DBMethod.Add)
                {
                    if (!fuSliderImage.HasFile)
                    {
                        Helper.ShowNotification("Please select image", UINotificationType.Error);
                        return;
                    }
                    else
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuSliderImage.FileName);
                }

                if (fuSliderImage.HasFile)
                {
                    IsImageExtentionValid = Helper.IsValidUploadImageType(fuSliderImage.FileName);
                    if (IsImageExtentionValid)
                    {
                        strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.HomeSliderImage, fuSliderImage);
                    }
                    else
                    {
                        Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                        return;
                    }
                }
                else
                {
                    strImagePath = hdnImagePath.Value;
                }

                using (DAL_HomeSlider dalHomeSlider = new DAL_HomeSlider())
                {
                    HomeSlider homeSlider = new HomeSlider();
                    if (method == DBMethod.Add)
                    {
                        SliderTitleTranslationID = DataAccess.DBHelper.GetUniqueID();
                        SliderSubTitleTranslationID = DataAccess.DBHelper.GetUniqueID();
                        ButtonTextTranslationID = DataAccess.DBHelper.GetUniqueID();
                        homeSlider = Helper.AutoFill<HomeSlider>(homeSlider, DBMethod.Add);
                    }
                    else
                    {
                        SliderTitleTranslationID = Convert.ToInt64(hdnTitleTranslationID.Value);
                        SliderSubTitleTranslationID = Convert.ToInt64(hdnSubTitleTranslationID.Value);
                        ButtonTextTranslationID = Convert.ToInt64(hdnButtonTextTranslationID.Value);
                        SlideID = Convert.ToInt64(hdnSlideID.Value);
                        homeSlider = Helper.AutoFill<HomeSlider>(homeSlider, DBMethod.Update);
                    }



                    homeSlider.ButtonTextTranslationID = ButtonTextTranslationID;
                    homeSlider.IsActive = chkbxIsActive.Checked;
                    homeSlider.SliderSubTitleTranslationID = SliderSubTitleTranslationID;
                    homeSlider.SliderTitleTranslationID = SliderTitleTranslationID;
                    homeSlider.URL = txtURL.Text;
                    homeSlider.SliderImage = strImagePath;
                    if (method == DBMethod.Add)
                    {
                        if (dalHomeSlider.AddHomeSlide(homeSlider) > 0)
                        {
                            DataAccess.DBHelper.AddLanguageContent(SliderTitleTranslationID, txtSliderTitleEnglish.Text, txtSliderTitleArabic.Text, BusinessDTO.LanguageContentType.HomeSliderTitle);
                            DataAccess.DBHelper.AddLanguageContent(SliderSubTitleTranslationID, txtSubTitleEnglish.Text, txtSubTitleArabic.Text, BusinessDTO.LanguageContentType.HomeSliderSubTitle);
                            DataAccess.DBHelper.AddLanguageContent(ButtonTextTranslationID, txtButtonTextEnglish.Text, txtButtonTextArabic.Text, BusinessDTO.LanguageContentType.HomeSliderButtonText);

                            Helper.ClearInputs(this.Controls);
                            Helper.ShowNotification("Save Successfully", UINotificationType.Success);

                        }
                        else
                        {
                            Helper.ShowNotification("Save Failed!", UINotificationType.Error);
                        }
                    }
                    else
                    {
                        if (dalHomeSlider.UpdateHomeSlide(homeSlider, SlideID))
                        {

                            DataAccess.DBHelper.UpdateLanguageContent(SliderTitleTranslationID, txtSliderTitleEnglish.Text, txtSliderTitleArabic.Text, BusinessDTO.LanguageContentType.HomeSliderTitle);
                            DataAccess.DBHelper.UpdateLanguageContent(SliderSubTitleTranslationID, txtSubTitleEnglish.Text, txtSubTitleArabic.Text, BusinessDTO.LanguageContentType.HomeSliderSubTitle);
                            DataAccess.DBHelper.UpdateLanguageContent(ButtonTextTranslationID, txtButtonTextEnglish.Text, txtButtonTextArabic.Text, BusinessDTO.LanguageContentType.HomeSliderButtonText);
                            Response.Redirect("AllSliders.aspx?MessageType=SuccessUpdate");
                        }
                        else
                        {
                            Helper.ShowNotification("Update Failed!", UINotificationType.Error);
                        }

                    }

                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification(ex.Message, UINotificationType.Error);
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        #endregion


    }
}