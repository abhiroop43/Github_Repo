using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;

namespace Steganography
{
    public partial class Decryption : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }
    }
}