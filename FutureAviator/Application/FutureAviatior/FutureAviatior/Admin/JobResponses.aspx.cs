using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using BusinessDTO;

namespace FutureAviator.Admin
{
    public partial class JobResponses : System.Web.UI.Page
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                if (Request.QueryString["JobDetails"] != null)
                {
                    string[] param = Convert.ToString(Request.QueryString["JobDetails"]).Split('~');
                    long JobResponseID = Convert.ToInt64(param[0]);
                    long UserID = Convert.ToInt64(param[1]);
                    long JobID = Convert.ToInt64(param[2]);
                    GetUserAndJobDetails(JobResponseID, UserID, JobID);
                }
        }
        #endregion

        #region Methods
        private void GetUserAndJobDetails(long JobResponseID, long UserID, long JobID)
        {
            try
            {
                string Result = "";

                using (DAL_User dalUser = new DAL_User())
                {
                    DataAccess.User user = dalUser.GetUseByID(UserID);
                    if (user != null)
                    {
                        Result += "<h4>User Details</h4>";
                        Result += "<b>Full Name</b> : " + user.DisplayName + "<br>";
                        Result += "<b>Email</b> : " + user.Email + "<br>";
                        Result += "<b>Reg. Date</b> : " + user.CreateDate.ToShortDateString() + " " + user.CreateDate.ToShortTimeString() + "<br>";
                        Result += "<b>Account Status</b> : " + (user.IsActive == true ? "Active" : "Deactive") + "<br>";
                    }
                }
                using (DAL_Job dalJob = new DAL_Job())
                {
                    EditJobResult job = dalJob.GetJobByIDForUpdate(JobID);
                    if (job != null)
                    {
                        Result += "<br><h4>Job Details</h4>";
                        Result += "<b>Job Title</b> : " + job.JobTitleEnglish + "<br>";
                        Result += "<b>Job Industry</b> : " + job.IndustryName + "<br>";
                        Result += "<b>Job Location</b> : " + job.CountryName + "<br>";
                        Result += "<b>Keywords</b> : " + job.Keywords + "<br>";
                        Result += "<b>Job Post Date</b> : " + job.CreateDate.ToShortDateString() + " " + job.CreateDate.ToShortTimeString() + "<br>";
                        Result += "<b>Job Expiry Date</b> : " + job.ExpiryDate.ToShortDateString() + "<br>";
                        Result += "<b>Job Status</b> : " + (job.IsActive == true ? "Active" : "Deactive") + "<br>";
                        Result += "<b>Job Description</b> : " + job.JobDescriptionEnglish + "<br>";
                    }
                }

                Response.Write(Result);
                Response.End();

            }
            catch (Exception ex)
            {
                //Logger.WriteErrorLog(ex);
                //Response.Write("ERROR");
                //Response.End();
            }
        }
        #endregion
    }
}