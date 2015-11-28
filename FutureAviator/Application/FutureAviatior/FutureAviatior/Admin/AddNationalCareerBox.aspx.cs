using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AddNationalCareerBox : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ctrlNationalCareerBox.MainTitle = "Add National Career Box";
                this.Title = "Admin : " + ctrlNationalCareerBox.MainTitle;
                ctrlNationalCareerBox.BoxType = BusinessDTO.BoxContentType.Link;
                ctrlNationalCareerBox.ImageContentBoxType = BusinessDTO.ImageContentBoxType.NationalCarrers;
            }  
        }
    }
}