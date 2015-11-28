using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AllUAEStudies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ctrlAllUAEStudies.ImageContentBoxType = BusinessDTO.ImageContentBoxType.UAEStudy;
                ctrlAllUAEStudies.UpdatePageURL = "AddUAEStudy.aspx";
                ctrlAllUAEStudies.BoxType = BusinessDTO.BoxContentType.Link;
                ctrlAllUAEStudies.MainTitle = "All UAE Studies";
                this.Title = "Admin : " + ctrlAllUAEStudies.MainTitle;
            }  
        }
    }
}