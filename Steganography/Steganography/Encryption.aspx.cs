using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.IO;

namespace Steganography
{
    public partial class Encryption : System.Web.UI.Page
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
                lblError.Text = string.Empty;
                if (fpInputText.HasFile && fpInputImage.HasFile && Request.Files.Count > 1 && Request.Files[0].ContentLength > 0 && Request.Files[0].ContentLength > 0 && ValidateFileExtn())
                {

                    HttpPostedFile hpfFile = Request.Files["ctl00$cpBody$fpInputText"];
                    HttpPostedFile hpfImage = Request.Files["ctl00$cpBody$fpInputImage"];
                    string fileContents = new StreamReader(hpfFile.InputStream).ReadToEnd();
                    string ImageContents = new StreamReader(hpfImage.InputStream).ReadToEnd();
                    //byte[] imageData = System.Text.Encoding.ASCII.GetBytes(ImageContents.Trim());

                    string binaryFileData = string.Empty;
                    string binaryImageData = string.Empty;

                    foreach (char ch in fileContents.Trim())
                    {
                        binaryFileData += Convert.ToString((int)ch, 2);
                    }

                    foreach (char ch in ImageContents.Trim())
                    {
                        binaryImageData += Convert.ToString((int)ch, 2);
                    }

                    string rev = "";

                    foreach(char ch in binaryImageData.Trim())
                    {
                        rev += Convert.ToString((char)ch);
                    }
                }
                else
                {
                    lblError.Text = "Please select a valid text file to encrypt";
                    return;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        private bool ValidateFileExtn()
        {
            string strExtn = fpInputText.FileName.Substring(fpInputText.FileName.LastIndexOf('.') + 1);
            if (strExtn.ToLower().Trim() != "txt")
            {
                lblError.Text = "Only plaintext files (.txt format) are allowed";
                return false;
            }
            else
                return true;
        }
    }
}