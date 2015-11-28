using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using ExceptionLogger;

namespace FutureAviator.UserControls
{
    public partial class DisplayNews : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNews();
            }
        }
        private void BindNews()
        {
            try
            {
                using (DAL_News dalNews = new DAL_News())
                {
                    List<NewsResult> NewsList = dalNews.GetAllActiveNews(SessionManager.CurrentUser().LanguageCode);
                    if (NewsList != null && NewsList.Count > 0)
                    {
                        rptHomeNews.DataSource = NewsList;
                        rptHomeNews.DataBind();
                    }
                    else
                    {

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