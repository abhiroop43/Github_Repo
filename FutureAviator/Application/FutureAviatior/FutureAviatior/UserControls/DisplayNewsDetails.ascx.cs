using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;
using FutureAviator.Utlitity;
using ExceptionLogger;

namespace FutureAviator.UserControls
{
    public partial class DisplayNewsDetails : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                try
                {
                    if (Request.QueryString["id"] != null)
                    {
                        long lngNewsID = Convert.ToInt64(Request.QueryString["id"]);
                        GetNewsDetail(lngNewsID);
                    }
                }
                catch (Exception ex)
                {
                    Logger.WriteErrorLog(ex);
                }
            }
        }
        private void GetNewsDetail(long NewsID)
        {
            try
            {
                using(DAL_News dalNews = new DAL_News())
                {
                    NewsResult newsResult = dalNews.GetNewsByID(SessionManager.CurrentUser().LanguageCode, NewsID);
                    if(newsResult != null)
                    {
                        imgNews.ImageUrl = Helper.NEWS_IMAGE_PATH + newsResult.ImagePath;
                        imgNews.ImageAlign = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? ImageAlign.Left : ImageAlign.Right;
                        ltNewsDescription.Text = newsResult.NewsDescription;

                        string textAligh = FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? "text-align:left" : "text-align:right";

                       

                        MainDiv.Attributes.Add("style", textAligh);
                    }
                    
                }
            }
            catch (Exception ex)
            {

                Logger.WriteErrorLog(ex);
            }
        }
    }
}