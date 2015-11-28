using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Configuration;

namespace FutureAviator.Admin
{
    public partial class AddAdminEvents : System.Web.UI.Page
    {
        private static int EventID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        EventID = Convert.ToInt32(Request.QueryString["id"]);
                        btnAdd.Text = "Edit";
                        //hypEnglishFile.Visible = true;
                        //hypArabicFile.Visible = true;
                        LoadEvent();
                    }
                    //else
                    //{
                    //    hypEnglishFile.Visible = false;
                    //    hypArabicFile.Visible = false;
                    //}
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("Error occurred. Please check the log for details.", BusinessDTO.UINotificationType.Error);
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        private void LoadEvent()
        {
            using (DAL_Events objEvent = new DAL_Events())
            {
                List<EventResult> events = objEvent.GetEvents(ApplicationLanguages.en, EventID);
                foreach (EventResult e in events)
                {
                    txtFromDate.Text = e.EventFromDate.ToString("yyyy-MM-dd");
                    txtToDate.Text = e.EventToDate.ToString("yyyy-MM-dd");
                    if (e.EnglishFileName != null && e.EnglishFileName != "")
                    {
                        hypEnglishFile.NavigateUrl = ConfigurationManager.AppSettings["EventDetailsPath"].ToString() + e.EnglishFileName;
                        hypEnglishFile.Visible = true;
                    }
                    if (e.ArabicFileName != null && e.ArabicFileName != "")
                    {
                        hypArabicFile.NavigateUrl = ConfigurationManager.AppSettings["EventDetailsPath"].ToString() + e.ArabicFileName;
                        hypArabicFile.Visible = true;
                    }
                    txtEventVenue.Text = e.EventVenue;
                    if (e.Latitude != null)
                        txtLatitude.Text = e.Latitude == 0 ? "" : e.Latitude.ToString();
                    if(e.Longitude != null)
                        txtLongitude.Text = e.Longitude == 0 ? "" : e.Longitude.ToString();
                    txtEnglishName.Text = e.EventName;
                    ddlDetailType.SelectedValue = e.DetailType;
                    if (e.DetailType.Trim().ToUpper() == "E")
                    {
                        txtExternalURL.Text = e.ExternalURL.Trim();
                    }
                }
                events = null;
                events = objEvent.GetEvents(ApplicationLanguages.en, EventID);
                foreach (EventResult e in events)
                {
                    txtArabicName.Text = e.EventName;
                }

            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateForm())
                {
                    Event newevent = new Event();
                    newevent = Helper.AutoFill<Event>(newevent, DBMethod.Add);

                    newevent.EventFromDate = DateTime.ParseExact(txtFromDate.Text.Trim(), "yyyy-MM-dd", null);
                    newevent.EventToDate = DateTime.ParseExact(txtToDate.Text.Trim(), "yyyy-MM-dd", null);
                    newevent.Venue = txtEventVenue.Text.Trim();

                    if (ddlDetailType.SelectedValue.Trim().ToUpper() != "" && ddlDetailType.SelectedValue.Trim().ToUpper() == "P")
                    {
                        newevent.DetailType = "P";
                        if (flupEnglish.HasFile)
                        {
                            string fileExtn = flupEnglish.FileName.Substring(flupEnglish.FileName.LastIndexOf(".") + 1);
                            string currentFileName = flupEnglish.FileName.Substring(0, flupEnglish.FileName.LastIndexOf("."));
                            string newFileName = currentFileName.Replace(" ", "_") + "_" + txtEnglishName.Text.Trim().Replace(" ", "_") + "_" + DateTime.Now.Ticks.ToString() + "." + fileExtn;
                            newevent.FileNameEnglish = newFileName;

                            UploadFile(ref flupEnglish, newFileName);
                        }
                        if (flupArabic.HasFile)
                        {
                            string fileExtn = flupArabic.FileName.Substring(flupArabic.FileName.LastIndexOf(".") + 1);
                            string currentFileName = flupArabic.FileName.Substring(0, flupArabic.FileName.LastIndexOf("."));
                            string newFileName = currentFileName.Replace(" ", "_") + "_" + txtArabicName.Text.Trim().Replace(" ", "_") + "_" + DateTime.Now.Ticks.ToString() + "." + fileExtn;
                            newevent.FileNameArabic = newFileName;

                            UploadFile(ref flupArabic, newFileName);
                        }
                    }
                    newevent.Status = "A";

                    if (ddlDetailType.SelectedValue.Trim().ToUpper() != "" && ddlDetailType.SelectedValue.Trim().ToUpper() == "E")
                    {
                        newevent.ExternalURL = txtExternalURL.Text.Trim();
                        newevent.DetailType = "E";
                    }

                    using (DAL_Events objEvents = new DAL_Events())
                    {
                        if (btnAdd.Text.Trim() != "Edit" && EventID == 0)   //Add new record//
                        {
                            if (objEvents.AddNewAdminEvent(newevent, SessionManager.CurrentUser().LanguageCode, txtEnglishName.Text.Trim(), txtArabicName.Text.Trim(), txtLatitude.Text.Trim(), txtLongitude.Text.Trim()) > 0)
                            {

                                Helper.ShowNotification("Event Added successfully", BusinessDTO.UINotificationType.Success);
                                ResetForm();
                            }
                            else
                            {
                                //lblErrDesc.Text = "Error occurred. Please try again later.";
                                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                        else
                        {
                            newevent.ID = EventID;
                            //Edit existing event//
                            if (objEvents.UpdateEventDetails(newevent, SessionManager.CurrentUser().LanguageCode, txtEnglishName.Text.Trim(), txtArabicName.Text.Trim(), txtLatitude.Text.Trim(), txtLongitude.Text.Trim()) > 0)
                            {
                                //lblErrDesc.Text = "Event Added successfully";
                                Helper.ShowNotification("Event updated successfully", BusinessDTO.UINotificationType.Success);
                                ResetForm();
                            }
                            else
                            {
                                //lblErrDesc.Text = "Error occurred. Please try again later.";
                                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
               Helper.ShowNotification("Error occurred. Please check the log for details.", BusinessDTO.UINotificationType.Error);
               ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        protected void ResetForm()
        {
            txtArabicName.Text = string.Empty;
            txtEnglishName.Text = string.Empty;
            txtFromDate.Text = string.Empty;
            txtToDate.Text = string.Empty;
            txtEventVenue.Text = string.Empty;
            txtLatitude.Text = string.Empty;
            txtLongitude.Text = string.Empty;
            hypEnglishFile.Visible = false;
            hypArabicFile.Visible = false;
        }

        private void UploadFile(ref FileUpload flup, string newFileName)
        {
            if(flup.HasFile)
            {
                //string fileExtn = flup.FileName.Substring(flup.FileName.LastIndexOf(".") + 1);
                //string currentFileName = flup.FileName.Substring(0, flup.FileName.LastIndexOf("."));
                //string newFileName = currentFileName.Replace(" ", "_") + "_" + eventName.Replace(" ", "_") + "_" + DateTime.Now.Ticks.ToString() + "." + fileExtn;
                string strPath = ConfigurationManager.AppSettings["EventDetailsPath"].ToString() + newFileName;
                flup.SaveAs(Server.MapPath(strPath));
            }
        }

        private bool ValidateForm()
        {
            if(txtFromDate.Text.Trim() == "")
            {
                Helper.ShowNotification("From Date cannot be empty.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if(txtToDate.Text.Trim() == "")
            {
                Helper.ShowNotification("To Date cannot be empty.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if(txtEnglishName.Text.Trim() == "")
            {
                Helper.ShowNotification("English name cannot be empty.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if(txtArabicName.Text.Trim() == "")
            {
                Helper.ShowNotification("Arabic name cannot be empty.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if(txtEventVenue.Text.Trim() == "")
            {
                Helper.ShowNotification("Venue cannot be empty.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            return true;
        }
    }
}