using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using ExceptionLogger;
using BusinessDTO;
using FutureAviator.Utlitity;

namespace FutureAviator.UserControls
{
    public partial class Admin_AddNews : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    BindNewsData(Convert.ToInt64(Request.QueryString["id"]));
                }

            }
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdateNews(DBMethod.Update);
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            AddUpdateNews(DBMethod.Add);
        }

        #endregion

        #region Methods
        private void BindNewsData(long NewsID)
        {
            try
            {
                using (DAL_News dalNews = new DAL_News())
                {
                    EditNewsResult newsResult = dalNews.GetNewsByID(NewsID);
                    if (newsResult != null)
                    {
                        lblTitle.Text = "Update Press Release";
                        this.Page.Title = "Admin : " + lblTitle.Text;
                        ButtonSaveArea.Visible = false;
                        UpdateButtonArea.Visible = true;


                        txtNewsTitleArabic.Text = newsResult.NewsTitleArabic;
                        txtNewsTitleEnglish.Text = newsResult.NewsTitleEnglish;
                        txtDetailsArabic.Text = newsResult.NewsDescriptionArabic;
                        txtDetailsEnglish.Text = newsResult.NewsDescriptionEnglish;
                        chkbxIsActive.Checked = newsResult.IsActive;

                        //Set Hidden Fields with IDs
                        hdnNewsDescriptionTranslationID.Value = newsResult.NewsDescriptionTranslationID.ToString();
                        hdnNewsTitleTranslationID.Value = newsResult.NewsTitleTranslationID.ToString();
                        hdnNewsID.Value = newsResult.NewsID.ToString();
                        if (newsResult.ImagePath != "")
                        {
                            imgNewsPhoto.ImageUrl = Helper.NEWS_IMAGE_PATH + newsResult.ImagePath;
                            hdnImagePath.Value = newsResult.ImagePath;
                            imgNewsPhoto.Visible = true;
                        }
                        txtPressReleaseDate.Text = newsResult.PressReleaseDate.HasValue ? newsResult.PressReleaseDate.Value.ToString("yyyy-MM-dd") : string.Empty;
                    }
                    else
                        Helper.ShowNotification("Press Release not found", UINotificationType.Notify);
                }
            }
            catch (Exception ex)
            {

                Logger.WriteErrorLog(ex);
                Helper.ShowNotification(ex.Message, UINotificationType.Error);
            }
        }
        private void AddUpdateNews(DBMethod method)
        {
            try
            {
                using (DAL_News dalNews = new DAL_News())
                {
                    News news = new News();
                    long NewsTitleTranslationID = 0;
                    long NewsDescriptionTranslationID = 0;
                    bool IsImageExtentionValid = true;
                    string strImagePath = "";
                    long NewsID = 0;

                    if (fuPhoto.HasFile)
                    {
                        IsImageExtentionValid = Helper.IsValidUploadImageType(fuPhoto.FileName);

                        if (IsImageExtentionValid)
                        {
                            strImagePath = Helper.UploadFile(BusinessDTO.FileUploadType.NewsImage, fuPhoto);
                        }
                        else
                        {
                            Helper.ShowNotification("Please upload a valid image", UINotificationType.Error);
                            return;
                        }
                    }

                    if (method == DBMethod.Add)
                    {
                        NewsTitleTranslationID = DataAccess.DBHelper.GetUniqueID();
                        NewsDescriptionTranslationID = DataAccess.DBHelper.GetUniqueID();
                        news = Helper.AutoFill<News>(news, DBMethod.Add);

                        news.NewsTitleTranslationID = NewsTitleTranslationID;
                        news.NewsDescriptionTranslationID = NewsDescriptionTranslationID;

                    }
                    else
                    {
                        NewsTitleTranslationID = Convert.ToInt64(hdnNewsTitleTranslationID.Value);
                        NewsDescriptionTranslationID = Convert.ToInt64(hdnNewsDescriptionTranslationID.Value);
                        NewsID = Convert.ToInt64(hdnNewsID.Value);
                        news = Helper.AutoFill<News>(news, DBMethod.Update);
                        strImagePath = strImagePath == "" ? Convert.ToString(hdnImagePath.Value) : strImagePath;
                    }

                    news.IsActive = chkbxIsActive.Checked;
                    news.ImagePath = strImagePath;
                    news.PressReleaseDate = DateTime.ParseExact(txtPressReleaseDate.Text.Trim(), "yyyy-MM-dd", null);
                    if (method == DBMethod.Add)
                    {
                        if (dalNews.AddNews(news) > 0)
                        {
                            DataAccess.DBHelper.AddLanguageContent(NewsTitleTranslationID, txtNewsTitleEnglish.Text, txtNewsTitleArabic.Text, BusinessDTO.LanguageContentType.NewsTitle);
                            DataAccess.DBHelper.AddLanguageContent(NewsDescriptionTranslationID, txtDetailsEnglish.Text, txtDetailsArabic.Text, BusinessDTO.LanguageContentType.NewsDescription);

                            Helper.ClearInputs(this.Controls);
                            Helper.ShowNotification("Saved successfully.", UINotificationType.Success);
                        }
                        else
                        {
                            Helper.ShowNotification("Record not saved.", UINotificationType.Error);
                        }
                    }
                    else
                    {
                        if (dalNews.UpdateNewsByID(NewsID, news))
                        {
                            DataAccess.DBHelper.UpdateLanguageContent(NewsTitleTranslationID, txtNewsTitleEnglish.Text, txtNewsTitleArabic.Text, BusinessDTO.LanguageContentType.NewsTitle);
                            DataAccess.DBHelper.UpdateLanguageContent(NewsDescriptionTranslationID, txtDetailsEnglish.Text, txtDetailsArabic.Text, BusinessDTO.LanguageContentType.NewsDescription);

                            Response.Redirect("AllNews.aspx?MessageType=SuccessUpdate");
                        }
                        else
                        {
                            Helper.ShowNotification("Record update failed.", UINotificationType.Error);
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