using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace FutureAviator
{
    public partial class NewsDetails : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (Request.Cookies["language"] != null)
            {
                string languageCode = Request.Cookies["language"].Value.Trim();

                UICulture = languageCode == "ar" ? "ar-ae" : "en-us";
                Culture = languageCode == "ar" ? "ar-ae" : "en-us";
                SessionManager.CurrentUser().LanguageCode = languageCode == "ar" ? ApplicationLanguages.ar : ApplicationLanguages.en;

            }
            else
            {
                UICulture = "en-us";
                Culture = "en-us";
                SessionManager.CurrentUser().LanguageCode = ApplicationLanguages.en;
                HttpCookie LanguageCookies = new HttpCookie("language");
                LanguageCookies.Value = "en";
                LanguageCookies.Expires = DateTime.Now.AddYears(10);
                Response.Cookies.Add(LanguageCookies);
            }
            base.InitializeCulture();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            body.Attributes.Remove("dir");
            if (SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.ar)
            {
                var link = new HtmlLink();
                link.Href = "userassets/css/bootstrap-rtl.min.css";
                link.Attributes.Add("rel", "stylesheet");
                link.Attributes.Add("type", "text/css");
                Page.Header.Controls.Add(link);

                //add bootstrap-flipped//
                var lnkBtsFlp = new HtmlLink();

                body.Attributes.Add("dir", "rtl");

                lnkBtsFlp.Href = "userassets/css/bootstrap-flipped.css";
                lnkBtsFlp.Attributes.Add("rel", "stylesheet");
                lnkBtsFlp.Attributes.Add("type", "text/css");
                Page.Header.Controls.Add(lnkBtsFlp);

               

                body.Attributes.Add("dir", "rtl");
            }
            else
            {
                body.Attributes.Add("dir", "ltr");
            }
        }
    }
}