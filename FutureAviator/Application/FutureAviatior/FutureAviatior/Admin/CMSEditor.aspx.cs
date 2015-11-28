using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Data.Entity;

namespace FutureAviator.Admin
{
    public partial class CMSEditor : System.Web.UI.Page
    {
        private static int CMSSectionTypeID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    //LoadSectionTypes();
                    if (Request.QueryString["id"] != null && Request.QueryString["id"] != "")
                    {
                        CMSSectionTypeID = Convert.ToInt32(Request.QueryString["id"]);
                        LoadSectionData();
                    }
                }
            }
            catch (Exception ex)
            {
                Helper.ShowNotification("Error occurred. Please check the log for details.", BusinessDTO.UINotificationType.Error);
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }

        }

        private void LoadSectionData()
        {
            int sectionTypeID = CMSSectionTypeID;

            List<CMSSectionResult> sectionData = new List<CMSSectionResult>();

            using (DAL_CMS objCMS = new DAL_CMS())
            {
                //english//
                sectionData = objCMS.GetCMSContent(ApplicationLanguages.en, sectionTypeID);

                if (sectionData != null & sectionData.Count > 0)
                {
                    foreach (CMSSectionResult cms in sectionData)
                    {
                        hfCMSSectionID.Value = cms.ID.ToString();
                        txtSectionNameEnglish.Text = cms.SectionName;
                        txtEnglish.Text = cms.SectionText;
                    }

                    //arabic//
                    sectionData = objCMS.GetCMSContent(ApplicationLanguages.ar, sectionTypeID);

                    foreach (CMSSectionResult cms in sectionData)
                    {
                        hfCMSSectionID.Value = cms.ID.ToString();
                        txtSectionNameArabic.Text = cms.SectionName;
                        txtArabic.Text = cms.SectionText;
                    }
                }
                else
                {
                    ResetForm();
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int sectionTypeID = CMSSectionTypeID;

                if (hfCMSSectionID.Value.Trim() != "")
                {
                    using (DAL_CMS objCMS = new DAL_CMS())
                    {
                        //CoreEntity c = new CoreEntity();
                        CMSSection currentSection = objCMS.Database.CMSSections.Find(Convert.ToInt32(hfCMSSectionID.Value));

                        long sectionNameTransID = DBHelper.GetUniqueID();
                        //CMSSection newSection = new CMSSection();
                        currentSection.SectionName = sectionNameTransID;
                        DBHelper.AddLanguageContent(sectionNameTransID, txtSectionNameEnglish.Text.Trim(), txtSectionNameArabic.Text.Trim(), BusinessDTO.LanguageContentType.CMSSectionName);

                        long sectionTextTransID = DBHelper.GetUniqueID();
                        currentSection.SectionText = sectionTextTransID;
                        DBHelper.AddLanguageContent(sectionTextTransID, txtEnglish.Text.Trim(), txtArabic.Text.Trim(), BusinessDTO.LanguageContentType.CMSSectionText);

                        //currentSection.ID = Convert.ToInt32(hfCMSSectionID.Value);
                        currentSection.Status = "A";
                        currentSection = Helper.AutoFill<CMSSection>(currentSection, DBMethod.Update);
                        //currentSection.ModifiedOn = DateTime.Today;
                        //currentSection.ModifiedBy = 2;

                        currentSection.SectionTypeID = sectionTypeID;
                        objCMS.Database.Entry(currentSection).State = EntityState.Modified;
                        objCMS.Database.SaveChanges();
                        ResetForm();
                        //lblStatus.Text = "Content updated successfully.";
                        Helper.ShowNotification("Content updated successfully", UINotificationType.Success);
                    }
                }
                else
                {
                    long sectionNameTransID = DBHelper.GetUniqueID();
                    CMSSection newSection = new CMSSection();
                    newSection.SectionName = sectionNameTransID;
                    DBHelper.AddLanguageContent(sectionNameTransID, txtSectionNameEnglish.Text.Trim(), txtSectionNameArabic.Text.Trim(), LanguageContentType.CMSSectionName);

                    long sectionTextTransID = DBHelper.GetUniqueID();
                    newSection.SectionText = sectionTextTransID;
                    DBHelper.AddLanguageContent(sectionTextTransID, txtEnglish.Text.Trim(), txtArabic.Text.Trim(), LanguageContentType.CMSSectionText);

                    newSection.Status = "A";
                    newSection = Helper.AutoFill<CMSSection>(newSection, DBMethod.Add);
                    //newSection.AddedOn = DateTime.Today;
                    //newSection.AddedBy = 2;

                    newSection.SectionTypeID = sectionTypeID;

                    using (DAL_CMS objCMS = new DAL_CMS())
                    {
                        objCMS.Database.CMSSections.Add(newSection);
                        objCMS.Database.SaveChanges();
                        //lblStatus.Text = "Content added successfully.";
                        Helper.ShowNotification("Content Added successfully", BusinessDTO.UINotificationType.Success);
                        ResetForm();
                    }
                }

            }
            catch (Exception ex)
            {
                //lblStatus.Text = ex.ToString();
                Helper.ShowNotification(ex.ToString(), BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void ResetForm()
        {
            txtArabic.Text = string.Empty;
            txtEnglish.Text = string.Empty;
            txtSectionNameArabic.Text = string.Empty;
            txtSectionNameEnglish.Text = string.Empty;
            //ddlsectionType.SelectedIndex = 0;
        }
    }
}