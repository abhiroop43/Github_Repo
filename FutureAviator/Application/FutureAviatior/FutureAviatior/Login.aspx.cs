using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Globalization;
using System.Configuration;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using System.Web.UI.HtmlControls;

namespace FutureAviator
{
    public partial class Login : System.Web.UI.Page
    {
        protected override void InitializeCulture()
        {
            if (Request.Cookies["language"] != null)
            {
                string languageCode = Request.Cookies["language"].Value.Trim();

                UICulture = languageCode == "ar" ? "ar-ae" : "en-us";
                Culture = languageCode == "ar" ? "ar-ae" : "en-us";

            }
            else
            {
                UICulture = "en-us";
                Culture = "en-us";
            }
            base.InitializeCulture();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                pageBody.Attributes.Remove("dir");
                if (SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.ar)
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


                    pageBody.Attributes.Add("dir", "rtl");
                }
                else
                {
                    pageBody.Attributes.Add("dir", "ltr");
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidateInput())
                {
                    return;
                }
                bool Authenticated = false;
                LoginHelper objLogin = new LoginHelper();
                Authenticated = objLogin.AuthenticateUser(txtEmailID.Text.Trim(), txtPassword.Text.Trim());

                if (Authenticated)
                {
                    if (SessionManager.CurrentUser() == null)
                    {
                        SessionManager.CurrentUser().LanguageCode = BusinessDTO.ApplicationLanguages.en;
                        string strLanguageCode = "en";
                        HttpCookie LanguageCookies = new HttpCookie("language");
                        LanguageCookies.Value = strLanguageCode;
                        LanguageCookies.Expires = DateTime.Now.AddYears(10);
                        Response.Cookies.Add(LanguageCookies);
                    }

                    if (SessionManager.CurrentUser().UserTypeID == (int)BusinessDTO.UserType.User)
                    {
                        if (Request.QueryString["source"] != null)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, pnlUpdate.GetType(), "alertUser", "parent.LoginSuccessCallBack();", true);
                        }
                        else
                            Response.Redirect(ConfigurationManager.AppSettings["HomePage"]);
                    }

                    else if (SessionManager.CurrentUser().UserTypeID == (int)BusinessDTO.UserType.Administrator)
                    {
                        if (Request.QueryString["source"] != null)
                        {
                            ScriptManager.RegisterStartupScript(this.Page, pnlUpdate.GetType(), "alertUser", "window.parent.location='admin/AdminWelcome.aspx';", true);
                        }
                        else
                        {
                            if (Request.QueryString["return"] != null)
                                Response.Redirect(Convert.ToString(Request.QueryString["return"]));
                            else
                                Response.Redirect(ConfigurationManager.AppSettings["AdminSiteURL"]);
                        }
                    }
                }
                else
                {
                    //lblErrDesc.Text = "Login was not successful. Please check your Email ID and/or password";
                    Helper.ShowNotification("Invalid Email ID and/or password", BusinessDTO.UINotificationType.Error);
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private bool ValidateInput()
        {
            if (txtEmailID.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Email ID cannot be blank";
                Helper.ShowNotification("Email ID cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtPassword.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Password cannot be blank";
                Helper.ShowNotification("Password cannot be blank", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            return true;
        }
    }
}