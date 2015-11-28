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
using System.Web.UI.HtmlControls;

namespace FutureAviator
{
    public partial class PrivacyPolicy : System.Web.UI.Page
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
            try
            {
                if (!this.IsPostBack)
                {
                    //body.Attributes.Remove("dir");
                    //if (SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.ar)
                    //{
                    //    body.Attributes.Add("dir", "rtl");
                    //}
                    //else
                    //{
                    //    body.Attributes.Add("dir", "ltr");
                    //}
                    body.Attributes.Remove("dir");
                    //if (SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.ar)
                    //{
                    //    var link = new HtmlLink();
                    //    link.Href = "userassets/css/bootstrap-rtl.min.css";
                    //    link.Attributes.Add("rel", "stylesheet");
                    //    link.Attributes.Add("type", "text/css");
                    //    Page.Header.Controls.Add(link);
                    //    body.Attributes.Add("dir", "rtl");
                    //}
                    //else
                    //{
                    //    body.Attributes.Add("dir", "ltr");
                    //}
                    LoadPolicyContent();
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private void LoadPolicyContent()
        {
            using (DAL_PrivacyPolicy objPriv = new DAL_PrivacyPolicy())
            {
                List<PrivacyPolicyResult> privacyPoliciesEnglish = objPriv.GetPrivacyPolicy(SessionManager.CurrentUser().LanguageCode);
                foreach (PrivacyPolicyResult policy in privacyPoliciesEnglish)
                {
                    dvPolicyContent.InnerHtml = policy.PolicyContent;
                }
            }
        }
    }
}