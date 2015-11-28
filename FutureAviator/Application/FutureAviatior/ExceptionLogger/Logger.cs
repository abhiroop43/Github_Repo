using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;

namespace ExceptionLogger
{
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

    }
}
