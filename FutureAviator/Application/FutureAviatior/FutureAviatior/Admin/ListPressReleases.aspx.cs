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
using System.Configuration;

namespace FutureAviator.Admin
{
    public partial class ListPressReleases : System.Web.UI.Page
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
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);  
            }
        }

        private void BindGrid()
        {
            using (DAL_PressReleases objPressRls = new DAL_PressReleases())
            {
                List<PressReleaseResult> pressReleases = objPressRls.GetAllPressReleases(SessionManager.CurrentUser().LanguageCode);
                if (pressReleases != null && pressReleases.Count > 0)
                {
                    DataTable dtPressReleases = new DataTable();
                    dtPressReleases.Columns.Add("ID", typeof(int));
                    dtPressReleases.Columns.Add("PressRlsDate");
                    dtPressReleases.Columns.Add("Header");
                    dtPressReleases.Columns.Add("ImagePath");

                    foreach (PressReleaseResult pr in pressReleases)
                    {
                        DataRow drPress = dtPressReleases.NewRow();
                        drPress["ID"] = pr.ID;
                        drPress["PressRlsDate"] = pr.PressReleaseDate.ToString("MM/dd/yyyy");
                        drPress["Header"] = pr.Header;
                        drPress["ImagePath"] = ConfigurationManager.AppSettings["PressReleasesImages"] + pr.ImagePath;
                        dtPressReleases.Rows.Add(drPress);
                    }

                    gvPressReleases.DataSource = dtPressReleases;
                    gvPressReleases.DataBind();
                }
                else
                {
                    //lblErrDesc.Text = "No customer stories found.";
                    Helper.ShowNotification("No press releases found.", BusinessDTO.UINotificationType.Notify);
                }
            }
        }

        protected void gvPressReleases_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvPressReleases.PageIndex = e.NewPageIndex;
                BindGrid();
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvPressReleases_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                GridViewRow gvRow = gvPressReleases.Rows[e.RowIndex];
                int ID = Convert.ToInt32(gvRow.Cells[0].Text.Trim());
                using (DAL_PressReleases objPress = new DAL_PressReleases())
                {
                    int iRetVal = objPress.DeletePressRelease(ID, SessionManager.CurrentUser().UserID);
                    if (iRetVal > 0)
                    {
                        Helper.ShowNotification("Press Release deleted successfully.", BusinessDTO.UINotificationType.Success);
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

        protected void gvPressReleases_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvPressReleases.Rows.Count > 0)
                {
                    gvPressReleases.UseAccessibleHeader = true;
                    gvPressReleases.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvPressReleases.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
            
            
        }
    }
}