using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.Data;
using RepoBLL;

namespace WebContentRepo
{
    public partial class Search : System.Web.UI.Page
    {
        BusinessLogic objBLL;

        public Search()
        {
            objBLL = new BusinessLogic();
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                //download file to a selected path//
                //WebClient wc = new WebClient();
                //wc.DownloadFile(@"F:\visual_studio\Assignment\Lab3\Repo\CC\02_05_d_51_cc_e.pdf", @"F:\visual_studio\test.pdf");

                if(ValidateInputs())
                {
                    DataTable dtSearchResults = objBLL.GetSearchResults(txtSearch.Value.Trim(), Convert.ToInt32(txtNoOfLinks.Value.Trim()), WindowsIdentity.GetCurrent().Name);
                    
                    //load in session and send to search results page//
                    Session["SearchResults"] = dtSearchResults;
                    Response.Redirect("~/SearchResults.aspx");
                }
            }
            catch (Exception ex)
            {
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        private bool ValidateInputs()
        {
            if(txtSearch.Value.Trim()==string.Empty)
            {
                return false;                
            }

            if (txtNoOfLinks.Value.Trim() == string.Empty)
            {
                return false;
            }

            return true;
        }
    }
}