using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FutureAviator
{
    public static class SessionManager
    {
        //public static CurrentUser CurrentUser { get; set; }

        public static CurrentUser CurrentUser()
        {
           
            if (HttpContext.Current.Session["FutureUser"] != null)
                return (CurrentUser)HttpContext.Current.Session["FutureUser"];
            else
            {
                CurrentUser myUser = new CurrentUser();
                if(HttpContext.Current.Request.Cookies["language"] != null)
                {
                    string languageCode = HttpContext.Current.Request.Cookies["language"].Value.Trim();
                    myUser.LanguageCode = (languageCode == "ar" ? ApplicationLanguages.ar : ApplicationLanguages.en);
                    return myUser;
                }
                else
                {
                    HttpCookie LanguageCookies = new HttpCookie("language");
                    LanguageCookies.Value = "en";
                    LanguageCookies.Expires = DateTime.Now.AddYears(10);
                    HttpContext.Current.Response.Cookies.Add(LanguageCookies);
                    myUser.LanguageCode = ApplicationLanguages.en;
                    return myUser;
                }
                    
               
            }
                
        }

        public static void CurrentUser(CurrentUser currentUser)
        {
            HttpContext.Current.Session["FutureUser"] = currentUser;
        }

        public static void RemoveCurrentUser()
        {
            try
            {
                HttpContext.Current.Session["FutureUser"] = null;
                HttpContext.Current.Session.Clear();
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        //CurrentUser CurrentUser = new CurrentUser();
    }

    public class CurrentUser
    {
        public long UserID { get; set; }
        public int UserTypeID { get; set; }
        public string DisplayName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public BusinessDTO.ApplicationLanguages LanguageCode { get; set; }
    }
}