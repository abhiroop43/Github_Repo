using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FutureAviator.Utlitity;
using BusinessDTO;
using DataAccess;

namespace FutureAviator.UserControls
{
    public partial class Admin_RegisterJob : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDowns();
                if (Request.QueryString["id"] != null)
                {
                    BindJobData(Convert.ToInt32(Request.QueryString["id"]));
                    lblTitle.Text = "Update Job";
                    ButtonSaveArea.Visible = false;
                    UpdateButtonArea.Visible = true;
                }
            }
        }
        protected void btnAddJob_Click(object sender, EventArgs e)
        {
            AddUpdateJob(DBMethod.Add);
        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            AddUpdateJob(DBMethod.Update);
        }

        #endregion
        #region Methods
        private void AddUpdateJob(DBMethod method)
        {
            try
            {
                long lngJobID = 0;
                long JobTitleTranslationID = 0;
                long JobDescriptionTranslationID = 0;

                if(ddlIndustry.SelectedIndex == 0)
                {
                    Helper.ShowNotification("Please select Industry.", UINotificationType.Error);
                    return;
                }
                if (ddlLocation.SelectedIndex == 0)
                {
                    Helper.ShowNotification("Please select Location.", UINotificationType.Error);
                    return;
                }
                DataAccess.Job job = new DataAccess.Job();

                using (DataAccess.DAL_Job dalJob = new DataAccess.DAL_Job())
                {
                    if (method == DBMethod.Add)
                    {
                        job = FutureAviator.Utlitity.Helper.AutoFill<DataAccess.Job>(job, BusinessDTO.DBMethod.Add);
                        JobTitleTranslationID = DataAccess.DBHelper.GetUniqueID();
                        JobDescriptionTranslationID = DataAccess.DBHelper.GetUniqueID();
                    }
                    else
                    {
                        job = FutureAviator.Utlitity.Helper.AutoFill<DataAccess.Job>(job, BusinessDTO.DBMethod.Update);
                        JobTitleTranslationID = Convert.ToInt64(hdnJobTitleTranslationID.Value);
                        JobDescriptionTranslationID = Convert.ToInt64(hdnJobDescriptionTranslationID.Value);
                        lngJobID = Convert.ToInt64(hdnJobID.Value);
                    }

                    job.CountryID = Convert.ToInt32(ddlLocation.SelectedValue.ToString());
                    job.ExpiryDate = txtExpiryDate.SelectedDate;
                    job.IndustryID = Convert.ToInt32(ddlIndustry.SelectedValue.ToString());


                    job.JobTitleTranslationID = JobTitleTranslationID;
                    job.JobDescriptionTranslationID = JobDescriptionTranslationID;



                    job.Keywords = txtKeywords.Text;
                    job.IsActive = chkbxIsActive.Checked;
                    if (method == DBMethod.Add)
                    {
                        lngJobID = dalJob.AddJob(job);
                        if (lngJobID > 0)
                        {
                            DataAccess.DBHelper.AddLanguageContent(JobTitleTranslationID, txtJobTitleEnglish.Text, txtJobTitleArabic.Text, BusinessDTO.LanguageContentType.JobTitle);
                            DataAccess.DBHelper.AddLanguageContent(JobDescriptionTranslationID, txtJobDescriptionEnglish.Value, txtJobDescriptionArabic.Value, BusinessDTO.LanguageContentType.JobDescription);

                            Helper.ClearInputs(this.Controls);
                            Helper.ShowNotification("Job Saved successfully.", UINotificationType.Success);
                        }
                        else
                            Helper.ShowNotification("Job Not Saved.", UINotificationType.Error);
                    }
                    else
                    {
                        if (dalJob.UpdateJobByID(lngJobID, job))
                        {
                            DataAccess.DBHelper.UpdateLanguageContent(JobTitleTranslationID, txtJobTitleEnglish.Text, txtJobTitleArabic.Text, BusinessDTO.LanguageContentType.JobTitle);
                            DataAccess.DBHelper.UpdateLanguageContent(JobDescriptionTranslationID, txtJobDescriptionEnglish.Value, txtJobDescriptionArabic.Value, BusinessDTO.LanguageContentType.JobDescription);
                            Response.Redirect("RegiseredJobs.aspx?MessageType=successupdate",false);
                        }
                        else
                            Helper.ShowNotification("Job update failed!", UINotificationType.Error);
                    }

                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        private void BindDropDowns()
        {
            BindLocation();
            BindIndustry();
        }
        private void BindLocation()
        {
            try
            {
                List<DynamicDTO> listLocation = new List<DynamicDTO>();
                using (DataAccess.DAL_Country dalCountry = new DataAccess.DAL_Country())
                {
                    listLocation = dalCountry.GetAllActiveCountries(ApplicationLanguages.en);
                }
                if (listLocation != null && listLocation.Count > 0)
                {
                    ddlLocation.DataSource = listLocation;
                    ddlLocation.DataTextField = "Value";
                    ddlLocation.DataValueField = "Key";
                    ddlLocation.DataBind();
                    Helper.InsertSelectFirstItem(ddlLocation);

                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        private void BindIndustry()
        {
            try
            {
                List<DynamicDTO> listIndustry = new List<DynamicDTO>();
                using (DataAccess.DAL_Industry dalIndustry = new DataAccess.DAL_Industry())
                {
                    listIndustry = dalIndustry.GetAllActiveIndustires(ApplicationLanguages.en);
                }
                if (listIndustry != null && listIndustry.Count > 0)
                {
                    ddlIndustry.DataSource = listIndustry;
                    ddlIndustry.DataTextField = "Value";
                    ddlIndustry.DataValueField = "Key";
                    ddlIndustry.DataBind();
                    Helper.InsertSelectFirstItem(ddlIndustry);

                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        private void BindJobData(long JobID)
        {
            try
            {
                using (DAL_Job dalJob = new DAL_Job())
                {
                    EditJobResult jobResult = dalJob.GetJobByIDForUpdate(JobID);
                    if (jobResult != null)
                    {
                        txtExpiryDate.SelectedDate = jobResult.ExpiryDate;
                        txtJobDescriptionArabic.InnerHtml = jobResult.JobDescriptionArabic;
                        txtJobDescriptionEnglish.InnerHtml = jobResult.JobDescriptionEnglish;
                        txtJobTitleArabic.Text = jobResult.JobTitleArabic;
                        txtJobTitleEnglish.Text = jobResult.JobTitleEnglish;
                        txtKeywords.Text = jobResult.Keywords;

                        chkbxIsActive.Checked = jobResult.IsActive;
                        ddlIndustry.Items.FindByValue(jobResult.IndustryID.ToString()).Selected = true;
                        ddlLocation.Items.FindByValue(jobResult.CountryID.ToString()).Selected = true;

                        //Set Hidden Fields
                        hdnJobTitleTranslationID.Value = jobResult.JobTitleTranslationID.ToString();
                        hdnJobDescriptionTranslationID.Value = jobResult.JobDescriptionTranslationID.ToString();
                        hdnJobID.Value = JobID.ToString();
                    }
                    else
                    {
                        Helper.ShowNotification("Job not found!", UINotificationType.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        #endregion



    }
}