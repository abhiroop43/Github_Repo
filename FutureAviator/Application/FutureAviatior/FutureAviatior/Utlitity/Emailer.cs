using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Configuration;
using ExceptionLogger;
using System.Text;

namespace FutureAviator.Utlitity
{
    public class Emailer
    {
        public static bool SendEmailMessage(string EmailTo, string Message, string Subject)
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.To.Add(EmailTo);
                mailMessage.From = new MailAddress(ConfigurationManager.AppSettings["FromEmailAddress"].ToString());
                mailMessage.Subject = Subject;
                mailMessage.IsBodyHtml = true;
                mailMessage.Body = Message;
                SmtpClient smtpClient = new SmtpClient(ConfigurationManager.AppSettings["SMTPServer"].ToString());
                smtpClient.Send(mailMessage);
                Logger.WriteMessage("Email Sent from " + mailMessage.From);
                return true;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return false;
            }
        }
        public void SendEmail(string FromAddress, string Name, string Email, string Message, string Project = "")
        {
            try
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.To.Add(ConfigurationManager.AppSettings["ToEmailAddress"].ToString());
                mailMessage.From = new MailAddress(FromAddress);
                if (Project == "")
                {
                    mailMessage.Subject = ConfigurationManager.AppSettings["EmailSubWithProj"] + Project;
                }
                else
                {
                    mailMessage.Subject = ConfigurationManager.AppSettings["EmailSubWithoutProj"];
                }
                mailMessage.IsBodyHtml = true;
                mailMessage.Body = PrepareMessageBody(Name, Email, Message);
                SmtpClient smtpClient = new SmtpClient(ConfigurationManager.AppSettings["SMTPServer"].ToString());
                smtpClient.Send(mailMessage);
                Logger.WriteMessage("Email Sent from " + FromAddress);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }

        private string PrepareMessageBody(string Name, string Email, string Message)
        {
            StringBuilder sbEmailBody = new StringBuilder();
            try
            {
                sbEmailBody.Append("Dear Admin,<br/>");
                sbEmailBody.Append("Below is the contact information submitted from the website at futureaviators.ae:<br/><br/>");
                sbEmailBody.Append("Name: " + Name + "<br/>");
                sbEmailBody.Append("Email: " + Email + "<br/>");
                sbEmailBody.Append("Message: " + Message + "<br/><br/>");
                sbEmailBody.Append("Best Regards,<br/>Team Future Aviators.");
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return null;
            }
            return sbEmailBody.ToString();
        }
    }
}