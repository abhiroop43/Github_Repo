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
using System.Configuration;
using System.Web.UI.HtmlControls;

namespace FutureAviator
{
    public partial class PressReleaseDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                body.Attributes.Remove("dir");
                if (SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.ar)
                {
                    var link = new HtmlLink();
                    link.Href = "userassets/css/bootstrap-rtl.min.css";
                    link.Attributes.Add("rel", "stylesheet");
                    link.Attributes.Add("type", "text/css");
                    Page.Header.Controls.Add(link);
                    body.Attributes.Add("dir", "rtl");
                }
                else
                {
                    body.Attributes.Add("dir", "ltr");
                }
                if(!this.IsPostBack)
                {
                    if (Request.QueryString["ID"] != null && Request.QueryString["ID"] != "")
                    {
                        hfPressRlsID.Value = Request.QueryString["ID"].ToString();
                        LoadData();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }

        private void LoadData()
        {
            if(hfPressRlsID.Value.Trim() == "")
            {
                return;
            }
            int ID = Convert.ToInt32(hfPressRlsID.Value.Trim());
            using (DAL_PressReleases objPress = new DAL_PressReleases())
            {
                List<PressReleaseResult> pressReleases = objPress.GetAllPressReleases(SessionManager.CurrentUser().LanguageCode, ID);
                if (pressReleases != null && pressReleases.Count > 0)
                {
                    foreach (PressReleaseResult pr in pressReleases)
                    {
                        lblRlsHeader.Text = pr.Header;
                        lblRlsDate.Text = "Date: " + pr.PressReleaseDate.ToString("MM/dd/yyyy");
                        lblRlsContent.Text = pr.PressReleaseContent;
                        imgPress.ImageUrl = ConfigurationManager.AppSettings["PressReleasesImages"] + pr.ImagePath;
                    }
                }
            }
        }
    }
}