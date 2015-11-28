using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Configuration;

namespace FutureAviator
{
    public partial class RegisterEvent : BasePage
    {
        protected static string selectedDate = "";
        protected DataTable dtEvents = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!this.IsPostBack)
                {
                    if (Request.QueryString["selectedDate"] != null)
                    {
                        selectedDate = Request.QueryString["selectedDate"].ToString();
                        lblHeaderDate.Text += selectedDate;

                        LoadEvents();

                        if(SessionManager.CurrentUser.UserID > 0)
                        {
                            pnlAddEvent.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }            
        }

        private void LoadEvents()
        {
            //dtEvents.Columns.Add("EventDate", typeof(DateTime));
            //dtEvents.Columns.Add("EventType", typeof(string));
            dtEvents.Columns.Add("ID", typeof(int));
            dtEvents.Columns.Add("EventName", typeof(string));
            dtEvents.Columns.Add("EventDesc", typeof(string));
            dtEvents.Columns.Add("EventUser", typeof(string));
            dtEvents.Columns.Add("Public", typeof(string));
            DAL_Events objEvents = new DAL_Events();
            DateTime dtSelectedDate=DateTime.ParseExact(selectedDate, "MM/dd/yyyy", null);

            //IQueryable<Event> events = objEvents.Database.Events.Where(i => i.EventDate == dtSelectedDate && i.EventType == "E" && i.Status == "A");

            List<EventResult> events = objEvents.GetEventsForDate(SessionManager.CurrentUser.LanguageCode, dtSelectedDate, "E");
            foreach(EventResult e in events)
            {
                if (e.IsPublic.ToString().Trim() == "Y")
                {
                    DataRow drEvent = dtEvents.NewRow();
                    drEvent["ID"] = e.EventID;
                    //drEvent["EventDate"] = e.EventDate;
                    //drEvent["EventType"] = e.EventType;
                    drEvent["EventName"] = e.EventName;
                    drEvent["EventDesc"] = e.EventDesc;
                    drEvent["EventUser"] = e.EventUser;
                    drEvent["Public"] = e.IsPublic;
                    dtEvents.Rows.Add(drEvent);
                }
                else if (e.IsPublic.ToString().Trim() == "N" && SessionManager.CurrentUser != null && e.EventUser.ToString() == SessionManager.CurrentUser.UserID.ToString())
                {
                    DataRow drEvent = dtEvents.NewRow();
                    drEvent["ID"] = e.EventID;
                    //drEvent["EventDate"] = e.EventDate;
                    //drEvent["EventType"] = e.EventType;
                    drEvent["EventName"] = e.EventName;
                    drEvent["EventDesc"] = e.EventDesc;
                    drEvent["EventUser"] = e.EventUser;
                    drEvent["Public"] = e.IsPublic;
                    dtEvents.Rows.Add(drEvent);
                }
            }
            rptEventDetails.DataSource = dtEvents;
            rptEventDetails.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    Event newevent = new Event();
                    newevent = Helper.AutoFill<Event>(newevent, DBMethod.Add);
                    //newevent.CreateBy = SessionManager.CurrentUser.UserID.ToString();
                    //newevent.CreateDate = DateTime.Today;
                    newevent.EventDate = DateTime.ParseExact(txtDate.Text.Trim(), "yyyy-MM-dd", null);
                    //newevent.EventName = txtName.Text.Trim();
                    //newevent.EventDesc = txtDesc.Text.Trim();
                    newevent.EventUser = SessionManager.CurrentUser.UserID.ToString();
                    newevent.EventType = "E";
                    if (chkPublic.Checked)
                        newevent.IsPublic = "Y";
                    else
                        newevent.IsPublic = "N";
                    newevent.Status = "A";
                    DAL_Events objEvents = new DAL_Events();
                    if (objEvents.AddNewEvent(newevent, SessionManager.CurrentUser.LanguageCode, txtName.Text.Trim(), txtDesc.Value.Trim()) > 0)
                    {
                        //lblErrDesc.Text = "Event Added successfully";
                        Helper.ShowNotification("Event Added successfully", BusinessDTO.UINotificationType.Success);
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                    {
                        //lblErrDesc.Text = "Error occurred. Please try again later.";
                        Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                    }
                }

            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private bool ValidateInput()
        {
            if (txtDate.Text.Trim() == "") 
            {
                //lblErrDesc.Text = "Event date is mandatory.";
                Helper.ShowNotification("Event date is mandatory.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if(txtName.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Event name is mandatory.";
                Helper.ShowNotification("Event name is mandatory.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            try
            {
                DateTime eventDate = DateTime.ParseExact(txtDate.Text.Trim(), "yyyy-MM-dd", null);
            }
            catch (Exception ex)
            {
               Logger.WriteErrorLog(ex);
               //lblErrDesc.Text = "Please provide a valid date.";
               Helper.ShowNotification("Please provide a valid date.", BusinessDTO.UINotificationType.Notify);
               return false;
            }
            return true;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    Event newevent = new Event();
                    newevent.ID = Convert.ToInt32(hfSelectedEventID.Value);
                    newevent = Helper.AutoFill<Event>(newevent, DBMethod.Update);
                    //newevent.UpdateBy = SessionManager.CurrentUser.UserID.ToString();
                    //newevent.UpdateDate = DateTime.Today;
                    newevent.EventDate = DateTime.ParseExact(txtDate.Text.Trim(), "yyyy-MM-dd", null);
                    //newevent.EventName = txtName.Text.Trim();
                    //newevent.EventDesc = txtDesc.Text.Trim();
                    newevent.EventUser = SessionManager.CurrentUser.UserID.ToString();
                    newevent.EventType = "E";
                    if (chkPublic.Checked)
                        newevent.IsPublic = "Y";
                    else
                        newevent.IsPublic = "N";
                    newevent.Status = "A";
                    DAL_Events objEvents = new DAL_Events();
                    if (objEvents.UpdateEventDetails(newevent, SessionManager.CurrentUser.LanguageCode, txtName.Text.Trim(), txtDesc.Value.Trim()) > 0)
                    {
                        string strMessage = "A new event has been registered. User: " + SessionManager.CurrentUser.DisplayName + " Event Date: " + txtDate.Text.Trim();
                        Emailer.SendEmailMessage(ConfigurationManager.AppSettings["ToEmailAddress"].ToString(), strMessage, "New event registration");
                        //lblErrDesc.Text = "Event updated successfully";
                        Helper.ShowNotification("Event updated successfully", BusinessDTO.UINotificationType.Success);
                        //Response.Redirect("~/Default.aspx");
                        ResetForm();
                        LoadEvents();
                    }
                    else
                    {
                        //lblErrDesc.Text = "Error occurred. Please try again later.";
                        Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    Event newevent = new Event();
                    newevent.ID = Convert.ToInt32(hfSelectedEventID.Value);
                    newevent = Helper.AutoFill<Event>(newevent, DBMethod.Delete);
                    //newevent.DeletedBy = SessionManager.CurrentUser.UserID.ToString();
                    //newevent.DeletedOn = DateTime.Today;
                    //newevent.EventDate = DateTime.ParseExact(txtDate.Text.Trim(), "yyyy-MM-dd", null);
                    //newevent.EventName = txtName.Text.Trim();
                    //newevent.EventDesc = txtDesc.Text.Trim();
                    //newevent.EventUser = SessionManager.CurrentUser.UserID.ToString();
                    //newevent.EventType = "E";
                    //if (chkPublic.Checked)
                    //    newevent.IsPublic = "Y";
                    //else
                    //    newevent.IsPublic = "N";
                    //newevent.Status = "D";
                    using (DAL_Events objEvents = new DAL_Events())
                    {
                        if (objEvents.DeleteEvent(newevent) > 0)
                        {
                            //lblErrDesc.Text = "Event deleted successfully";
                            Helper.ShowNotification("Event deleted successfully", BusinessDTO.UINotificationType.Success);
                            //Response.Redirect("~/Default.aspx");
                            ResetForm();
                            LoadEvents();
                        }
                        else
                        {
                            //lblErrDesc.Text = "Error occurred. Please try again later.";
                            Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void rptEventDetails_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                HiddenField hfEventID = (HiddenField)e.Item.FindControl("hfeventID");
                HiddenField hfEventIsPublic = (HiddenField)e.Item.FindControl("hfEventIsPublic");
                HiddenField hfEventUser = (HiddenField)e.Item.FindControl("hfEventUser");
                Label lblEventName = (Label)e.Item.FindControl("lblEventName");
                Label lblEventDesc = (Label)e.Item.FindControl("lblEventDesc");

                if(hfEventIsPublic.Value == "N" && hfEventUser.Value == SessionManager.CurrentUser.UserID.ToString())
                {
                    pnlAddEvent.Visible = true;
                    btnAdd.Visible = false;
                    btnEdit.Visible = true;
                    btnDelete.Visible = true;
                    txtDate.Text = DateTime.ParseExact(selectedDate, "MM/dd/yyyy", null).ToString("yyyy-MM-dd");
                    txtName.Text = lblEventName.Text;
                    txtDesc.Value = lblEventDesc.Text;
                    chkPublic.Checked = hfEventIsPublic.Value == "Y" ? true : false;
                    hfSelectedEventID.Value = hfEventID.Value;
                }
                else
                {
                    Response.Write("<script>alert('You are not authorized to modify this event.');</script>");
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private void ResetForm()
        {
            btnAdd.Visible = true;
            btnEdit.Visible = false;
            btnDelete.Visible = false;
            txtDate.Text = string.Empty;
            txtName.Text = string.Empty;
            txtDesc.Value = string.Empty;
            chkPublic.Checked = false;
        }
    }
}