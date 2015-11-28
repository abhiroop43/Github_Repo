using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace FutureAviator.MasterPages
{
    public partial class UserMaster : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            string languageCode = Request.Cookies["language"].Value;
            if (Request.Cookies["language"] != null)
            {

                if (SessionManager.CurrentUser() != null)
                    SessionManager.CurrentUser().LanguageCode = (languageCode == "ar" ? BusinessDTO.ApplicationLanguages.ar : BusinessDTO.ApplicationLanguages.en);
            }
            else
            {
                if (SessionManager.CurrentUser() != null)
                    SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.en;
            }
            masterbody.Attributes.Remove("dir");
            masterbody.Attributes.Remove("class");
            if (SessionManager.CurrentUser() != null)
                if (languageCode == "ar")
                {
                    var link = new HtmlLink();
                    link.Href = "../userassets/css/bootstrap-rtl.min.css";
                    link.Attributes.Add("rel", "stylesheet");
                    link.Attributes.Add("type", "text/css");
                    Page.Header.Controls.Add(link);


                    var link2 = new HtmlLink();
                    link2.Href = "../userassets/css/bootstrap-flipped.css";
                    link2.Attributes.Add("rel", "stylesheet");
                    link2.Attributes.Add("type", "text/css");
                    Page.Header.Controls.Add(link2);




                    LiteralControl ltr = new LiteralControl();
                    ltr.Text = "<style>.row{ margin-left: 0px !important;}.TextAlighLeft{ text-align:right;} .TextAlighRight{ text-align:left;}</style>";
                    this.Page.Header.Controls.Add(ltr);

                    masterbody.Attributes.Add("dir", "rtl");
                    masterbody.Attributes.Add("class", "TextAlighLeft");

                }
                else
                {
                    masterbody.Attributes.Add("dir", "ltr");
                    LiteralControl ltr = new LiteralControl();
                    ltr.Text = "<style>.row{ margin-right: 0px !important;}.TextAlighLeft{ text-align:left;} .TextAlighRight{ text-align:right;}</style>";
                    this.Page.Header.Controls.Add(ltr);
                    masterbody.Attributes.Add("class", "TextAlighLeft");
                }
        }
    }
}