using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator
{
    public partial class ErrorLog : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLog();
            }
        }
        #endregion
        #region Method
        private void BindLog()
        {
            try
            {
                List<BugLog> bugLog = FutureAviator.Utlitity.Helper.GetBugLog();
                if (bugLog != null && bugLog.Count > 0)
                {
                    bugLog.RemoveAll(r => String.IsNullOrEmpty(r.ErrorMessage.Trim()));
                    gv.DataSource = bugLog;
                    gv.DataBind();
                }

            }
            catch (Exception ex)
            {

            }
        }
        #endregion

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

    }
}