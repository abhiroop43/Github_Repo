using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.UserControls
{
    public partial class LanguageSwitch : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                SetLabel();
            }
        }

        private void SetLabel()
        {
            if (Request.Cookies["language"] != null)
            {
                string languageCode = Request.Cookies["language"].Value;
                //lnkbtnLanguage.Text = languageCode == "ar" ? "العربية" : "English";
                lnkbtnLanguage.Text = languageCode == "ar" ? "English" : "العربية";
            }
            else
            {
                lnkbtnLanguage.Text = "العربية";
            }

        }
        protected void lnkbtnLanguage_Click(object sender, EventArgs e)
        {
            if (lnkbtnLanguage.Text == "English")
            {
                //SaveLanguageCodeInCookies("ar");
                //SessionManager.CurrentUser.LanguageCode = BusinessDTO.ApplicationLanguages.ar;
                SaveLanguageCodeInCookies("en");
                SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.en;
                lnkbtnLanguage.Text = "العربية";
            }
            else
            {
                //SaveLanguageCodeInCookies("en");
                //SessionManager.CurrentUser.LanguageCode = BusinessDTO.ApplicationLanguages.en;
                SaveLanguageCodeInCookies("ar");
                SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.ar;
                lnkbtnLanguage.Text = "English";
            }

            Response.Redirect(Request.RawUrl);
        }

        public void SaveLanguageCodeInCookies(string strLanguageCode)
        {
            HttpCookie LanguageCookies = new HttpCookie("language");
            LanguageCookies.Value = strLanguageCode;
            LanguageCookies.Expires = DateTime.Now.AddYears(10);
            Response.Cookies.Add(LanguageCookies);
        }
        #region Old Code
        // private void SetLabel()
        //{
        //    if (Request.Cookies["language"] != null)
        //    {
        //        string languageCode = Request.Cookies["language"].Value;


        //        if (languageCode == "en")
        //        {
        //            imgLanguage.ImageUrl = "~/userassets/img/arabic.png";
        //            imgLanguage.ToolTip = "العربية";
        //        }
        //        else
        //        {
        //            imgLanguage.ImageUrl = "~/userassets/img/arabic.png";
        //            imgLanguage.ToolTip = "English";
        //        }
        //    }
        //    else
        //    {
        //        imgLanguage.ImageUrl = "~/userassets/img/arabic.png";
        //        imgLanguage.ToolTip = "العربية";
        //    }
        //}
        //protected void lnkbtnLanguage_Click(object sender, EventArgs e)
        //{
        //    if (imgLanguage.ToolTip == "English")
        //    {
        //        imgLanguage.ImageUrl = "~/userassets/img/arabic.png";
        //        imgLanguage.ToolTip = "العربية";
        //        //SaveLanguageCodeInCookies("ar");
        //        //SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.ar;
        //        SaveLanguageCodeInCookies("en");
        //        SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.en;
        //    }
        //    else
        //    {
        //        imgLanguage.ImageUrl = "~/userassets/img/arabic.png";
        //        imgLanguage.ToolTip = "English";
        //        //SaveLanguageCodeInCookies("en");
        //        //SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.en;
        //        SaveLanguageCodeInCookies("ar");
        //        SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.ar;
        //    }

        //    Response.Redirect(Request.RawUrl);
        //}

        //public void SaveLanguageCodeInCookies(string strLanguageCode)
        //{
        //    HttpCookie LanguageCookies = new HttpCookie("language");
        //    LanguageCookies.Value = strLanguageCode;
        //    LanguageCookies.Expires = DateTime.Now.AddYears(10);
        //    Response.Cookies.Add(LanguageCookies);
        //}
        #endregion
    }
}