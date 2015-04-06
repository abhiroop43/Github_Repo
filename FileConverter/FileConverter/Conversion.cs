using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Reflection;
using System.Xml;
using System.IO;
using System.Collections;
using HtmlAgilityPack;

namespace FileConverter
{
    class Conversion
    {
        static void Main(string[] args)
        {
            try
            {
                Conversion conv = new Conversion();
                Console.WriteLine("Starting conversion process......................");

                Console.WriteLine("1. Converting XML to Text......................");
                if (conv.XMLToText(ConfigurationManager.AppSettings["XMLInputPath"].ToString(), ConfigurationManager.AppSettings["OutputPath"].ToString()))
                {
                    Console.WriteLine("Conversion successful. Please check " + ConfigurationManager.AppSettings["OutputPath"].ToString() + " for the output file......................");
                }

                Console.WriteLine("2. Converting Text to XML......................");
                if (conv.TextToXML(ConfigurationManager.AppSettings["TextInputPath"].ToString(), ConfigurationManager.AppSettings["OutputPath"].ToString()))
                {
                    Console.WriteLine("Conversion successful. Please check " + ConfigurationManager.AppSettings["OutputPath"].ToString() + " for the output file......................");
                }

                Console.WriteLine("3. Converting HTML to Text......................");
                if (conv.HTMLToText(ConfigurationManager.AppSettings["HTMLInputPath"].ToString(), ConfigurationManager.AppSettings["OutputPath"].ToString()))
                {
                    Console.WriteLine("Conversion successful. Please check " + ConfigurationManager.AppSettings["OutputPath"].ToString() + " for the output file......................");
                }

                Console.WriteLine("4. Converting Text to HTML......................");
                if (conv.TextToHTML(ConfigurationManager.AppSettings["TextInputPath"].ToString(), ConfigurationManager.AppSettings["OutputPath"].ToString()))
                {
                    Console.WriteLine("Conversion successful. Please check " + ConfigurationManager.AppSettings["OutputPath"].ToString() + " for the output file......................");
                }
            }
            catch (Exception ex)
            {
                Logger.LogException(ConfigurationManager.AppSettings["ErrLogPath"].ToString(), ex, "true", System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            }            
        }

        private bool XMLToText(string xmlInput, string txtOutput)
        {
            bool blRetVal=false;
            try
            {
                //get all files in the directory//
                string[] filePaths = Directory.GetFiles(xmlInput);
                foreach (string file in filePaths)
                {
                    string fileName = file.Substring(file.LastIndexOf(@"\") + 1);
                    string fileLabel = fileName.Substring(0, fileName.LastIndexOf("."));
                    XmlDocument doc = new XmlDocument();
                    //doc.Load(xmlInput + ConfigurationManager.AppSettings["XMLInputFileName"].ToString());
                    doc.Load(file);

                    StringBuilder sb = new StringBuilder();
                    foreach (XmlNode node in doc.DocumentElement.ChildNodes)
                    {
                        if (node.HasChildNodes)
                        {
                            foreach (XmlNode childnode in node.ChildNodes)
                            {
                                sb.Append(char.ToUpper(childnode.Name[0]));
                                sb.Append(childnode.Name.Substring(1));
                                sb.Append(' ');
                                sb.AppendLine(childnode.InnerText);
                            }
                        }
                        else
                        {
                            sb.Append(char.ToUpper(node.Name[0]));
                            sb.Append(node.Name.Substring(1));
                            sb.Append(' ');
                            sb.AppendLine(node.InnerText);
                        }
                    }

                    //Console.WriteLine(sb);
                    //File.WriteAllText(txtOutput + ConfigurationManager.AppSettings["TextOutputFileName"].ToString(), sb.ToString());
                    File.WriteAllText(txtOutput + fileLabel + ".txt", sb.ToString());
                }
                blRetVal=true;

            }
            catch (Exception ex)
            {
                blRetVal=false;
                Logger.LogException(ConfigurationManager.AppSettings["ErrLogPath"].ToString(), ex, "true", System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            }
            return blRetVal;
        }

        private bool TextToXML(string txtInput, string xmlOutput)
        {
            bool blRetVal=false;
            try
            {
                string[] filePaths = Directory.GetFiles(txtInput);
                foreach (string file in filePaths)
                {
                    string fileName = file.Substring(file.LastIndexOf(@"\") + 1);
                    string fileLabel = fileName.Substring(0, fileName.LastIndexOf("."));
                    string strInput = File.ReadAllText(file);
                    string[] lines = strInput.Split('\n');
                    ArrayList arNodes = new ArrayList();
                    StringBuilder sbXMLOutput = new StringBuilder();
                    sbXMLOutput.AppendLine("<?xml version='1.0' encoding='utf-8' ?>");  //header
                    sbXMLOutput.AppendLine("<" + fileLabel + ">");  //root element start
                    foreach (string line in lines)
                    {
                        if (line.Trim() != string.Empty)
                        {
                            sbXMLOutput.AppendLine("<element>");
                            string nodeName = line.Split(' ')[0];
                            string nodeValue = line.Remove(line.IndexOf(nodeName), nodeName.Length + 1);
                            sbXMLOutput.Append("<" + nodeName + ">");
                            sbXMLOutput.Append(nodeValue.Remove(nodeValue.Length - 1));
                            sbXMLOutput.Append("</" + nodeName + ">");
                            sbXMLOutput.AppendLine();
                            sbXMLOutput.AppendLine("</element>");
                        }
                    }
                    sbXMLOutput.AppendLine("</" + fileLabel + ">"); //root element end
                    //Console.WriteLine(sbXMLOutput);
                    File.WriteAllText(xmlOutput + fileLabel + ".xml", sbXMLOutput.ToString());
                }
                blRetVal=true;
            }
            catch (Exception ex)
            {
                blRetVal=false;
                Logger.LogException(ConfigurationManager.AppSettings["ErrLogPath"].ToString(), ex, "true", System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            }
            return blRetVal;
        }

        private bool HTMLToText(string htmlInput, string txtOutput)
        {
            bool blRetVal=false;
            try
            {
                string[] filePaths = Directory.GetFiles(htmlInput);
                string strOutput;
                foreach (string file in filePaths)
                {
                    string fileName = file.Substring(file.LastIndexOf(@"\") + 1);
                    string fileLabel = fileName.Substring(0, fileName.LastIndexOf("."));
                    HtmlDocument doc = new HtmlDocument();
                    doc.Load(file);
                    HtmlNode titleNode = doc.DocumentNode.SelectSingleNode("/html/head/title");
                    HtmlNode bodyNode = doc.DocumentNode.SelectSingleNode("/html/body");
                    if (bodyNode != null)
                    {
                        if (titleNode != null)
                        {
                            strOutput = titleNode.InnerText.Trim() + "\r\n" + bodyNode.InnerText.Trim();
                        }
                        else
                        {
                            strOutput = bodyNode.InnerText.Trim();
                        }
                        File.WriteAllText(txtOutput + fileLabel + ".txt", strOutput);
                        blRetVal = true;
                    }
                    else
                    {
                        blRetVal = false;
                        throw new Exception("HTML file has empty body, failed to convert to text.");
                    }
                }
            }
            catch (Exception ex)
            {
                blRetVal=false;
            }
            return blRetVal;
        }

        private bool TextToHTML(string txtInput, string htmlOutput)
        {
            bool blRetVal=false;
            try
            {
                string[] filePaths = Directory.GetFiles(txtInput);
                foreach (string file in filePaths)
                {
                    string fileName = file.Substring(file.LastIndexOf(@"\") + 1);
                    string fileLabel = fileName.Substring(0, fileName.LastIndexOf("."));
                    string strInput = File.ReadAllText(file);
                    StringBuilder sbOutput = new StringBuilder();
                    sbOutput.AppendLine("<!DOCTYPE html>");
                    sbOutput.AppendLine("<html>");
                    sbOutput.AppendLine("<head><title>Output HTML for " + fileLabel + ".txt</title></head>");
                    sbOutput.AppendLine("<body>");
                    sbOutput.AppendLine(strInput);
                    sbOutput.AppendLine("</body>");
                    sbOutput.AppendLine("</html>");

                    File.WriteAllText(htmlOutput + fileLabel + ".html", sbOutput.ToString());
                }
                blRetVal=true;
            }
            catch (Exception ex)
            {
                blRetVal=false;
                Logger.LogException(ConfigurationManager.AppSettings["ErrLogPath"].ToString(), ex, "true", System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            }
            return blRetVal;
        }
    }
}
