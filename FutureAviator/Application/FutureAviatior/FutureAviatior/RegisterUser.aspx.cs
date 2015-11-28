using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Globalization;
using System.Configuration;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;

namespace FutureAviator
{
    public partial class RegisterUser : System.Web.UI.Page
    {
        private static int SaltValueSize = Convert.ToInt32(ConfigurationManager.AppSettings["SaltValueSize"]);
        private static string DefaultSalt = ConfigurationManager.AppSettings["DefaultSalt"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if(ValidateInput())
                {
                    using(DAL_User objUser = new DAL_User())
                    {
                        IQueryable<DataAccess.User> existingUser = objUser.Database.Users.Where(usr => usr.Email == txtEmail.Text.Trim());
                        if(existingUser != null && existingUser.Count() > 0)
                        {
                            //lblErrDesc.Text = "This Email ID is already registered. Please use a different Email ID.";
                            Helper.ShowNotification("This Email ID is already registered. Please use a different Email ID.", BusinessDTO.UINotificationType.Notify);
                            return;
                        }
                        DataAccess.User newUser = new DataAccess.User();
                        newUser.IsActive = true;
                        newUser.DisplayName = txtDisplayName.Text.Trim();
                        newUser.Email = txtEmail.Text.Trim();
                        HashAlgorithm sha = new SHA1CryptoServiceProvider();
                        newUser.Password = HashPassword(txtPassword.Text.Trim(), DefaultSalt, sha);
                        newUser.UserTypeID = 2;
                        newUser.CreateDate = DateTime.Now;
                        //DAL_User objUser = new DAL_User();
                        objUser.AddNewUser(newUser);
                        objUser.Database.SaveChanges();
                        string strMessage = "A new user has registered. Display Name: " + txtDisplayName.Text.Trim() + " Email ID: " + txtEmail.Text.Trim();
                        Emailer.SendEmailMessage(ConfigurationManager.AppSettings["ToEmailAddress"].ToString(), strMessage, "New user registration");
                        Response.Redirect("~/Login.aspx");
                    }
                }
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "Error occurred. Please try again later.";
                Helper.ShowNotification("Error occurred. Please try again later.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        private bool ValidateInput()
        {
            if(txtDisplayName.Text.Trim() == "")
            {
                //lblErrDesc.Text = "Display name cannot be blank";
                Helper.ShowNotification("TDisplay name cannot be blank.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtEmail.Text.Trim() == "")
            {
                lblErrDesc.Text = "Email address cannot be blank";
                Helper.ShowNotification("Email address cannot be blank.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtPassword.Text.Trim() == "")
            {
                lblErrDesc.Text = "Password cannot be blank";
                Helper.ShowNotification("Password cannot be blank.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            if (txtPassword.Text.Trim() != txtConfirmPass.Text.Trim())
            {
                lblErrDesc.Text = "Password and Confirm Password must match";
                Helper.ShowNotification("Password and Confirm Password must match.", BusinessDTO.UINotificationType.Notify);
                return false;
            }
            return true;
        }

        private static string HashPassword(string clearData, string saltValue, HashAlgorithm hash)
        {
            UnicodeEncoding encoding = new UnicodeEncoding();

            if (clearData != null && hash != null && encoding != null)
            {
                // If the salt string is null or the length is invalid then
                // create a new valid salt value.

                if (saltValue == null)
                {
                    // Generate a salt string.
                    saltValue = GenerateSaltValue();
                }

                // Convert the salt string and the password string to a single
                // array of bytes. Note that the password string is Unicode and
                // therefore may or may not have a zero in every other byte.

                byte[] binarySaltValue = new byte[SaltValueSize];

                binarySaltValue[0] = byte.Parse(saltValue.Substring(0, 2), System.Globalization.NumberStyles.HexNumber, CultureInfo.InvariantCulture.NumberFormat);
                binarySaltValue[1] = byte.Parse(saltValue.Substring(2, 2), System.Globalization.NumberStyles.HexNumber, CultureInfo.InvariantCulture.NumberFormat);
                binarySaltValue[2] = byte.Parse(saltValue.Substring(4, 2), System.Globalization.NumberStyles.HexNumber, CultureInfo.InvariantCulture.NumberFormat);
                binarySaltValue[3] = byte.Parse(saltValue.Substring(6, 2), System.Globalization.NumberStyles.HexNumber, CultureInfo.InvariantCulture.NumberFormat);

                byte[] valueToHash = new byte[SaltValueSize + encoding.GetByteCount(clearData)];
                byte[] binaryPassword = encoding.GetBytes(clearData);

                // Copy the salt value and the password to the hash buffer.

                binarySaltValue.CopyTo(valueToHash, 0);
                binaryPassword.CopyTo(valueToHash, SaltValueSize);

                byte[] hashValue = hash.ComputeHash(valueToHash);

                // The hashed password is the salt plus the hash value (as a string).

                string hashedPassword = saltValue;

                foreach (byte hexdigit in hashValue)
                {
                    hashedPassword += hexdigit.ToString("X2", CultureInfo.InvariantCulture.NumberFormat);
                }

                // Return the hashed password as a string.

                return hashedPassword;
            }

            return null;
        }

        private static string GenerateSaltValue()
        {
            UnicodeEncoding utf16 = new UnicodeEncoding();

            if (utf16 != null)
            {
                // Create a random number object seeded from the value
                // of the last random seed value. This is done
                // interlocked because it is a static value and we want
                // it to roll forward safely.

                Random random = new Random(unchecked((int)DateTime.Now.Ticks));

                if (random != null)
                {
                    // Create an array of random values.

                    byte[] saltValue = new byte[SaltValueSize];

                    random.NextBytes(saltValue);

                    // Convert the salt value to a string. Note that the resulting string
                    // will still be an array of binary values and not a printable string. 
                    // Also it does not convert each byte to a double byte.

                    string saltValueString = utf16.GetString(saltValue);

                    // Return the salt value as a string.

                    return saltValueString;
                }
            }

            return null;
        }
    }
}