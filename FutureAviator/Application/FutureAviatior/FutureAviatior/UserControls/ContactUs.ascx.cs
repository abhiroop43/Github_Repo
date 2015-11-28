using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;

namespace FutureAviator.UserControls
{
    public partial class ContactUs : System.Web.UI.UserControl
    {
        DAL_ContactCustomer objContact = new DAL_ContactCustomer();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en)
            {
                contactus.InnerHtml = GetGlobalResourceObject("English", "ContactUs").ToString();
                cmsContactUsDesc.InnerHtml = GetGlobalResourceObject("English", "ContactUsMessage").ToString();

                //Set Place Holders
                txtName.Attributes.Add("placeholder", GetGlobalResourceObject("English", "YourName").ToString());
                txtEmail.Attributes.Add("placeholder", GetGlobalResourceObject("English", "YourEmail").ToString());
                txtMessage.Attributes.Add("placeholder", GetGlobalResourceObject("English", "YourMessage").ToString());

                //Set Button Text
                btnSubmit.Text = GetGlobalResourceObject("English", "Submit").ToString();
            }
            else
            {
                contactus.InnerHtml = GetGlobalResourceObject("Arabic", "ContactUs").ToString();
                cmsContactUsDesc.InnerHtml = GetGlobalResourceObject("Arabic", "ContactUsMessage").ToString();

                //Set Place Holders
                txtName.Attributes.Add("placeholder", GetGlobalResourceObject("Arabic", "YourName").ToString());
                txtEmail.Attributes.Add("placeholder", GetGlobalResourceObject("Arabic", "YourEmail").ToString());
                txtMessage.Attributes.Add("placeholder", GetGlobalResourceObject("Arabic", "YourMessage").ToString());

                //Set Button Text
                btnSubmit.Text = GetGlobalResourceObject("Arabic", "Submit").ToString();
            }
        }



        private bool ValidateInput()
        {
            if (txtName.Text.Trim() == "")
            {
                lblResponse.Text = "Name cannot be blank";
                lblResponse.CssClass = "InfoMessage";
               // Helper.ShowNotification("Name cannot be blank", BusinessDTO.UINotificationType.Notify);
                Logger.WriteMessage("Name cannot be blank");
                return false;
            }
            if (txtEmail.Text.Trim() == "")
            {
                lblResponse.Text = "Email cannot be blank";
                lblResponse.CssClass = "InfoMessage";
                //Helper.ShowNotification("Name cannot be blank", BusinessDTO.UINotificationType.Notify);
                Logger.WriteMessage("Email cannot be blank");
                return false;
            }
            return true;
        }

        private void ResetForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidateInput())
                {
                    ContactCustomer custDetails = new ContactCustomer();
                    custDetails.CustName = txtName.Text.Trim();
                    custDetails.CustEmail = txtEmail.Text.Trim();
                    //custDetails.CustProject = txtProject.Text.Trim();
                    custDetails.CustProject = "";
                    custDetails.CustMessage = txtMessage.Text.Trim();
                    //Helper.AutoFill<ContactCustomer>(custDetails, BusinessDTO.DBMethod.Add);
                    custDetails.AddedBy = SessionManager.CurrentUser().UserID.ToString();
                    custDetails.AddedOn = DateTime.Today;

                    if (objContact.AddContactRequest(custDetails) > 0)
                    {
                        lblResponse.Text = "Contact Request sent successfully.";
                        lblResponse.CssClass = "SuccessMessage";
                        //Helper.ShowNotification("Contact Request sent successfully.", BusinessDTO.UINotificationType.Success);
                        //send email//
                        Emailer objEmail = new Emailer();
                        //objEmail.SendEmail(txtEmail.Text.Trim(), txtMessage.Text.Trim(), txtProject.Text.Trim());
                        //objEmail.SendEmail(txtEmail.Text.Trim(), txtMessage.Text.Trim(), "");
                        ResetForm();
                    }
                    else
                    {
                        lblResponse.Text = "Error occurred. Please try again later.";
                        lblResponse.CssClass = "ErrorMessage";
                        //Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                        Logger.WriteMessage("Error while submitting contact request.");
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                lblResponse.Text = "Error occurred. Please try again later.";
                lblResponse.CssClass = "ErrorMessage";
            }
        }
    }
}