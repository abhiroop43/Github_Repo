using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AddUAEStudy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ctrlUAEStudy.MainTitle = "Add UAE Study Box";
                this.Title = "Admin : " + ctrlUAEStudy.MainTitle;
                ctrlUAEStudy.BoxType = BusinessDTO.BoxContentType.Link;
                ctrlUAEStudy.ImageContentBoxType = BusinessDTO.ImageContentBoxType.UAEStudy;
            }  
        }
    }
}