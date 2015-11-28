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
using System.Data;

namespace FutureAviator.Admin
{
    public partial class ListAdminEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    BindGrid();
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private void BindGrid()
        {
            DataTable dtEvents = new DataTable();
            dtEvents.Columns.Add("EventToDate");
            dtEvents.Columns.Add("EventFromDate");
            dtEvents.Columns.Add("EventName", typeof(string));
            dtEvents.Columns.Add("Venue", typeof(string));
            dtEvents.Columns.Add("ID", typeof(int));
            using(DAL_Events objEvent = new DAL_Events())
            {
                List<EventResult> events = objEvent.GetEvents(SessionManager.CurrentUser().LanguageCode);
                foreach (EventResult e in events)
                {
                    DataRow drRow = dtEvents.NewRow();
                    drRow["EventToDate"] = e.EventToDate.ToString("MM/dd/yyyy");
                    drRow["EventFromDate"] = e.EventFromDate.ToString("MM/dd/yyyy");
                    drRow["Venue"] = e.EventVenue;
                    drRow["EventName"] = e.EventName;
                    drRow["ID"] = e.EventID;
                    dtEvents.Rows.Add(drRow);
                }                
            }
            gvAdminEvents.DataSource = dtEvents;
            gvAdminEvents.DataBind();
        }

        protected void gvAdminEvents_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvAdminEvents.PageIndex = e.NewPageIndex;
                BindGrid();
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvAdminEvents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                GridViewRow gvRow = gvAdminEvents.Rows[e.RowIndex];
                int eventID = Convert.ToInt32(gvRow.Cells[0].Text.Trim());
                using (DAL_Events objEvent = new DAL_Events())
                {
                    int iRetVal = objEvent.DeleteEvent(eventID, SessionManager.CurrentUser().UserID);
                    if(iRetVal > 0)
                    {
                        Helper.ShowNotification("Event deleted successfully.", BusinessDTO.UINotificationType.Success);
                        BindGrid();
                    }
                    else
                    {
                        Helper.ShowNotification("An error occurred. Unable to delete event.", BusinessDTO.UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvAdminEvents_PreRender(object sender, EventArgs e)
        {

            try
            {
                if (gvAdminEvents.Rows.Count > 0)
                {
                    gvAdminEvents.UseAccessibleHeader = true;
                    gvAdminEvents.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvAdminEvents.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }

        }
    }
}