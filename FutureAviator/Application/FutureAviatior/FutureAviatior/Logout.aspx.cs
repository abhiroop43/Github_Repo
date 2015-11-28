using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (SessionManager.CurrentUser() != null && SessionManager.CurrentUser().UserID > 0)
                    {
                        SessionManager.RemoveCurrentUser(); ;
                        //Response.Redirect("~/Login.aspx");
                    }
                    Response.Redirect("~/Default.aspx");
                }
                catch (Exception ex)
                {
                    ExceptionLogger.Logger.WriteErrorLog(ex);
                }
            }
        }
    }
}