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
    public partial class Admin_RegiseredJobs : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MessageType"] != null)
                {
                    if (Convert.ToString(Request.QueryString["MessageType"]).Trim().ToLower() == "successupdate")
                    {
                        Helper.ShowNotification("Update Successfully", UINotificationType.Success);
                    }
                }
                BindGrid();
            }
        }
        protected void gv_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gv.Rows.Count > 0)
                {
                    gv.UseAccessibleHeader = true;
                    gv.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gv.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
        }
        #endregion
        #region Methods
        private void BindGrid()
        {
            try
            {
                using (DAL_Job dalJob = new DAL_Job())
                {
                    List<JobResult> resultList = dalJob.GetAllJobs();
                    if (resultList != null && resultList.Count > 0)
                    {
                        gv.DataSource = resultList;
                        gv.DataBind();
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