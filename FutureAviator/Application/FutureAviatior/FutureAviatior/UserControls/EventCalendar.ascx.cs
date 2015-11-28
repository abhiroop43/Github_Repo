using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using System.Text;

namespace FutureAviator.UserControls
{
    public partial class EventCalendar : System.Web.UI.UserControl
    {
        DAL_Events objEvents = new DAL_Events();
        protected DataSet dsHolidays;
        protected List<DateTime> eventDates = new List<DateTime>();



        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    dvMap.Visible = false;
                    hdUserID.Value = SessionManager.CurrentUser().UserID.ToString();

                    lblEventsHeader.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "DefaultEventCalHeader").ToString() : GetGlobalResourceObject("Arabic", "DefaultEventCalHeader").ToString();
                    eventTitleTd.Attributes.Add("class", "noEvent");
                    btnViewDetails.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventViewDetails").ToString() : GetGlobalResourceObject("Arabic", "EventViewDetails").ToString();
                    btnVolunteerEnroll.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventVolunteer").ToString() : GetGlobalResourceObject("Arabic", "EventVolunteer").ToString();
                    btnAttendEnroll.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventAttend").ToString() : GetGlobalResourceObject("Arabic", "EventAttend").ToString();
                }
                Calendar1.VisibleDate = DateTime.Today;
                Calendar1.ShowNextPrevMonth = false;
                Calendar1.NextMonthText = "";
                Calendar1.PrevMonthText = "";
                FillHolidayDataset();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }

        protected void FillHolidayDataset()
        {
            DateTime firstDate = new DateTime(Calendar1.VisibleDate.Year, Calendar1.VisibleDate.Month, 1).Date;
            DateTime lastDate = GetFirstDayOfNextMonth().Date;
            //change
            //dsHolidays = GetCurrentMonthData(firstDate, lastDate);
            IQueryable<Event> events = objEvents.Database.Events.Where(i => i.Status == "A");
            foreach (Event e in events)
            {
                eventDates.Add(e.EventFromDate);
            }
        }

        protected DateTime GetFirstDayOfNextMonth()
        {
            int monthNumber, yearNumber;
            if (Calendar1.VisibleDate.Month == 12)
            {
                monthNumber = 1;
                yearNumber = Calendar1.VisibleDate.Year + 1;
            }
            else
            {
                monthNumber = Calendar1.VisibleDate.Month + 1;
                yearNumber = Calendar1.VisibleDate.Year;
            }
            DateTime lastDate = new DateTime(yearNumber, monthNumber, 1);
            return lastDate;
        }

        protected DataSet GetCurrentMonthData(DateTime eventDate)
        {
            DataSet dsMonth = new DataSet();
            try
            {
                eventTitleTd.Attributes.Remove("class");
                dsMonth.Tables.Add(new DataTable());
                dsMonth.Tables[0].Columns.Add("EventToDate", typeof(DateTime));
                dsMonth.Tables[0].Columns.Add("EventFromDate", typeof(DateTime));
                dsMonth.Tables[0].Columns.Add("EventName", typeof(string));
                dsMonth.Tables[0].Columns.Add("EventVenue", typeof(string));
                dsMonth.Tables[0].Columns.Add("EventLong", typeof(string));
                dsMonth.Tables[0].Columns.Add("EventLat", typeof(string));
                dsMonth.Tables[0].Columns.Add("FileNameEnglish", typeof(string));
                dsMonth.Tables[0].Columns.Add("FileNameArabic", typeof(string));
                dsMonth.Tables[0].Columns.Add("EventID", typeof(int));
                dsMonth.Tables[0].Columns.Add("DetailType", typeof(string));
                dsMonth.Tables[0].Columns.Add("ExternalURL", typeof(string));

                //IQueryable<Event> events = objEvents.Database.Events.Where(i => i.EventDate >= firstDate && i.EventDate < lastDate && i.Status == "A");
                List<EventResult> events = objEvents.GetEvents(SessionManager.CurrentUser().LanguageCode, eventDate);
                foreach (EventResult e in events)
                {
                    DataRow drRow = dsMonth.Tables[0].NewRow();
                    drRow["EventToDate"] = e.EventToDate;
                    drRow["EventFromDate"] = e.EventFromDate;
                    drRow["EventVenue"] = e.EventVenue;
                    drRow["EventName"] = e.EventName;
                    drRow["EventLong"] = e.Longitude.ToString();
                    drRow["EventLat"] = e.Latitude.ToString();
                    drRow["FileNameEnglish"] = e.EnglishFileName;
                    drRow["FileNameArabic"] = e.ArabicFileName;
                    drRow["EventID"] = e.EventID;
                    drRow["DetailType"] = e.DetailType;
                    drRow["ExternalURL"] = e.ExternalURL;
                    dsMonth.Tables[0].Rows.Add(drRow);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return dsMonth;
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            //hide other months' dates//
            if (e.Day.IsOtherMonth)
            {
                e.Cell.Text = string.Empty;
            }

            if (eventDates != null && eventDates.Count > 0)
            {

                if (eventDates.Contains(e.Day.Date) && e.Day.Date >= DateTime.Today)
                {
                    //e.Cell.BackColor = System.Drawing.Color.FromName("#209793");
                    e.Cell.ForeColor = System.Drawing.Color.White;
                    e.Cell.CssClass = "activeEvents";
                    e.Day.IsSelectable = true;
                }
                else if (eventDates.Contains(e.Day.Date) && e.Day.Date < DateTime.Today)
                {
                    //e.Cell.BackColor = System.Drawing.Color.Gray;
                    e.Cell.ForeColor = System.Drawing.Color.White;
                    e.Cell.CssClass = "oldEvents";
                    e.Day.IsSelectable = true;
                }
                else
                {
                    e.Day.IsSelectable = false;
                    // e.Cell.CssClass = "InactiveEvents";
                    //lblEventsHeader.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "NoEvents").ToString() : GetGlobalResourceObject("Arabic", "NoEvents").ToString();
                }
                


            }
            else
            {
                e.Day.IsSelectable = false;
                lblEventsHeader.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "NoEvents").ToString() : GetGlobalResourceObject("Arabic", "NoEvents").ToString();
            }


        }


        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            //navigate to register events page//
            //Response.Redirect("~/RegisterEvent.aspx?selectedDate=" + Calendar1.SelectedDate.ToString("MM/dd/yyyy"));
            //dsHolidays = null;
            dsHolidays = GetCurrentMonthData(Calendar1.SelectedDate);
            if (dsHolidays != null && dsHolidays.Tables[0].Rows.Count > 0)
            {
                lblEventsHeader.Text = "";
                LoadEventDetails(Calendar1.SelectedDate);
                if (hdLatitude.Value.Trim() == "" || hdLongitude.Value.Trim() == "")
                {
                    dvMap.InnerHtml = "No map to display.";
                }
                else
                {
                    ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "ShowMap", "ShowMap();", true);
                }
                if (Calendar1.SelectedDate >= DateTime.Today)
                {
                    if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.ar && hdFileNameArabic.Value.Trim() != "")
                    {
                        btnViewDetails.Visible = true;
                    }
                    else if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en && hdFileNameEnglish.Value.Trim() != "")
                    {
                        btnViewDetails.Visible = true;
                    }
                    else if (hdDetailType.Value.Trim().ToUpper() == "E" && hdExternalURL.Value.Trim() != "")
                    {
                        btnViewDetails.Visible = true;
                    }
                    else
                    {
                        btnViewDetails.Visible = false;
                    }
                    btnAttendEnroll.Visible = true;
                    btnVolunteerEnroll.Visible = true;
                }
                else
                {
                    btnViewDetails.Visible = false;
                    btnAttendEnroll.Visible = false;
                    btnVolunteerEnroll.Visible = false;
                }
                dvMap.Visible = true;
            }
            else
            {
                //lblEventsHeader.Text = string.Empty;
                lblEventsHeader.Text = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "NoEvents").ToString() : GetGlobalResourceObject("Arabic", "NoEvents").ToString();
                lblEventDate.Text = string.Empty;
                lblEventVenue.Text = string.Empty;

                hdVenue.Value = string.Empty;
                hdLatitude.Value = string.Empty;
                hdLongitude.Value = string.Empty;
                btnViewDetails.Visible = false;
                btnAttendEnroll.Visible = false;
                btnVolunteerEnroll.Visible = false;
                dvMap.Visible = false;
            }
        }

        protected void btnAttendEnroll_Click(object sender, EventArgs e)
        {
            //lblEventsHeader.Text = "Method fired from code-behind.";
            try
            {
                if (hdEventID.Value.Trim() != "" && hdAttendType.Value.Trim() != "")
                {
                    int eventID = Convert.ToInt32(hdEventID.Value);
                    int iRetVal = objEvents.AddEventAttendance(eventID, hdAttendType.Value.Trim().ToUpper(), SessionManager.CurrentUser().UserID);
                    if (iRetVal > 0)
                    {
                        if (hdAttendType.Value.Trim().ToUpper() == "V")
                        {
                            lblErrDesc.Text = "Your request has been registered.";
                            lblErrDesc.CssClass = "SuccessMessage";
                            Emailer objEmail = new Emailer();
                            StringBuilder strMsgBody = new StringBuilder();
                            strMsgBody.AppendLine("The following user has requested to register as a volunteer for the event:");
                            strMsgBody.AppendLine("Event Name: " + lblEventsHeader.Text);
                            strMsgBody.AppendLine(lblEventDate.Text);
                            strMsgBody.AppendLine("User Details: ");
                            strMsgBody.AppendLine("Display Name: " + SessionManager.CurrentUser().DisplayName);
                            strMsgBody.AppendLine("Email ID: " + SessionManager.CurrentUser().Email);

                            objEmail.SendEmail(ConfigurationManager.AppSettings["EventsAlert"].ToString(), "", "", strMsgBody.ToString(), "");
                        }
                        else
                        {
                            lblErrDesc.Text = "Your request has been registered.";
                            lblErrDesc.CssClass = "SuccessMessage";
                            Emailer objEmail = new Emailer();
                            StringBuilder strMsgBody = new StringBuilder();
                            strMsgBody.AppendLine("The following user has requested to register as an attendee for the event:");
                            strMsgBody.AppendLine("Event Name: " + lblEventsHeader.Text);
                            strMsgBody.AppendLine(lblEventDate.Text);
                            strMsgBody.AppendLine("User Details: ");
                            strMsgBody.AppendLine("Display Name: " + SessionManager.CurrentUser().DisplayName);
                            strMsgBody.AppendLine("Email ID: " + SessionManager.CurrentUser().Email);

                            objEmail.SendEmail(ConfigurationManager.AppSettings["EventsAlert"].ToString(), "", "", strMsgBody.ToString(), "");
                        }
                    }
                    else
                    {
                        lblErrDesc.Text = "Unable to register to event. Kindly contact the administrator.";
                        lblErrDesc.CssClass = "SuccessMessage";
                        //Helper.ShowNotification("Unable to register to event. Kindly contact the administrator.", BusinessDTO.UINotificationType.Error);
                    }
                }
                else
                {
                    Logger.WriteMessage("No event ID selected.");
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }

        protected void LoadEventDetails(DateTime selectedDate)
        {
            lblErrDesc.Text = string.Empty;
            if (dsHolidays != null)
            {
                DateTime fromDate, finalDate;
                foreach (DataRow dr in dsHolidays.Tables[0].Rows)
                {
                    fromDate = (DateTime)dr["EventFromDate"];
                    finalDate = (DateTime)dr["EventToDate"];

                    if (fromDate == selectedDate && dr["EventLat"] != null && dr["EventLong"] != null)
                    {
                        Calendar1.SelectedDates.SelectRange(fromDate, finalDate);
                        if (fromDate >= DateTime.Today || finalDate >= DateTime.Today)
                        {
                            //Calendar1.SelectedDayStyle.BackColor = System.Drawing.Color.FromName("#209793");
                            Calendar1.SelectedDayStyle.BackColor = System.Drawing.Color.FromName("#33CCFF");
                            Calendar1.SelectedDayStyle.ForeColor = System.Drawing.Color.White;
                            //Calendar1.SelectedDayStyle.CssClass = "activeEvents";
                            Calendar1.SelectedDayStyle.CssClass = "selectedEvent";
                        }
                        else
                        {
                            //Calendar1.SelectedDayStyle.BackColor = System.Drawing.Color.LightCoral;
                            Calendar1.SelectedDayStyle.BackColor = System.Drawing.Color.FromName("#33CCFF");
                            Calendar1.SelectedDayStyle.ForeColor = System.Drawing.Color.White;
                            //Calendar1.SelectedDayStyle.CssClass = "oldEvents";
                            Calendar1.SelectedDayStyle.CssClass = "selectedEvent";
                        }
                        lblEventsHeader.Text = dr["EventName"].ToString();
                        string strFrmDate = fromDate.ToString("%d");
                        string strFinalDate = finalDate.ToString("%d");
                        if (strFrmDate.EndsWith("3"))
                        {
                            strFrmDate += "<sup>rd</sup>";
                        }
                        else if (strFrmDate.EndsWith("1"))
                        {
                            strFrmDate += "<sup>st</sup>";
                        }
                        else
                        {
                            strFrmDate += "<sup>th</sup>";
                        }
                        if (strFinalDate.EndsWith("3"))
                        {
                            strFinalDate += "<sup>rd</sup>";
                        }
                        else if (strFinalDate.EndsWith("1"))
                        {
                            strFinalDate += "<sup>st</sup>";
                        }
                        else
                        {
                            strFinalDate += "<sup>th</sup>";
                        }
                        if (fromDate != finalDate)
                        {
                            //lblEventDate.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventName") : GetGlobalResourceObject("Arabic", "EventName")) + fromDate.ToString("%d") + "<sup>th</sup> to " + finalDate.ToString("%d") + "<sup>th</sup> " + finalDate.ToString("MMMM", System.Globalization.CultureInfo.InvariantCulture) + " " + finalDate.ToString("yyyy");
                            if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en)
                                lblEventDate.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventName") : GetGlobalResourceObject("Arabic", "EventName")) + strFrmDate + " to " + strFinalDate + " " + finalDate.ToString("MMMM", System.Globalization.CultureInfo.GetCultureInfo("en")) + " " + finalDate.ToString("yyyy");
                            else
                                lblEventDate.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventName") : GetGlobalResourceObject("Arabic", "EventName")) + strFrmDate + " to " + strFinalDate + " " + finalDate.ToString("MMMM", System.Globalization.CultureInfo.GetCultureInfo("ar")) + " " + finalDate.ToString("yyyy");
                        }
                        else
                        {
                            if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en)
                                lblEventDate.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventName") : GetGlobalResourceObject("Arabic", "EventName")) + strFrmDate + " " + fromDate.ToString("MMMM", System.Globalization.CultureInfo.GetCultureInfo("en")) + " " + fromDate.ToString("yyyy");
                            else
                                lblEventDate.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventName") : GetGlobalResourceObject("Arabic", "EventName")) + strFrmDate + " " + fromDate.ToString("MMMM", System.Globalization.CultureInfo.GetCultureInfo("ar")) + " " + fromDate.ToString("yyyy");
                        }
                        lblEventVenue.Text = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English", "EventLocation") : GetGlobalResourceObject("Arabic", "EventLocation")) + dr["EventVenue"].ToString();

                        hdVenue.Value = lblEventVenue.Text;
                        hdLatitude.Value = dr["EventLat"].ToString();
                        hdLongitude.Value = dr["EventLong"].ToString();
                        hdFileNameEnglish.Value = dr["FileNameEnglish"].ToString();
                        hdFileNameArabic.Value = dr["FileNameArabic"].ToString();
                        hdEventID.Value = dr["EventID"].ToString();
                        hdDetailType.Value = dr["DetailType"].ToString();
                        hdExternalURL.Value = dr["ExternalURL"].ToString();
                    }
                }
                //rptMarkers.DataSource = dtLocation;
                //rptMarkers.DataBind();

                //Calendar1.Attributes.Add("onclick", "return ShowMap();");
            }
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {

            string strPath = ConfigurationManager.AppSettings["EventDetailsPath"].ToString();

            if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.ar && hdFileNameArabic.Value.Trim() != "")
            {
                string strArabicFile = strPath + hdFileNameArabic.Value.Trim();
                ResponseHelper.Redirect(strArabicFile, "_blank", "menubar=0,width=1024,height=768");
            }
            else if (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en && hdFileNameEnglish.Value.Trim() != "")
            {
                string strEnglishFile = strPath + hdFileNameEnglish.Value.Trim();
                //ResponseHelper.Redirect(strEnglishFile, "_blank", "menubar=0,width=640,height=480");
                ResponseHelper.Redirect(strEnglishFile, "_blank", "menubar=0,width=1024,height=768");
            }
            else if (hdDetailType.Value.Trim().ToUpper() == "E" && hdExternalURL.Value.Trim() != "")
            {
                ResponseHelper.Redirect(hdExternalURL.Value.Trim(), "_blank", "menubar=0,width=1024,height=768");
            }

        }



    }
}
