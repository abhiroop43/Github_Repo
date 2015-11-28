using BusinessDTO;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.Utlitity
{
    public class Helper
    {
        #region Static Veriables
        private static string DEFAULT_SELECT_TEXT = "Please Select";
        public static string LOGIN_PAGE_URL = "../Login.aspx";
        public static readonly List<string> IMAGE_EXTENTIONS = new List<string> { ".JPG", ".JPE", ".BMP", ".GIF", ".PNG" };
        public static string FILE_UPLOAD_BASE_PATH = "~/Uploads/";
        public static string GALLERY_CATEGORY_IMAGE_PATH = FILE_UPLOAD_BASE_PATH + "GalleryCategory/";
        public static string GALLERY_IMAGE_PATH = FILE_UPLOAD_BASE_PATH + "Gallery/";
        public static string HOME_SLIDER_IMAGE_PATH = FILE_UPLOAD_BASE_PATH + "HomeSlider/";
        public static string NEWS_IMAGE_PATH = FILE_UPLOAD_BASE_PATH + "News/";
        public static string CONTENT_BOX_IMAGE_PATH = FILE_UPLOAD_BASE_PATH + "ContentBox/";
        public static string DATE_FORMAT = "dd MMM yyyy";

        #endregion
        #region Private Methods
        private static string FillTemplate(string TemplateBody, DynamicDTO dynamicDTO)
        {
            try
            {
                foreach (var prop in dynamicDTO.GetProperties(true))
                {
                    object val = prop.Value;
                    if (val != null)
                    {
                        string propName = "[[" + prop.Key + "]]";
                        string propValue = Convert.ToString(val);

                        TemplateBody = TemplateBody.Replace(propName, propValue);
                    }
                }
                return TemplateBody;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return "ERROR";
            }
        }
        private static EmailTemplate GetTemplateByTemplateID(int TemplateID)
        {
            DataAccess.EmailTemplate emailTemplate = new DataAccess.EmailTemplate();

            try
            {
                using (DAL_EmailTemplate dalEmailTemplate = new DAL_EmailTemplate())
                {
                    emailTemplate = dalEmailTemplate.GetTemplateByTemplateID(TemplateID);
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
            return emailTemplate;
        }
        #endregion
        public static BusinessDTO.ApplicationLanguages GetLanguageCode()
        {
            BusinessDTO.ApplicationLanguages languageCode = BusinessDTO.ApplicationLanguages.ar;
            if (HttpContext.Current.Request.Cookies["language"] != null)
            {
                languageCode = HttpContext.Current.Request.Cookies["language"].Value == "en" ? BusinessDTO.ApplicationLanguages.ar : BusinessDTO.ApplicationLanguages.en;
            }
            return languageCode;
        }

        public static T AutoFill<T>(object obj, DBMethod dbMethod)
        {
            try
            {
                List<string> lstProperties = new List<string>();
                lstProperties.Add("CreateDate");
                lstProperties.Add("CreateBy");
                lstProperties.Add("UpdateDate");
                lstProperties.Add("UpdateBy");
                lstProperties.Add("DeletedOn");
                lstProperties.Add("DeletedBy");

                foreach (string item in lstProperties)
                {
                    //Get Properity
                    PropertyInfo propertyInfo = obj.GetType().GetProperty(item);

                    if (propertyInfo != null)
                    {

                        if (item == lstProperties[0] && dbMethod == DBMethod.Add)
                        {
                            DateTime createdDate = DateTime.Now;
                            propertyInfo.SetValue(obj, Convert.ChangeType(createdDate, typeof(DateTime)), null);
                        }
                        else if (item == lstProperties[1] && dbMethod == DBMethod.Add)
                        {
                            long createdBy = SessionManager.CurrentUser().UserID;
                            propertyInfo.SetValue(obj, Convert.ChangeType(createdBy, typeof(long)), null);
                        }
                        else if (item == lstProperties[2] && dbMethod == DBMethod.Update)
                        {
                            //object modifiedDate = ChangeType<DateTime?>(DateTime.Now);
                            DateTime modifiedDate = DateTime.Now;
                            propertyInfo.SetValue(obj, Convert.ChangeType(modifiedDate, typeof(DateTime)), null);
                        }
                        else if (item == lstProperties[3] && dbMethod == DBMethod.Update)
                        {
                            long modifiedBy = SessionManager.CurrentUser().UserID;
                            propertyInfo.SetValue(obj, Convert.ChangeType(modifiedBy, typeof(long)), null);
                        }
                        else if (item == lstProperties[4] && dbMethod == DBMethod.Delete)
                        {
                            DateTime deletedDate = DateTime.Now;
                            propertyInfo.SetValue(obj, Convert.ChangeType(deletedDate, typeof(DateTime)), null);
                        }
                        else if (item == lstProperties[5] && dbMethod == DBMethod.Delete)
                        {
                            long deletedBy = SessionManager.CurrentUser().UserID;
                            propertyInfo.SetValue(obj, Convert.ChangeType(deletedBy, typeof(long)), null);
                        }
                        //Get Value
                        //object itemValue = propertyInfo.GetValue(obj, null);
                    }
                    else
                    {
                        //throw new Exception("Property '" + item + "' not found.");
                    }
                }

                return (T)obj;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return (T)obj;
            }

        }

        private static T ChangeType<T>(object value)
        {
            var t = typeof(T);

            if (t.IsGenericType && t.GetGenericTypeDefinition().Equals(typeof(Nullable<>)))
            {
                if (value == null)
                {
                    return default(T);
                }

                t = Nullable.GetUnderlyingType(t);
            }

            return (T)Convert.ChangeType(value, t);
        }

        public static void ClearInputs(ControlCollection ctrls)
        {

            try
            {
                foreach (Control ctrl in ctrls)
                {
                    if (ctrl is TextBox)
                        ((TextBox)ctrl).Text = string.Empty;
                    else if (ctrl is System.Web.UI.HtmlControls.HtmlTextArea)
                    {
                        ((System.Web.UI.HtmlControls.HtmlTextArea)ctrl).InnerText = string.Empty;
                        ((System.Web.UI.HtmlControls.HtmlTextArea)ctrl).InnerHtml = string.Empty;
                    }
                    else if (ctrl is CKEditor.NET.CKEditorControl)
                        ((CKEditor.NET.CKEditorControl)ctrl).Text = string.Empty;
                    else if (ctrl is DropDownList)
                        ((DropDownList)ctrl).ClearSelection();

                    ClearInputs(ctrl.Controls);
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        public static void InsertSelectFirstItem(DropDownList ddl)
        {
            try
            {
                ddl.Items.Insert(0, new ListItem(DEFAULT_SELECT_TEXT, "0"));
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        static string CleanWordHtml(string html)
        {
            html = Regex.Replace(html, "<!--.*?-->", "", RegexOptions.Singleline);
            return html;
        }
        static string FixEntities(string html)
        {
            NameValueCollection nvc = new NameValueCollection();
            nvc.Add("\"", "&ldquo;");
            nvc.Add("\"", "&rdquo;");
            nvc.Add("Ã¢â‚¬â€œ", "&mdash;");
            foreach (string key in nvc.Keys)
            {
                html = html.Replace(key, nvc[key]);
            }
            return html;
        }
        public static string TrimText(string value)
        {
            try
            {
                value = HttpUtility.HtmlDecode(value);
                value = CleanWordHtml(value);
                value = FixEntities(value);

                string output = Regex.Replace(value, "<[^>]*>", string.Empty);
                //get rid of multiple blank lines
                output = Regex.Replace(output, @"^\s*$\n", string.Empty, RegexOptions.Multiline);
                output = output.Replace("<b>", "");
                int maxChars = 200;
                return output.Length <= maxChars ? output : output.Substring(0, maxChars) + " ...";
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return "ERROR";
            }
        }

        public static bool SendEmailNotification(NotificationType notificationType, DynamicDTO dynamicDTO)
        {
            try
            {
                int EmailTemplateID = (int)notificationType;
                DataAccess.EmailTemplate emailTemplate = GetTemplateByTemplateID(EmailTemplateID);

                dynamic dtoGeneric = new DynamicDTO();
                dtoGeneric = dynamicDTO;
                if (emailTemplate != null)
                {

                    if (notificationType == NotificationType.UserAppliedForJobNotificationForAdmin)
                    {
                        using (DAL_User dalUser = new DAL_User())
                        {
                            List<User> adminList = dalUser.GetAllActiveAdmins();
                            string EmailBody = emailTemplate.TemplateBody;

                            if (adminList != null)
                            {
                                foreach (User admin in adminList)
                                {

                                    dtoGeneric.AdminName = admin.DisplayName;
                                    EmailBody = FillTemplate(EmailBody, dtoGeneric);
                                    Emailer.SendEmailMessage(admin.Email, EmailBody, emailTemplate.EmailSubject);
                                }
                            }
                            else
                                throw new Exception("Admin List Empty");
                        }
                    }
                    else if (notificationType == NotificationType.UserAppliedForJobNotificationForUser)
                    {
                        string EmailBody = emailTemplate.TemplateBody;
                        string UserEmail = dtoGeneric.UserEmailAddress;
                        EmailBody = FillTemplate(EmailBody, dtoGeneric);
                        Emailer.SendEmailMessage(UserEmail, EmailBody, emailTemplate.EmailSubject);
                    }
                }
                else
                {
                    //Template Not Found
                    throw new Exception("Email Template Not Found");

                }

                return true;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public static bool IsValidUploadImageType(string filePath)
        {

            try
            {
                Regex regex = new Regex(@"(.*?)\.(jpg|jpeg|png|gif)$");
                Match match = regex.Match(filePath.ToLowerInvariant());
                if (match.Success)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public static bool DeleteFile(FileUploadType uploadType, string FileName)
        {
            try
            {
                string CompleteFilePath = "";
                if (uploadType == FileUploadType.GalleryCategoryImage)
                {
                    CompleteFilePath = GALLERY_CATEGORY_IMAGE_PATH + FileName;

                }
                else if (uploadType == FileUploadType.GalleryImage)
                {
                    CompleteFilePath = GALLERY_IMAGE_PATH + FileName;

                }
                else if (uploadType == FileUploadType.HomeSliderImage)
                {
                    CompleteFilePath = HOME_SLIDER_IMAGE_PATH + FileName;
                }
                else if (uploadType == FileUploadType.NewsImage)
                {
                    CompleteFilePath = NEWS_IMAGE_PATH + FileName;
                }
                else if (uploadType == FileUploadType.ContentBoxImage)
                {
                    CompleteFilePath = CONTENT_BOX_IMAGE_PATH + FileName;
                }

                CompleteFilePath = HttpContext.Current.Server.MapPath(@CompleteFilePath);
                if (System.IO.File.Exists(CompleteFilePath))
                {
                    System.IO.File.Delete(CompleteFilePath);
                    return true;
                }
                else
                    return false;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
        public static string UploadFile(FileUploadType uploadType, FileUpload fileUploader)
        {
            string strFileName = System.DateTime.Now.Ticks.ToString() + System.IO.Path.GetExtension(fileUploader.FileName);

            try
            {
                if (uploadType == FileUploadType.GalleryCategoryImage)
                {
                    fileUploader.SaveAs(HttpContext.Current.Server.MapPath(GALLERY_CATEGORY_IMAGE_PATH + strFileName));

                }
                else if (uploadType == FileUploadType.GalleryImage)
                {
                    fileUploader.SaveAs(HttpContext.Current.Server.MapPath(GALLERY_IMAGE_PATH + strFileName));

                }
                else if (uploadType == FileUploadType.HomeSliderImage)
                {
                    fileUploader.SaveAs(HttpContext.Current.Server.MapPath(HOME_SLIDER_IMAGE_PATH + strFileName));

                }
                else if (uploadType == FileUploadType.NewsImage)
                {
                    fileUploader.SaveAs(HttpContext.Current.Server.MapPath(NEWS_IMAGE_PATH + strFileName));

                }
                else if (uploadType == FileUploadType.ContentBoxImage)
                {
                    fileUploader.SaveAs(HttpContext.Current.Server.MapPath(CONTENT_BOX_IMAGE_PATH + strFileName));

                }

                return strFileName;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return "";
            }
        }

        public static void ShowNotification(string message, UINotificationType notificationType)
        {
            try
            {

                string NotificationMessageHTML = "";
                if (message != "")
                {


                    if (notificationType == UINotificationType.Success)
                    {
                        NotificationMessageHTML = @"<div class='alert alert-success alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Success: </strong>" + message + "</div>";
                    }
                    else if (notificationType == UINotificationType.Error)
                    {

                        NotificationMessageHTML = @"<div class='alert alert-error alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Error: </strong> " + message + "</div>";
                    }
                    else if (notificationType == UINotificationType.Notify)
                    {
                        NotificationMessageHTML = @"<div class='alert alert-info alert-dismissible fade in'>
                                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>×</span></button>
                                            <strong>Info: </strong>" + message + "</div>";
                    }
                    else if (notificationType == UINotificationType.Script)
                    {
                        NotificationMessageHTML = message;
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
                        ltNotification.Text = NotificationMessageHTML;
                    }
                }

            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        public static string Truncate(string value)
        {
            Regex regex = new Regex("(<.*?>\\s*)+", RegexOptions.Singleline);
            string resultText = regex.Replace(value, " ").Trim();

            int maxLength = 60;
            if (string.IsNullOrEmpty(resultText)) return resultText;
            return resultText.Length <= maxLength ? resultText : resultText.Substring(0, maxLength) + "...";
        }
        public static string ConvertHTMLToText(string value)
        {
            Regex regex = new Regex("(<.*?>\\s*)+", RegexOptions.Singleline);
            string resultText = regex.Replace(value, " ").Trim();

            return resultText;
        }

        public static void CreateImageThumbnail(string ImageName, FileUploadType uploadType)
        {

            try
            {
                string CompleteFilePath = "";
                if (uploadType == FileUploadType.GalleryCategoryImage)
                {
                    CompleteFilePath = GALLERY_CATEGORY_IMAGE_PATH + ImageName;

                }
                else if (uploadType == FileUploadType.GalleryImage)
                {
                    CompleteFilePath = GALLERY_IMAGE_PATH + ImageName;

                }
                else if (uploadType == FileUploadType.HomeSliderImage)
                {
                    CompleteFilePath = HOME_SLIDER_IMAGE_PATH + ImageName;
                }
                else if (uploadType == FileUploadType.NewsImage)
                {
                    CompleteFilePath = NEWS_IMAGE_PATH + ImageName;
                }
                else if (uploadType == FileUploadType.ContentBoxImage)
                {
                    CompleteFilePath = CONTENT_BOX_IMAGE_PATH + ImageName;
                }

                CompleteFilePath = HttpContext.Current.Server.MapPath(@CompleteFilePath);

                string input = CompleteFilePath;

                string OutputFileName = "thumb-" + System.IO.Path.GetFileNameWithoutExtension(CompleteFilePath) + System.IO.Path.GetExtension(CompleteFilePath);
                string output = System.IO.Path.GetDirectoryName(@CompleteFilePath) + @"\" + OutputFileName;

                // Load image.
                System.Drawing.Image image = System.Drawing.Image.FromFile(input);

                // Compute thumbnail size.
                Size thumbnailSize = GetThumbnailSize(image);

                // Get thumbnail.
                System.Drawing.Image thumbnail = image.GetThumbnailImage(thumbnailSize.Width, thumbnailSize.Height, null, IntPtr.Zero);

                // Save thumbnail.
                thumbnail.Save(output);
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        private static Size GetThumbnailSize(System.Drawing.Image original)
        {
            // Maximum size of any dimension.
            const int maxPixels = 300;

            // Width and height.
            int originalWidth = original.Width;
            int originalHeight = original.Height;

            // Compute best factor to scale entire image based on larger dimension.
            double factor;
            if (originalWidth > originalHeight)
            {
                factor = (double)maxPixels / originalWidth;
            }
            else
            {
                factor = (double)maxPixels / originalHeight;
            }

            // Return thumbnail size.
            return new Size((int)(originalWidth * factor), (int)(originalHeight * factor));
        }

        public static List<BugLog> GetBugLog()
        {
            try
            {
                string path = "~/ErrorLog/";
                List<BugLog> bugLog = new List<BugLog>();
                //int MainFileIndex = 0;
                string[] txtFiles = Directory.EnumerateFiles(System.Web.HttpContext.Current.Server.MapPath(path), "*.txt").ToArray();
                foreach (string currentFile in txtFiles)
                {
                    //Console.Write("Main File Index : " + MainFileIndex + Environment.NewLine + "File Name : " + txtFiles[MainFileIndex]);
                    string str = File.ReadAllText(currentFile);
                    str = str.Replace("__________________________", "^");
                    string[] result = str.Split('^');
                    //int innerFileIndex = 0;
                    foreach (string logEntry in result)
                    {
                        //Console.Write("Inner File Index : " + innerFileIndex);
                        if (logEntry.Trim() != "")
                        {
                            string strLogEntry = logEntry.Replace("Log Entry : ", "~ : ").Replace("Execption URL : ", "~ : ").Replace("Error Message  :  ", "~ : ").Replace("Trace Stack : ", "~ : ");
                            string[] EntryExtract = strLogEntry.Split(new string[] { "~ : " }, StringSplitOptions.None);

                            string LogDate = "";
                            string ExceptionURL = "";
                            string ErrorMessage = "";
                            string TraceStack = "";

                            if (EntryExtract.Length > 2)
                                LogDate = EntryExtract[1];
                            if (EntryExtract.Length > 3)
                                ExceptionURL = EntryExtract[2];
                            if (EntryExtract.Length > 4)
                                ErrorMessage = EntryExtract[3];
                            if (EntryExtract.Length >= 5)
                                TraceStack = EntryExtract[4];

                            BugLog log = new BugLog();
                            log.LogDate = LogDate;
                            log.ExceptionURL = ExceptionURL;
                            log.ErrorMessage = ErrorMessage;
                            log.TraceStack = TraceStack;
                            bugLog.Add(log);
                        }
                        //innerFileIndex++;
                    }

                    //MainFileIndex++;
                }

                return bugLog;
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        public static string ExtractDomainNameFromURL(string Url)
        {
            //if (!Url.Contains("://"))
            //    Url = "http://" + Url;
            //string result = new Uri(Url).Host;

            string[] hostParts = new System.Uri(Url).Host.Split('.');
            string domain = String.Join(".", hostParts.Skip(Math.Max(0, hostParts.Length - 2)).Take(2));

            return domain;
        }

        public static bool IsMobileDevice()
        {
            try
            {
                if (HttpContext.Current.Request.Headers["User-Agent"] != null && HttpContext.Current.Request.Browser["IsMobileDevice"] != null && HttpContext.Current.Request.Browser["IsMobileDevice"] == "true")
                {
                    #region Mobile Further Detection
                    //if (HttpContext.Current.Request.UserAgent.ToString().ToLower().Contains("android"))
                    //{

                    //}
                    //else if (HttpContext.Current.Request.UserAgent.ToString().ToLower().Contains("iphone") || HttpContext.Current.Request.UserAgent.ToString().ToLower().Contains("ipad"))
                    //{

                    //}
                    //else if (HttpContext.Current.Request.UserAgent.ToString().ToLower().Contains("nokia"))
                    //{

                    //}
                    //else
                    //{

                    //} 
                    #endregion
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
    }
}