using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AllCareerBoxes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AllCarrerBoxes.ImageContentBoxType = BusinessDTO.ImageContentBoxType.Carrers;
                AllCarrerBoxes.UpdatePageURL = "AddCareerBox.aspx";
                AllCarrerBoxes.BoxType = BusinessDTO.BoxContentType.Detail;
                AllCarrerBoxes.MainTitle = "All Careers";
                this.Title = "Admin : " + AllCarrerBoxes.MainTitle;
            }
        }
    }
}