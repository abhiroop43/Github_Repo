using BusinessDTO;
using FutureAviator.Utlitity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FutureAviator.UserControls
{
    public partial class User_SerachJob : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!IsPostBack)
                {
                    BindDropDowns();
                }
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                List<JobResult> jobList = new List<JobResult>();
                using (DataAccess.DAL_Job dalJob = new DataAccess.DAL_Job())
                {
                    int LocationID = Convert.ToInt32(ddlLocation.SelectedValue.ToString());
                    int IndustryID = Convert.ToInt32(ddlIndustry.SelectedValue.ToString());
                    string strKeywords = txtKeywords.Text;
                    jobList = dalJob.SearchJobs(strKeywords, SessionManager.CurrentUser().LanguageCode, LocationID, IndustryID, SessionManager.CurrentUser().UserID);
                }
                if (jobList != null && jobList.Count > 0)
                {
                    dlJobSearch.DataSource = jobList;
                    dlJobSearch.DataBind();
                    lblEmptySearch.Text = "";
                }
                else
                {
                    dlJobSearch.DataSource = null;
                    dlJobSearch.DataBind();
                    lblEmptySearch.Text = "No Results Found.";
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }

        }
        protected void dlJobSearch_ItemCommand(object source, DataListCommandEventArgs e)
        {
            try
            {
                Label lblMessage = (Label)e.Item.FindControl("lblMessage");
                Button btnApply = (Button)e.Item.FindControl("btnApply");

                if (e.CommandName == "apply")
                {
                    //Handle Arguments
                    string[] Arguments = e.CommandArgument.ToString().Split('~');
                    long JobID = Convert.ToInt64(Arguments[0]);
                    string JobTitle = Arguments[1];

                    
                    //Save response in Database
                    if (SaveJobResponse(JobID) > 0)
                    {

                        //Send Notificaion to Admins
                        dynamic dtoAdmin = new DynamicDTO();
                        dtoAdmin.UserName = SessionManager.CurrentUser().DisplayName;
                        dtoAdmin.link = "SearchJob.aspx?id=" + JobID;
                        dtoAdmin.JobTitle = JobTitle;
                        Helper.SendEmailNotification(BusinessDTO.NotificationType.UserAppliedForJobNotificationForAdmin, dtoAdmin);

                        //Send Notificaion to User
                        dynamic dtoUser = new DynamicDTO();
                        dtoUser.UserName = SessionManager.CurrentUser().DisplayName;
                        dtoUser.link = "SearchJob.aspx?id=" + JobID;
                        dtoAdmin.JobTitle = JobTitle;
                        dtoUser.UserEmailAddress = SessionManager.CurrentUser().Email;
                        Helper.SendEmailNotification(BusinessDTO.NotificationType.UserAppliedForJobNotificationForUser, dtoUser);

                        lblMessage.Text = "You have applied successfully.";
                        btnApply.Enabled = false;
                    }
                    {
                        lblMessage.Text = "Already applied for this job.";
                        btnApply.Enabled = false;
                    }
                    
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        #endregion

        #region Page Level Methods

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
                    listLocation = dalCountry.GetAllActiveCountries(SessionManager.CurrentUser().LanguageCode);
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
                    listIndustry = dalIndustry.GetAllActiveIndustires(SessionManager.CurrentUser().LanguageCode);
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
        private static long SaveJobResponse(long JobID)
        {
            long lngJobResponseID = 0;
            try
            {

                using (DataAccess.DAL_JobResponse dalJobResponse = new DataAccess.DAL_JobResponse())
                {
                    if (!dalJobResponse.IsUserAppliedForJob(JobID, SessionManager.CurrentUser().UserID))
                    {
                        DataAccess.JobRespons jobResponse = new DataAccess.JobRespons();
                        jobResponse = Utlitity.Helper.AutoFill<DataAccess.JobRespons>(jobResponse, DBMethod.Add);
                        jobResponse.JobID = Convert.ToInt64(JobID);
                        jobResponse.UserID = SessionManager.CurrentUser().UserID;
                        lngJobResponseID = dalJobResponse.AddJobResponse(jobResponse);
                    }
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
               
            }
            return lngJobResponseID;
        }
        #endregion

    }
}