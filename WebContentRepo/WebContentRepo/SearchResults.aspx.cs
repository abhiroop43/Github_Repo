using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using RepoBLL;
using System.Net;
using System.Security.Principal;
using System.Configuration;

namespace WebContentRepo.UI
{
    public partial class SearchResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!this.IsPostBack)
                {
                    BindRepeater();
                }
            }
            catch (Exception ex)
            {
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        private void BindRepeater()
        {
            try
            {
                DataTable dtSearchResults = Session["SearchResults"] as DataTable;
                if(dtSearchResults!= null && dtSearchResults.Rows.Count > 0)
                {
                    rptFiles.DataSource = dtSearchResults;
                    rptFiles.DataBind();
                }
                else
                {
                    throw new Exception("No records found.");
                }
            }
            catch (Exception ex)
            {
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
                throw ex;
            }
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            try
            {
                 DataTable dtSearchResults = Session["SearchResults"] as DataTable;
                 if (dtSearchResults != null && dtSearchResults.Rows.Count > 0)
                 {
                     WebClient wc = new WebClient();
                     foreach(DataRow drResult in dtSearchResults.Rows)
                     {
                         string strFileName = drResult["Filename"].ToString();
                         string strFileExtn = drResult["Extension"].ToString();
                         string strRepoPath = drResult["Filepath"].ToString();
                         string strDownloadPath = ConfigurationManager.AppSettings["Downloadpath"].ToString() + strFileName + "." + strFileExtn;
                         wc.DownloadFile(strRepoPath, strDownloadPath);
                     }
                 }
                //WebClient wc = new WebClient();
                //wc.DownloadFile(@"F:\visual_studio\Assignment\Lab3\Repo\CC\02_05_d_51_cc_e.pdf", @"F:\visual_studio\test.pdf");
            }
            catch (Exception ex)
            {
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }
    }
}