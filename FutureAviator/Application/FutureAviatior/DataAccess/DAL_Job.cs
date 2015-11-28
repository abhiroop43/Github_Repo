using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_Job : CoreEntity
    {
        public long AddJob(DataAccess.Job job)
        {
            try
            {
                Database.Jobs.Add(job);
                Database.SaveChanges();
                return job.JobID;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
        public bool UpdateJobByID(long JobID,DataAccess.Job job)
        {
            try
            {
                DataAccess.Job myJob = Database.Jobs.Where(p => p.JobID == JobID).SingleOrDefault();
                if (myJob != null)
                {
                    myJob.Keywords = job.Keywords;
                    myJob.UpdateBy = job.UpdateBy;
                    myJob.UpdateDate = job.UpdateDate;
                    myJob.ExpiryDate = job.ExpiryDate;
                    myJob.IsActive = job.IsActive;
                    myJob.CountryID = job.CountryID;
                    myJob.IndustryID = job.IndustryID;
                    Database.SaveChanges();
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
        public List<JobResult> SearchJobs(string searchQuery, BusinessDTO.ApplicationLanguages appLanguage, int LocationID = 0, int IndustryID = 0, long UserID = 0, long JobID = 0)
        {
            string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
            List<JobResult> jobResult = new List<JobResult>();

            try
            {
                using (DAL_JobResponse dalJobResponse = new DAL_JobResponse())
                {
                    if (LocationID <= 0 && IndustryID <= 0)
                    {
                        jobResult = (from j in Database.Jobs
                                     join l in Database.LanguageContents on j.JobTitleTranslationID equals l.TranslationID
                                     join ldescription in Database.LanguageContents on j.JobDescriptionTranslationID equals ldescription.TranslationID
                                     join lcountry in Database.LanguageContents on j.Country.CountryNameTranslationID equals lcountry.TranslationID
                                     join lIndustry in Database.LanguageContents on j.Industry.IndustryNameTranslationID equals lIndustry.TranslationID
                                     where (l.ContentTypeID == (int)LanguageContentType.JobTitle || l.ContentTypeID == (int)LanguageContentType.JobDescription)
                                     && (l.LanguageContent1.Contains(searchQuery) || ldescription.LanguageContent1.Contains(searchQuery))
                                     && (l.LanguageCode == lang && ldescription.LanguageCode == lang && lcountry.LanguageCode == lang && lIndustry.LanguageCode == lang)
                                     select new JobResult
                                     {
                                         JobID = j.JobID,
                                         CountryID = j.CountryID,
                                         CountryName = lcountry.LanguageContent1,
                                         CreateDate = j.CreateDate,
                                         ExpiryDate = j.ExpiryDate,
                                         IndustryID = j.IndustryID,
                                         IndustryName = lIndustry.LanguageContent1,
                                         JobDescription = ldescription.LanguageContent1,
                                         JobTitle = l.LanguageContent1,
                                         Keywords = j.Keywords,
                                         IsActive = j.IsActive,
                                         JobTitleTranslationID = l.TranslationID,
                                         JobDescriptionTranslationID = ldescription.TranslationID
                                     }).AsEnumerable().Select(x =>
                                     {
                                         JobResult result = new JobResult();
                                         result.JobID = x.JobID;
                                         result.CountryID = x.CountryID;
                                         result.CountryName = x.CountryName;
                                         result.CreateDate = x.CreateDate;
                                         result.ExpiryDate = x.ExpiryDate;
                                         result.IndustryID = x.IndustryID;
                                         result.IndustryName = x.IndustryName;
                                         result.JobDescription = x.JobDescription;
                                         result.JobTitle = x.JobTitle;
                                         result.Keywords = x.Keywords;
                                         result.IsActive = x.IsActive;
                                         result.IsAlreadyApplied = dalJobResponse.IsUserAppliedForJob(x.JobID, UserID);
                                         result.JobTitleTranslationID = x.JobTitleTranslationID;
                                         result.JobDescriptionTranslationID = x.JobDescriptionTranslationID;
                                         return (JobResult)result;
                                     }).ToList();

                      
                    }
                    else if (LocationID > 0 && IndustryID <= 0)
                    {
                        jobResult = (from j in Database.Jobs
                                     join l in Database.LanguageContents on j.JobTitleTranslationID equals l.TranslationID
                                     join ldescription in Database.LanguageContents on j.JobDescriptionTranslationID equals ldescription.TranslationID
                                     join lcountry in Database.LanguageContents on j.Country.CountryNameTranslationID equals lcountry.TranslationID
                                     join lIndustry in Database.LanguageContents on j.Industry.IndustryNameTranslationID equals lIndustry.TranslationID
                                     where (l.ContentTypeID == (int)LanguageContentType.JobTitle || l.ContentTypeID == (int)LanguageContentType.JobDescription)
                                     && (l.LanguageContent1.Contains(searchQuery) || ldescription.LanguageContent1.Contains(searchQuery))
                                     && j.CountryID == LocationID
                                     && (l.LanguageCode == lang && ldescription.LanguageCode == lang && lcountry.LanguageCode == lang && lIndustry.LanguageCode == lang)
                                     select new JobResult
                                     {
                                         JobID = j.JobID,
                                         CountryID = j.CountryID,
                                         CountryName = lcountry.LanguageContent1,
                                         CreateDate = j.CreateDate,
                                         ExpiryDate = j.ExpiryDate,
                                         IndustryID = j.IndustryID,
                                         IndustryName = lIndustry.LanguageContent1,
                                         JobDescription = ldescription.LanguageContent1,
                                         JobTitle = l.LanguageContent1,
                                         Keywords = j.Keywords,
                                         IsActive = j.IsActive,
                                         JobTitleTranslationID = l.TranslationID,
                                         JobDescriptionTranslationID = ldescription.TranslationID
                                     }).AsEnumerable().Select(x =>
                                     {
                                         JobResult result = new JobResult();
                                         result.JobID = x.JobID;
                                         result.CountryID = x.CountryID;
                                         result.CountryName = x.CountryName;
                                         result.CreateDate = x.CreateDate;
                                         result.ExpiryDate = x.ExpiryDate;
                                         result.IndustryID = x.IndustryID;
                                         result.IndustryName = x.IndustryName;
                                         result.JobDescription = x.JobDescription;
                                         result.JobTitle = x.JobTitle;
                                         result.Keywords = x.Keywords;
                                         result.IsActive = x.IsActive;
                                         result.IsAlreadyApplied = dalJobResponse.IsUserAppliedForJob(x.JobID, UserID);
                                         result.JobTitleTranslationID = x.JobTitleTranslationID;
                                         result.JobDescriptionTranslationID = x.JobDescriptionTranslationID;
                                         return (JobResult)result;
                                     }).ToList();

                       
                    }

                    else if (LocationID <= 0 && IndustryID > 0)
                    {
                        jobResult = (from j in Database.Jobs
                                     join l in Database.LanguageContents on j.JobTitleTranslationID equals l.TranslationID
                                     join ldescription in Database.LanguageContents on j.JobDescriptionTranslationID equals ldescription.TranslationID
                                     join lcountry in Database.LanguageContents on j.Country.CountryNameTranslationID equals lcountry.TranslationID
                                     join lIndustry in Database.LanguageContents on j.Industry.IndustryNameTranslationID equals lIndustry.TranslationID
                                     where (l.ContentTypeID == (int)LanguageContentType.JobTitle || l.ContentTypeID == (int)LanguageContentType.JobDescription)
                                     && (l.LanguageContent1.Contains(searchQuery) || ldescription.LanguageContent1.Contains(searchQuery))
                                     && j.IndustryID == IndustryID
                                     && (l.LanguageCode == lang && ldescription.LanguageCode == lang && lcountry.LanguageCode == lang && lIndustry.LanguageCode == lang)
                                     select new JobResult
                                     {
                                         JobID = j.JobID,
                                         CountryID = j.CountryID,
                                         CountryName = lcountry.LanguageContent1,
                                         CreateDate = j.CreateDate,
                                         ExpiryDate = j.ExpiryDate,
                                         IndustryID = j.IndustryID,
                                         IndustryName = lIndustry.LanguageContent1,
                                         JobDescription = ldescription.LanguageContent1,
                                         JobTitle = l.LanguageContent1,
                                         Keywords = j.Keywords,
                                         IsActive = j.IsActive,
                                         JobTitleTranslationID = l.TranslationID,
                                         JobDescriptionTranslationID = ldescription.TranslationID
                                     }).AsEnumerable().Select(x =>
                                     {
                                         JobResult result = new JobResult();
                                         result.JobID = x.JobID;
                                         result.CountryID = x.CountryID;
                                         result.CountryName = x.CountryName;
                                         result.CreateDate = x.CreateDate;
                                         result.ExpiryDate = x.ExpiryDate;
                                         result.IndustryID = x.IndustryID;
                                         result.IndustryName = x.IndustryName;
                                         result.JobDescription = x.JobDescription;
                                         result.JobTitle = x.JobTitle;
                                         result.Keywords = x.Keywords;
                                         result.IsActive = x.IsActive;
                                         result.IsAlreadyApplied = dalJobResponse.IsUserAppliedForJob(x.JobID, UserID);
                                         result.JobTitleTranslationID = x.JobTitleTranslationID;
                                         result.JobDescriptionTranslationID = x.JobDescriptionTranslationID;
                                         return (JobResult)result;
                                     }).ToList();

                       
                    }
                    else
                    {
                        jobResult = (from j in Database.Jobs
                                     join l in Database.LanguageContents on j.JobTitleTranslationID equals l.TranslationID
                                     join ldescription in Database.LanguageContents on j.JobDescriptionTranslationID equals ldescription.TranslationID
                                     join lcountry in Database.LanguageContents on j.Country.CountryNameTranslationID equals lcountry.TranslationID
                                     join lIndustry in Database.LanguageContents on j.Industry.IndustryNameTranslationID equals lIndustry.TranslationID
                                     where (l.ContentTypeID == (int)LanguageContentType.JobTitle || l.ContentTypeID == (int)LanguageContentType.JobDescription)
                                     && (l.LanguageContent1.Contains(searchQuery) || ldescription.LanguageContent1.Contains(searchQuery))
                                     && j.IndustryID == IndustryID
                                     && j.CountryID == LocationID
                                     && (l.LanguageCode == lang && ldescription.LanguageCode == lang && lcountry.LanguageCode == lang && lIndustry.LanguageCode == lang)
                                     select new
                                     {
                                         JobID = j.JobID,
                                         CountryID = j.CountryID,
                                         CountryName = lcountry.LanguageContent1,
                                         CreateDate = j.CreateDate,
                                         ExpiryDate = j.ExpiryDate,
                                         IndustryID = j.IndustryID,
                                         IndustryName = lIndustry.LanguageContent1,
                                         JobDescription = ldescription.LanguageContent1,
                                         JobTitle = l.LanguageContent1,
                                         Keywords = j.Keywords,
                                         IsActive = j.IsActive,
                                         JobTitleTranslationID = l.TranslationID,
                                         JobDescriptionTranslationID = ldescription.TranslationID
                                     }).AsEnumerable().Select(x =>
                                                {
                                                    JobResult result = new JobResult();
                                                    result.JobID = x.JobID;
                                                    result.CountryID = x.CountryID;
                                                    result.CountryName = x.CountryName;
                                                    result.CreateDate = x.CreateDate;
                                                    result.ExpiryDate = x.ExpiryDate;
                                                    result.IndustryID = x.IndustryID;
                                                    result.IndustryName = x.IndustryName;
                                                    result.JobDescription = x.JobDescription;
                                                    result.JobTitle = x.JobTitle;
                                                    result.Keywords = x.Keywords;
                                                    result.IsActive = x.IsActive;
                                                    result.IsAlreadyApplied = dalJobResponse.IsUserAppliedForJob(x.JobID, UserID);
                                                    result.JobTitleTranslationID = x.JobTitleTranslationID;
                                                    result.JobDescriptionTranslationID = x.JobDescriptionTranslationID;
                                                    return (JobResult)result;
                                                }).ToList();
                    }

                    if (JobID > 0)
                    {
                        jobResult = jobResult.Where(p => p.JobID == JobID).ToList();
                    }
                    return jobResult;
                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }

        }
        public List<JobResult> GetAllJobs()
        {
            List<JobResult> jobResult = new List<JobResult>();

            try
            {
                jobResult = SearchJobs("", ApplicationLanguages.en);
                return jobResult;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public EditJobResult GetJobByIDForUpdate(long JobID)
        {
            EditJobResult jobResult = new EditJobResult();
            List<JobResult> jobResultEnglish = new List<JobResult>();
            List<JobResult> jobResultArabic = new List<JobResult>();

            try
            {
                jobResultEnglish = SearchJobs("", ApplicationLanguages.en, 0, 0, 0, JobID);
                jobResultArabic = SearchJobs("", ApplicationLanguages.ar, 0, 0, 0, JobID);

                if (jobResultEnglish != null && jobResultEnglish.Count > 0 && jobResultArabic != null && jobResultArabic.Count > 0)
                {
                    jobResult.CountryID = jobResultEnglish[0].CountryID;
                    jobResult.CountryName = jobResultEnglish[0].CountryName;
                    jobResult.CreateDate = jobResultEnglish[0].CreateDate;
                    jobResult.ExpiryDate = jobResultEnglish[0].ExpiryDate;
                    jobResult.IndustryID = jobResultEnglish[0].IndustryID;
                    jobResult.IndustryName = jobResultEnglish[0].IndustryName;
                    jobResult.IsActive = jobResultEnglish[0].IsActive;
                    jobResult.Keywords = jobResultEnglish[0].Keywords;
                    //Set English
                    jobResult.JobDescriptionEnglish = jobResultEnglish[0].JobDescription;
                    jobResult.JobTitleEnglish = jobResultEnglish[0].JobTitle;
                    //Set Arabic
                    jobResult.JobDescriptionArabic = jobResultArabic[0].JobDescription;
                    jobResult.JobTitleArabic = jobResultArabic[0].JobTitle;

                    //Translation Ids
                    jobResult.JobTitleTranslationID = jobResultEnglish[0].JobTitleTranslationID;
                    jobResult.JobDescriptionTranslationID = jobResultEnglish[0].JobDescriptionTranslationID;

                    return jobResult;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

    }
}
