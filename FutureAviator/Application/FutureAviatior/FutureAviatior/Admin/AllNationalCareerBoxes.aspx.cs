using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Admin
{
    public partial class AllNationalCareerBoxes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AllNationalCarrerBoxes.ImageContentBoxType = BusinessDTO.ImageContentBoxType.NationalCarrers;
                AllNationalCarrerBoxes.UpdatePageURL = "AddNationalCareerBox.aspx";
                AllNationalCarrerBoxes.BoxType = BusinessDTO.BoxContentType.Link;
                AllNationalCarrerBoxes.MainTitle = "All National Careers";
                this.Title = "Admin : " + AllNationalCarrerBoxes.MainTitle;
            }
        }
    }
}