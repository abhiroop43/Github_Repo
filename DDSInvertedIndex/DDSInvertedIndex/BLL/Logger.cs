using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace DDSInvertedIndex
{
    public static class Logger
    {
        public static void LogException(Exception ex, string userID)
        {
            string FilePath = ConfigurationManager.AppSettings["ErrorLogs"].ToString() + DateTime.Today.ToString("MMM-yyyy") + @"\";
            string isDebug = ConfigurationManager.AppSettings["isDebug"].ToString();
            string file = FilePath + DateTime.Today.ToString("dd-MMM-yyyy") + ".txt";
            FileStream fs;
            if (!Directory.Exists(FilePath))
            {
                Directory.CreateDirectory(FilePath);
            }
            if (!File.Exists(file))
            {
                fs = new FileStream(file, FileMode.Create, FileAccess.Write);
            }
            else
            {
                fs = new FileStream(file, FileMode.Append, FileAccess.Write);
            }
            using (StreamWriter writer = new StreamWriter(fs, Encoding.Unicode))
            {
                if (isDebug.ToLower() == "true")
                {
                    writer.WriteLine(DateTime.Now.ToString() + " - " + userID + ": " + ex.ToString());
                }
                else
                {
                    writer.WriteLine(DateTime.Now.ToString() + " - " + userID + ": " + ex.Message.ToString());
                }
                writer.WriteLine(Environment.NewLine);
            }
            fs.Close();
            fs.Dispose();
        }
    }
}
