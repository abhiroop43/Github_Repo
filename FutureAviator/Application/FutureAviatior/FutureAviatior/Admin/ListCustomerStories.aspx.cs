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
    public partial class ListCustomerStories : System.Web.UI.Page
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
            using (DAL_CustomerStory objCust = new DAL_CustomerStory())
            {
                List<CustStoryResult> custStories = objCust.GetAllStories(SessionManager.CurrentUser().LanguageCode);
                if(custStories !=null && custStories.Count > 0)
                {
                    DataTable dtCustStories = new DataTable();
                    dtCustStories.Columns.Add("ID", typeof(int));
                    dtCustStories.Columns.Add("CustName");
                    dtCustStories.Columns.Add("Designation");
                    dtCustStories.Columns.Add("ImageUrl");

                    foreach(CustStoryResult cs in custStories)
                    {
                        DataRow drStory = dtCustStories.NewRow();
                        drStory["ID"] = cs.StoryID;
                        drStory["CustName"] = cs.CustName;
                        drStory["Designation"] = cs.Designation;
                        //drStory["ImageUrl"] = String.Format("data:image/jpg;base64,{0}", Convert.ToBase64String(cs.CustPicture));
                        //drStory["ImageUrl"] = Convert.ToBase64String(cs.CustPicture);
                        dtCustStories.Rows.Add(drStory);
                    }

                    gvCustomerStories.DataSource = dtCustStories;
                    gvCustomerStories.DataBind();
                }
                else
                {
                    //lblErrDesc.Text = "No customer stories found.";
                    Helper.ShowNotification("No customer stories found.", BusinessDTO.UINotificationType.Notify);
                }
            }

        }

        protected void gvCustomerStories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow gvRow = gvCustomerStories.Rows[index];
                string storyID = gvRow.Cells[1].Text.Trim();
                Response.Redirect("~/Admin/UploadCustomerStory.aspx?StoryID=" + storyID);
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvCustomerStories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvCustomerStories.PageIndex = e.NewPageIndex;
                BindGrid();
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvCustomerStories_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvCustomerStories.Rows.Count > 0)
                {
                    gvCustomerStories.UseAccessibleHeader = true;
                    gvCustomerStories.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvCustomerStories.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
            
        }

        protected void gvCustomerStories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                GridViewRow gvRow = gvCustomerStories.Rows[e.RowIndex];
                int storyID = Convert.ToInt32(gvRow.Cells[0].Text.Trim());
                using(DAL_CustomerStory objCust = new DAL_CustomerStory())
                {
                    int iRetVal = objCust.DeleteStory(storyID, SessionManager.CurrentUser().UserID);
                    if(iRetVal > 0)
                    {
                        Helper.ShowNotification("Customer story deleted successfully.", BusinessDTO.UINotificationType.Success);
                        BindGrid();
                    }
                    else
                    {
                        Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }
    }
}