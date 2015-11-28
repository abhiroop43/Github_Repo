using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AddInternationalStudy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ctrlInternationalStudy.MainTitle = "Add International Study Box";
                this.Title = "Admin : " + ctrlInternationalStudy.MainTitle;
                ctrlInternationalStudy.BoxType = BusinessDTO.BoxContentType.Link;
                ctrlInternationalStudy.ImageContentBoxType = BusinessDTO.ImageContentBoxType.InternationalStudy;
            } 
        }
    }
}