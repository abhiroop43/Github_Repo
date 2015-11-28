using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AllInternationalStudies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ctrlAllInternationalStudies.ImageContentBoxType = BusinessDTO.ImageContentBoxType.InternationalStudy;
                ctrlAllInternationalStudies.UpdatePageURL = "AddInternationalStudy.aspx";
                ctrlAllInternationalStudies.BoxType = BusinessDTO.BoxContentType.Link;
                ctrlAllInternationalStudies.MainTitle = "All International Studies";
                this.Title = "Admin : " + ctrlAllInternationalStudies.MainTitle;
            }
        }
    }
}