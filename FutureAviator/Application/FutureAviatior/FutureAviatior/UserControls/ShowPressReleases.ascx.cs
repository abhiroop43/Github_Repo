using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Reflection;

namespace FutureAviator.UserControls
{
    public partial class ShowPressReleases : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    BindData();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }
        private void BindData()
        {
            try
            {
                using (DAL_News dalNews = new DAL_News())
                {
                    List<NewsResult> NewsList = dalNews.GetAllActiveNews(SessionManager.CurrentUser().LanguageCode);
                    NewsList = NewsList.OrderByDescending(e => e.PressReleaseDate).ToList();
                    rptPressReleases.DataSource = NewsList;
                    rptPressReleases.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
            #region Press Commented Release Code
            //using(DAL_PressReleases objPress = new DAL_PressReleases())
            //{
            //    List<PressReleaseResult> pressReleases = objPress.GetAllPressReleases(SessionManager.CurrentUser().LanguageCode);
            //    if(pressReleases!=null && pressReleases.Count > 0)
            //    {
            //        DataTable dtPressReleases = new DataTable();
            //        dtPressReleases.Columns.Add("ID", typeof(int));
            //        dtPressReleases.Columns.Add("PressRlsHeader");
            //        dtPressReleases.Columns.Add("PressRlsContent");
            //        dtPressReleases.Columns.Add("PressRlsDate");
            //        dtPressReleases.Columns.Add("ImageUrl");

            //        foreach (PressReleaseResult pr in pressReleases)
            //        {
            //            DataRow drPress = dtPressReleases.NewRow();
            //            drPress["ID"] = pr.ID;
            //            drPress["PressRlsHeader"] = pr.Header;
            //            string pressRlsContent = "";
            //            int CharsToShow = Convert.ToInt32(ConfigurationManager.AppSettings["PressReleaseLength"]);
            //            if (pr.PressReleaseContent.Length > CharsToShow)
            //            {
            //                pressRlsContent = pr.PressReleaseContent.Substring(0, CharsToShow - 3) + "...";
            //            }
            //            else
            //            {
            //                pressRlsContent = pr.PressReleaseContent;
            //            }
            //            drPress["PressRlsContent"] = pressRlsContent;
            //            drPress["PressRlsDate"] = pr.PressReleaseDate.ToString("MM/dd/yyyy");
            //            string ImagePath = ConfigurationManager.AppSettings["PressReleasesImages"] + pr.ImagePath;
            //            drPress["ImageUrl"] = ImagePath;
            //            dtPressReleases.Rows.Add(drPress);
            //        }
            //        rptPressReleases.DataSource = dtPressReleases;
            //        rptPressReleases.DataBind();
            //    }
            //}
            #endregion
        }
    }
}