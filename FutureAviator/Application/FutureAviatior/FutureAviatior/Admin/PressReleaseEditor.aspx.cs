using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;

namespace FutureAviator.Admin
{
    public partial class PressReleaseEditor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                if (Request.QueryString["ID"] != null && Request.QueryString["ID"] != "")
                {
                    dvImage.Visible = true;
                    hfPressRlsID.Value = Request.QueryString["ID"].ToString();
                    if (!this.IsPostBack)
                    {
                        LoadPressRlsData(Convert.ToInt32(hfPressRlsID.Value));
                    }
                }
                else
                {
                    dvImage.Visible = false;
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("An error occurred. Please check the log for more details.", UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private void LoadPressRlsData(int PressRlsID)
        {
            using (DAL_PressReleases objPress = new DAL_PressReleases())
            {
                //get english content//
                List<PressReleaseResult> pressReleases = objPress.GetAllPressReleases(ApplicationLanguages.en, PressRlsID);
                if (pressReleases != null && pressReleases.Count > 0)
                {
                    foreach (PressReleaseResult pr in pressReleases)
                    {
                        txtPressRlsHeaderEnglish.Text = pr.Header;
                        txtPressRlsDate.Text = pr.PressReleaseDate.ToString("yyyy-MM-dd");
                        txtContentEnglish.Value = pr.PressReleaseContent;
                        imgPressPicture.ImageUrl = ConfigurationManager.AppSettings["PressReleasesImages"] + pr.ImagePath;
                    }
                }

                //get arabic content//
                pressReleases = objPress.GetAllPressReleases(ApplicationLanguages.ar, PressRlsID);
                if (pressReleases != null && pressReleases.Count > 0)
                {
                    foreach (PressReleaseResult pr in pressReleases)
                    {
                        txtPressRlsHeaderArabic.Text = pr.Header;
                        txtContentArabic.Value = pr.PressReleaseContent;
                    }
                }

            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    using (DAL_PressReleases objPress = new DAL_PressReleases())
                    {
                        if (hfPressRlsID.Value.Trim() == "")   //Add new story//
                        {
                            PressReleas newRls = new PressReleas();
                            newRls = Helper.AutoFill<PressReleas>(newRls, DBMethod.Add);

                            //Press Release Header//
                            long PressRlsHeaderTrsID = DBHelper.GetUniqueID();
                            newRls.Header = PressRlsHeaderTrsID;
                            DBHelper.AddLanguageContent(PressRlsHeaderTrsID, txtPressRlsHeaderEnglish.Text.Trim(), txtPressRlsHeaderArabic.Text.Trim(), LanguageContentType.PressReleaseHeader);

                            //newCust.StoryContent = SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? fbtxtEnglishStoryContent.Text.Trim() : fbtxtArabicStoryContent.Text.Trim();

                            //Press Release Content//
                            long ContentTrsID = DBHelper.GetUniqueID();
                            newRls.PressRlsContent = ContentTrsID;
                            DBHelper.AddLanguageContent(ContentTrsID, txtContentEnglish.Value.Trim(), txtContentArabic.Value.Trim(), BusinessDTO.LanguageContentType.StoryCustDesignation);

                            newRls.IsActive = true;
                            if (flupImage.HasFile)
                            {
                                newRls.ImagePath = flupImage.FileName;
                                flupImage.SaveAs(Server.MapPath(ConfigurationManager.AppSettings["PressReleasesImages"]) + flupImage.FileName);
                            }
                            newRls.PressRlsDate = DateTime.ParseExact(txtPressRlsDate.Text.Trim(), "yyyy-MM-dd", null);
                            int iSuccess = objPress.AddPressRelease(newRls);
                            //objCust.Database.SaveChanges();
                            if (iSuccess > 0)
                            {
                                //lblErrDesc.Text = "Customer Story added successfully.";
                                Helper.ShowNotification("Press release added successfully.", BusinessDTO.UINotificationType.Success);
                                ResetForm();
                            }
                            else
                            {
                                //lblErrDesc.Text = "Failed to add customer story. Please check the logs for more details.";
                                Helper.ShowNotification("Failed to add press release. Please check the logs for more details.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                        else
                        {
                            int retVal = 0;
                            string imgFileName = "";
                            if (flupImage.HasFile)
                            {
                                imgFileName = flupImage.FileName;
                            }

                            retVal = objPress.EditPressRelease(Convert.ToInt32(hfPressRlsID.Value.Trim()), SessionManager.CurrentUser().UserID, txtPressRlsHeaderEnglish.Text.Trim(), txtPressRlsHeaderArabic.Text.Trim(), txtContentEnglish.Value.Trim(), txtContentArabic.Value.Trim(), txtPressRlsDate.Text.Trim(), imgFileName);
                            if (retVal > 0)
                            {
                                ResetForm();
                                Helper.ShowNotification("Press Release updated successfully.", BusinessDTO.UINotificationType.Success);
                            }
                            else
                            {
                                Helper.ShowNotification("Error while updating the press release. Please check the logs for details.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("An error occurred. Please check the log for more details.", UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void ResetForm()
        {
            txtContentEnglish.Value = string.Empty;
            txtContentArabic.Value = string.Empty;
            txtPressRlsDate.Text = string.Empty;
            txtPressRlsHeaderEnglish.Text = string.Empty;
            txtPressRlsHeaderArabic.Text = string.Empty;
            imgPressPicture.ImageUrl = string.Empty;
            dvImage.Visible = false;
            hfPressRlsID.Value = string.Empty;
        }

        private bool ValidateInput()
        {
            if (txtPressRlsDate.Text.Trim() == "")
            {
                //lblErrDesc.Text = "English name cannot be blank";
                Helper.ShowNotification("Release date cannot be blank", UINotificationType.Notify);
                return false;
            }
            if (txtPressRlsHeaderEnglish.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Arabic name cannot be blank";
                Helper.ShowNotification("English header cannot be blank", UINotificationType.Notify);
                return false;
            }
            if (txtPressRlsHeaderArabic.Text.Trim() == "")
            {
                //lblErrDesc.Text = "English designation cannot be blank";
                Helper.ShowNotification("Arabic header cannot be blank", UINotificationType.Notify);
                return false;
            }
            if (txtContentEnglish.Value.Trim() == "")
            {
                //lblErrDesc.Text = "Arabic designation cannot be blank";
                Helper.ShowNotification("English content cannot be blank", UINotificationType.Notify);
                return false;
            }
            if (txtContentArabic.Value.Trim() == "")
            {
                //lblErrDesc.Text = "English story content cannot be blank";
                Helper.ShowNotification("Arabic content cannot be blank", UINotificationType.Notify);
                return false;
            }
            if (flupImage.HasFile == false && imgPressPicture.ImageUrl.Trim() == "")
            {
                //lblErrDesc.Text = "Please upload a customer image";
                Helper.ShowNotification("Please upload a press release image", UINotificationType.Notify);
                return false;
            }
            if (flupImage.HasFile && System.IO.Path.GetExtension(flupImage.FileName).ToLower() != ".jpg")
            {
                //lblErrDesc.Text = "Please upload a customer image in jpg format";
                Helper.ShowNotification("Please upload a press release image in jpg format", UINotificationType.Notify);
                return false;
            }

            return true;
        }
    }
}