using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_Industry : CoreEntity
    {
        public int AddIndustry(DataAccess.Industry industry)
        {
            try
            {
                Database.Industries.Add(industry);
                Database.SaveChanges();
                return industry.IndustryID;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
        public bool UpdateIustryByID(int IndustryID, DataAccess.Industry industry)
        {
            try
            {
                Industry myIndustry = Database.Industries.Where(p => p.IndustryID == IndustryID).SingleOrDefault();
                if (myIndustry != null)
                {
                    myIndustry.IsActive = industry.IsActive;
                    myIndustry.UpdateBy = industry.UpdateBy;
                    myIndustry.UpdateDate = industry.UpdateDate;
                    Database.SaveChanges();
                }

                return true;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public List<DynamicDTO> GetAllActiveIndustires(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<DynamicDTO> query = (from i in Database.Industries
                                          join l in Database.LanguageContents on i.IndustryNameTranslationID equals l.TranslationID
                                          where l.LanguageCode == lang && i.IsActive == true
                                          select new DynamicDTO
                                          {
                                              Value = l.LanguageContent1,
                                              Key = i.IndustryID
                                          }).ToList();



                return query;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public List<IndustryResult> GetAllIndustires()
        {
            try
            {
                BusinessDTO.ApplicationLanguages appLanguage = ApplicationLanguages.en;
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<IndustryResult> query = (from i in Database.Industries
                                              join iName in Database.LanguageContents on i.IndustryNameTranslationID equals iName.TranslationID
                                              where iName.LanguageCode == lang
                                              select new IndustryResult
                                          {
                                              CreateDate = i.CreateDate,
                                              IndustryID = i.IndustryID,
                                              IndustryName = iName.LanguageContent1,
                                              IsActive = i.IsActive
                                          }).ToList();



                return query;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public EditIndustryResult GetIndustryByID(Int32 IndustryID)
        {
            try
            {

                string langEn = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.en);
                string langAr = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.ar);

                EditIndustryResult industryResult = new EditIndustryResult();

                IndustryResult industryEnglish = (from i in Database.Industries
                                                  join iName in Database.LanguageContents on i.IndustryNameTranslationID equals iName.TranslationID
                                                  where iName.LanguageCode == langEn && i.IndustryID == IndustryID
                                                  select new IndustryResult
                                                  {
                                                      CreateDate = i.CreateDate,
                                                      IndustryID = i.IndustryID,
                                                      IndustryName = iName.LanguageContent1,
                                                      IsActive = i.IsActive,
                                                      IndustryNameTranslationID = iName.TranslationID
                                                  }).SingleOrDefault();

                IndustryResult industryArabic = (from i in Database.Industries
                                                 join iName in Database.LanguageContents on i.IndustryNameTranslationID equals iName.TranslationID
                                                 where iName.LanguageCode == langAr && i.IndustryID == IndustryID
                                                 select new IndustryResult
                                                 {
                                                     CreateDate = i.CreateDate,
                                                     IndustryID = i.IndustryID,
                                                     IndustryName = iName.LanguageContent1,
                                                     IsActive = i.IsActive,
                                                     IndustryNameTranslationID = iName.TranslationID
                                                 }).SingleOrDefault();


                industryResult.CreateDate = industryEnglish.CreateDate;
                industryResult.IndustryID = industryEnglish.IndustryID;
                industryResult.IsActive = industryEnglish.IsActive;

                industryResult.IndustryNameEnglish = industryEnglish.IndustryName;
                industryResult.IndustryNameArabic = industryArabic.IndustryName;
                industryResult.IndustryNameTranslationID = industryArabic.IndustryNameTranslationID;

                return industryResult;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
