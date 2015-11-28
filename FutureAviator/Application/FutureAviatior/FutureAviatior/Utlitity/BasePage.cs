using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Utlitity
{
    public class BasePage : System.Web.UI.Page
    {
        #region Overridden Page Events
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (SessionManager.CurrentUser()!= null && SessionManager.CurrentUser().UserID == 0)
            {
                Response.Redirect(FutureAviator.Utlitity.Helper.LOGIN_PAGE_URL +"?return=" + Request.RawUrl);
            }
        }

        protected override void OnLoad(EventArgs e)
        {

            base.OnLoad(e);
        }

        protected override void OnPreRenderComplete(EventArgs e)
        {
            base.OnPreRenderComplete(e);

        }
        #endregion
    }
}