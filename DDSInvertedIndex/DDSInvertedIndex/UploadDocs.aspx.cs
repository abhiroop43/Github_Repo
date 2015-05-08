using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.IO;
using System.Collections;
using System.Data;

namespace DDSInvertedIndex
{
    public partial class UploadDocs : System.Web.UI.Page
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (fuUploadDocs.HasFile)
                {
                    //Dictionary<string, int> wordCollection = new Dictionary<string, int>();
                    ArrayList wordCollection = new ArrayList();
                    //Dictionary<int, int> postingsList = new Dictionary<int, int>();
                    DataTable dtInvIndex = CreateInvertedIndexTable();
                    int wordCount = 1;
                    HttpFileCollection hfc = Request.Files;
                    for (int i = 0; i < hfc.Count; i++)
                    {
                        HttpPostedFile hpf = hfc[i];
                        if (hpf.ContentLength > 0)
                        {

                            string fileContents = new StreamReader(hpf.InputStream).ReadToEnd();
                            foreach (string word in fileContents.Trim().Split(' '))
                            {
                                if (word.Trim() != string.Empty)
                                {
                                    if (wordCollection.Contains(word))
                                    {
                                        wordCount++;
                                        DataRow[] drInvIndex = dtInvIndex.Select("Word = '" + word + "'");
                                        //drInvIndex[0]["DocFreq"] = wordCount;
                                        if (Convert.ToInt32(drInvIndex[0]["LastDocID"]) == (i + 1))
                                        {
                                            drInvIndex[0]["Postings"] = "(" + (i + 1).ToString() + ", " + wordCount.ToString() + ")";
                                        }
                                        else
                                        {
                                            drInvIndex[0]["Postings"] = drInvIndex[0]["Postings"] + "|(" + (i + 1).ToString() + ", 1)";
                                            drInvIndex[0]["LastDocID"] = (i + 1);
                                        }
                                        
                                    }
                                    else
                                    {
                                        wordCollection.Add(word);
                                        DataRow drInvIndex = dtInvIndex.NewRow();
                                        drInvIndex["Word"] = word;
                                        //drInvIndex["DocFreq"] = 1;
                                        drInvIndex["Postings"] = "(" + (i + 1) + ", 1)";
                                        drInvIndex["LastDocID"] = (i + 1);
                                        dtInvIndex.Rows.Add(drInvIndex);
                                    }
                                }
                                
                            }
                            //postingsList.Add(i, wordCount);
                            


                            //DisplayFileContents(hpf, ref wordCollection, Path.GetFileName(hpf.FileName));
                            //hpf.SaveAs(ConfigurationManager.AppSettings["UploadPath"].ToString() + Path.GetFileName(hpf.FileName));
                        }
                    }
                    //update document frequency//
                    foreach(DataRow drInvIndex in dtInvIndex.Rows)
                    {
                        string strPostings = drInvIndex["Postings"].ToString();
                        int postingCount = 0;
                        foreach(string strPost in strPostings.Split('|'))
                        {
                            postingCount++;
                        }
                        drInvIndex["DocFreq"] = postingCount;
                    }
                    Session["dtInvIndex"] = dtInvIndex;
                    Response.Redirect("~/DisplayIndex.aspx");
                }
                else
                {
                    lblError.Text = "Please select at least one file for upload.";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        private void DisplayFileContents(HttpPostedFile file, ref ArrayList wordCollection, string docID)
        {
            string fileContents = "";

            int wordCount = 1;
            

            fileContents = new StreamReader(file.InputStream).ReadToEnd();
            //lblError.Text = fileContents;
            foreach(string word in fileContents.Trim().Split(' '))
            {
                if(wordCollection.Contains(word))
                {
                    wordCount++;
                }
                else
                { 
                    wordCollection.Add(word);
                }
            }
        }

        private DataTable CreateInvertedIndexTable()
        {
            DataTable dtInvIndex = new DataTable();
            dtInvIndex.Columns.Add("Word");
            dtInvIndex.Columns.Add("DocFreq");
            dtInvIndex.Columns.Add("Postings");
            dtInvIndex.Columns.Add("LastDocID");
            return dtInvIndex;
        }
    }
}