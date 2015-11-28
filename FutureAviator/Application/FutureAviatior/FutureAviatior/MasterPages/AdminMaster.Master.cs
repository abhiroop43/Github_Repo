using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.MasterPages
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionManager.CurrentUser() == null || SessionManager.CurrentUser().UserTypeID != (int)BusinessDTO.UserType.Administrator || SessionManager.CurrentUser().UserID <= 0)
            {
                Response.Redirect(FutureAviator.Utlitity.Helper.LOGIN_PAGE_URL + "?return=" + Request.RawUrl);
                //Response.Write("<script>alert('You are not authorized to access this page. Please log in as administrator to continue.');window.location='../Login.aspx';</script>");
                //Response.Redirect("~/Login.aspx");
            }
        }
    }
}