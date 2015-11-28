using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;

namespace FutureAviator.Admin
{
    public partial class UploadCustomerStory : System.Web.UI.Page
    {
        private static int StoryID;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {                
                Page.Form.Attributes.Add("enctype", "multipart/form-data");
                if(Request.QueryString["StoryID"] != null && Request.QueryString["StoryID"] != "")
                {
                    btnDelete.Visible = true;
                    dvImage.Visible = true;
                    StoryID = Convert.ToInt32(Request.QueryString["StoryID"]);
                    if (!this.IsPostBack)
                    {
                        LoadCustomerStory(StoryID);
                    }
                }
                else
                {
                    dvImage.Visible = false;
                    btnDelete.Visible = false;
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private void LoadCustomerStory(int StoryID)
        {
            using (DAL_CustomerStory objCust = new DAL_CustomerStory())
            {
                //get english content//
                List<CustStoryResult> custStories = objCust.GetCustStory(StoryID, ApplicationLanguages.en);
                if (custStories != null && custStories.Count > 0)
                {
                    foreach (CustStoryResult cs in custStories)
                    {
                        txtEnglishName.Text = cs.CustName;
                        txtEnglishDesignation.Text = cs.Designation;
                        //fbtxtEnglishStoryContent.Text = cs.StoryContent;
                        txtEnglishStoryContent.Value = cs.StoryContent;
                        hfStoryID.Value = cs.StoryID.ToString();
                        imgCustPicture.ImageUrl = String.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(cs.CustPicture));
                    }
                }

                //get arabic content//
                custStories = objCust.GetCustStory(StoryID, ApplicationLanguages.ar);
                if (custStories != null && custStories.Count > 0)
                {
                    foreach (CustStoryResult cs in custStories)
                    {
                        txtArabicName.Text = cs.CustName;
                        txtArabicDesignation.Text = cs.Designation;
                        //fbtxtArabicStoryContent.Text = cs.StoryContent;
                        txtArabicStoryContent.Value = cs.StoryContent;
                        //hfStoryID.Value = cs.StoryID.ToString();
                        //imgCustPicture.ImageUrl = String.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(cs.CustPicture));
                    }
                }
                
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    using (DAL_CustomerStory objCust = new DAL_CustomerStory())
                    {
                        if (hfStoryID.Value.Trim() == "")   //Add new story//
                        {
                            CustomerStory newCust = new CustomerStory();
                            newCust = Helper.AutoFill<CustomerStory>(newCust, DBMethod.Add);
                            //newCust.CreateDate = DateTime.Today;
                            //newCust.CreateBy = SessionManager.CurrentUser().UserID;  //added by Admin//

                            //customer name//
                            long StoryCustNameTrsID = DBHelper.GetUniqueID();
                            newCust.CustName = StoryCustNameTrsID;
                            DBHelper.AddLanguageContent(StoryCustNameTrsID, txtEnglishName.Text.Trim(), txtArabicName.Text.Trim(), BusinessDTO.LanguageContentType.StoryCustName);

                            //newCust.StoryContent = SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? fbtxtEnglishStoryContent.Text.Trim() : fbtxtArabicStoryContent.Text.Trim();

                            //customer designation//
                            long StoryCustDesignationTrsID = DBHelper.GetUniqueID();
                            newCust.Designation = StoryCustDesignationTrsID;
                            DBHelper.AddLanguageContent(StoryCustDesignationTrsID, txtEnglishDesignation.Text.Trim(), txtArabicDesignation.Text.Trim(), BusinessDTO.LanguageContentType.StoryCustDesignation);

                            //customer story content//
                            long StoryContentTrsID = DBHelper.GetUniqueID();
                            newCust.StoryContent = StoryContentTrsID;
                            //DBHelper.AddLanguageContent(StoryContentTrsID, fbtxtEnglishStoryContent.Text.Trim(), fbtxtArabicStoryContent.Text.Trim(), BusinessDTO.LanguageContentType.StoryContent);
                            DBHelper.AddLanguageContent(StoryContentTrsID, txtEnglishStoryContent.Value.Trim(), txtArabicStoryContent.Value.Trim(), BusinessDTO.LanguageContentType.StoryContent);
                            newCust.Status = "A";
                            if (flupImage.HasFile)
                            {
                                int length = flupImage.PostedFile.ContentLength;
                                byte[] pic = new byte[length];

                                flupImage.PostedFile.InputStream.Read(pic, 0, length);
                                newCust.CustPicture = pic;
                            }
                            int iSuccess = objCust.AddCustomerStory(newCust);
                            //objCust.Database.SaveChanges();
                            if (iSuccess > 0)
                            {
                                //lblErrDesc.Text = "Customer Story added successfully.";
                                Helper.ShowNotification("Customer Story added successfully.", BusinessDTO.UINotificationType.Success);
                                ResetForm();
                            }
                            else
                            {
                                //lblErrDesc.Text = "Failed to add customer story. Please check the logs for more details.";
                                Helper.ShowNotification("Failed to add customer story. Please check the logs for more details.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                        else
                        {
                            byte[] pic = null;
                            if (flupImage.HasFile)
                            {
                                int length = flupImage.PostedFile.ContentLength;
                                pic = new byte[length];

                                flupImage.PostedFile.InputStream.Read(pic, 0, length);
                            }

                            //int retVal = objCust.EditCustStory(Convert.ToInt32(hfStoryID.Value.Trim()), SessionManager.CurrentUser().UserID, txtEnglishName.Text.Trim(), txtArabicName.Text.Trim(), txtEnglishDesignation.Text.Trim(), txtArabicDesignation.Text.Trim(), fbtxtEnglishStoryContent.Text.Trim(), fbtxtArabicStoryContent.Text.Trim(), pic);
                            int retVal = objCust.EditCustStory(Convert.ToInt32(hfStoryID.Value.Trim()), SessionManager.CurrentUser().UserID, txtEnglishName.Text.Trim(), txtArabicName.Text.Trim(), txtEnglishDesignation.Text.Trim(), txtArabicDesignation.Text.Trim(), txtEnglishStoryContent.Value.Trim(), txtArabicStoryContent.Value.Trim(), pic);
                            if (retVal > 0)
                            {
                                ResetForm();
                                //lblErrDesc.Text = "Story updated successfully.";
                                Helper.ShowNotification("Story updated successfully.", BusinessDTO.UINotificationType.Success);
                            }
                            else
                            {
                                //lblErrDesc.Text = "Error while updating the story. Please check the logs for details.";
                                Helper.ShowNotification("Error while updating the story. Please check the logs for details.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please check the logs for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }            
        }

        protected void ResetForm()
        {
            txtEnglishName.Text = string.Empty;
            txtArabicName.Text = string.Empty;
            txtEnglishDesignation.Text = string.Empty;
            txtArabicDesignation.Text = string.Empty;
            //fbtxtEnglishStoryContent.Text = string.Empty;
            txtEnglishStoryContent.Value = string.Empty;
            //fbtxtArabicStoryContent.Text = string.Empty;
            txtArabicStoryContent.Value = string.Empty;
            imgCustPicture.ImageUrl = string.Empty;
            dvImage.Visible = false;
            hfStoryID.Value = string.Empty;
        }

        private bool ValidateInput()
        {
            if (txtEnglishName.Text.Trim() == "")
            {
                //lblErrDesc.Text = "English name cannot be blank";
                Helper.ShowNotification("English name cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtArabicName.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Arabic name cannot be blank";
                Helper.ShowNotification("Arabic name cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            //if (txtEnglishDesignation.Text.Trim() == "")
            //{
            //    //lblErrDesc.Text = "English designation cannot be blank";
            //    Helper.ShowNotification("English designation cannot be blank", BusinessDTO.UINotificationType.Notify);
            //    return false;
            //}
            //if (txtArabicDesignation.Text.Trim() == "")
            //{
            //    //lblErrDesc.Text = "Arabic designation cannot be blank";
            //    Helper.ShowNotification("Arabic designation cannot be blank", BusinessDTO.UINotificationType.Notify);
            //    return false;
            //}
            if (txtEnglishStoryContent.Value.Trim() == "")
            {
                //lblErrDesc.Text = "English story content cannot be blank";
                Helper.ShowNotification("English story content cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtArabicStoryContent.Value.Trim() == "")
            {
                //lblErrDesc.Text = "Arabic story content cannot be blank";
                Helper.ShowNotification("Arabic story content cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (flupImage.HasFile == false && imgCustPicture.ImageUrl.Trim() == "")
            {
                //lblErrDesc.Text = "Please upload a customer image";
                Helper.ShowNotification("Please upload a customer image", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (flupImage.HasFile && System.IO.Path.GetExtension(flupImage.FileName).ToLower() != ".jpg")
            {
                //lblErrDesc.Text = "Please upload a customer image in jpg format";
                Helper.ShowNotification("Please upload a customer image in jpg format", BusinessDTO.UINotificationType.Notify);
                return false;
            }

            if (flupImage.HasFile && flupImage.FileBytes.Length > 102400)
            {
                //lblErrDesc.Text = "Please upload a customer image in jpg format";
                Helper.ShowNotification("Image file size cannot exceed 100KB.", BusinessDTO.UINotificationType.Notify);
                return false;
            }

            return true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if(hfStoryID.Value.Trim() != "")
                {
                    int storyID = Convert.ToInt32(hfStoryID.Value.Trim());
                    using (DAL_CustomerStory objCust = new DAL_CustomerStory())
                    {
                        int retVal = objCust.DeleteStory(storyID, SessionManager.CurrentUser().UserID);
                        if(retVal > 0)
                        {
                            ResetForm();
                            //lblErrDesc.Text = "Story deleted successfully.";
                            Helper.ShowNotification("Story deleted successfully.", BusinessDTO.UINotificationType.Success);
                        }
                        else
                        {
                            //lblErrDesc.Text = "Error while deleting the story. Please check the logs for details.";
                            Helper.ShowNotification("Error while deleting the story. Please check the logs for details.", BusinessDTO.UINotificationType.Error);
                        }
                    }
                }
                
            }
            catch (Exception ex)
            {
               //lblErrDesc.Text = "Error occurred. Please check the logs for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }
    }
}