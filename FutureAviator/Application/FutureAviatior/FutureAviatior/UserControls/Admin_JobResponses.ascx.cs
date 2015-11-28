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
    public partial class Admin_JobResponses : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                using (DAL_JobResponse dalJobResponses = new DAL_JobResponse())
                {
                    List<JobResponsResult> resultList = dalJobResponses.GetAllJobResponses();
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