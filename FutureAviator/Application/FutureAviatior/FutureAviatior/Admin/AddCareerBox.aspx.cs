using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AddCareerBox : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ctrlCareerBox.MainTitle = "Add Career Box";
                this.Title = "Admin : " + ctrlCareerBox.MainTitle;
                ctrlCareerBox.BoxType = BusinessDTO.BoxContentType.Detail;
                ctrlCareerBox.ImageContentBoxType = BusinessDTO.ImageContentBoxType.Carrers;
            }  
        }
    }
}