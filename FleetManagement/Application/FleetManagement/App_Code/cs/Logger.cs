using System;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for Logger
/// </summary>
public class Logger
{
    public static void WriteErrorLog(Exception exception)
    {
        try
        {

            string FileName = DateTime.Today.ToString("dd-MM-yy");
            string path = "~/ErrorLog/" + FileName + ".txt";

            if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(path)))
            {
                File.Create(System.Web.HttpContext.Current.Server.MapPath(path)).Close();
            }
            using (StreamWriter SW = File.AppendText(System.Web.HttpContext.Current.Server.MapPath(path)))
            {
                SW.WriteLine("\r\nLog Entry : {0}", DateTime.Now.ToString(CultureInfo.CurrentUICulture));
                string err = "Execption URL : " + System.Web.HttpContext.Current.Request.Url.ToString() + Environment.NewLine + "Error Message  :  " + exception.Message.ToString() + Environment.NewLine + "Trace Stack : " + exception.ToString();

                //ex.Message, ex.StackTrace
                SW.WriteLine(err);
                SW.WriteLine("__________________________");
                SW.Flush();
                SW.Close();
            }
        }
        catch (Exception ex)
        {
            //WriteError("WriteError : " + ex.Message, true);
        }
    }

    public static void WriteMessage(string Message)
    {
        try
        {

            string FileName = DateTime.Today.ToString("dd-MM-yy");
            string path = "~/ErrorLog/" + FileName + ".txt";

            if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(path)))
            {
                File.Create(System.Web.HttpContext.Current.Server.MapPath(path)).Close();
            }
            using (StreamWriter SW = File.AppendText(System.Web.HttpContext.Current.Server.MapPath(path)))
            {
                SW.WriteLine("\r\nLog Entry : {0}", DateTime.Now.ToString(CultureInfo.CurrentUICulture));
                string err = "Exception URL : " + System.Web.HttpContext.Current.Request.Url.ToString() + Environment.NewLine + "Log Message  :  " + Message.ToString();

                //ex.Message, ex.StackTrace
                SW.WriteLine(err);
                SW.WriteLine("__________________________");
                SW.Flush();
                SW.Close();
            }
        }
        catch (Exception)
        {

        }
    }

    public enum UiNotificationType
    {
        Success = 1,
        Error = 2,
        Notify = 3,
        Script = 4
    }

    public static void ShowNotification(string message, UiNotificationType notificationType)
    {
        try
        {

            string notificationMessageHtml = "";
            if (message != "")
            {


                if (notificationType == UiNotificationType.Success)
                {
                    notificationMessageHtml = @"<div class='alert alert-success alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Success: </strong>" + message + "</div>";
                }
                else if (notificationType == UiNotificationType.Error)
                {

                    notificationMessageHtml = @"<div class='alert alert-error alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Error: </strong> " + message + "</div>";
                }
                else if (notificationType == UiNotificationType.Notify)
                {
                    notificationMessageHtml = @"<div class='alert alert-info alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Info: </strong>" + message + "</div>";
                }
                else if (notificationType == UiNotificationType.Script)
                {
                    notificationMessageHtml = message;
                }
            }

            var pageHandler = HttpContext.Current.CurrentHandler;
            if (pageHandler is System.Web.UI.Page)
            {
                Literal ltNotification = new Literal();
                if (((System.Web.UI.Page)pageHandler).Master != null)
                {
                    ltNotification = (Literal)((System.Web.UI.Page)pageHandler).Master.FindControl("ltNotification");
                }
                else
                {
                    ltNotification = (Literal)((System.Web.UI.Page)pageHandler).FindControl("ltNotification");
                }
                if (ltNotification != null)
                {
                    ltNotification.Text = notificationMessageHtml;
                }
            }

        }
        catch (Exception ex)
        {

            WriteErrorLog(ex);
        }
    }
}