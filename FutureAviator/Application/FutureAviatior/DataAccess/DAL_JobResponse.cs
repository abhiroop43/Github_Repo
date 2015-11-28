using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_JobResponse : CoreEntity
    {
        public long AddJobResponse(JobRespons jobResponse)
        {
            try
            {
                Database.JobResponses.Add(jobResponse);
                Database.SaveChanges();
                return jobResponse.ResponseID;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
        public bool IsUserAppliedForJob(long JobID, long UserID)
        {
            try
            {
                JobRespons jobResponse = Database.JobResponses.Where(p => p.JobID == JobID && p.UserID == UserID).SingleOrDefault();
                if (jobResponse != null)
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
        public List<JobRespons> GetAppliedJobListByUserID(long UserID)
        {
            try
            {
                return Database.JobResponses.Where(p => p.UserID == UserID).ToList();
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<JobResponsResult> GetAllJobResponses()
        {

            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.en);
                List<JobResponsResult> jobResponseList = (from jr in Database.JobResponses
                                                          join u in Database.Users on jr.UserID equals u.UserID
                                                          join j in Database.Jobs on jr.JobID equals j.JobID
                                                          join lang_JobTitle in Database.LanguageContents on j.JobTitleTranslationID equals lang_JobTitle.TranslationID
                                                          where lang_JobTitle.LanguageCode == lang
                                                          select new JobResponsResult
                                                          {
                                                              AppliedDate = jr.CreateDate,
                                                              JobExpiryDate = j.ExpiryDate,
                                                              JobID = jr.JobID,
                                                              ResponseID = jr.ResponseID,
                                                              UserDisplayName = u.DisplayName,
                                                              UserID = u.UserID,
                                                              JobTitle = lang_JobTitle.LanguageContent1
                                                          }).ToList();

                return jobResponseList;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
