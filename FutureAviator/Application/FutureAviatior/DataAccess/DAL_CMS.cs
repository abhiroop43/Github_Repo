using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BusinessDTO;

namespace DataAccess
{
    public class DAL_CMS : CoreEntity
    {
        public List<CMSSectionResult> GetCMSContent(ApplicationLanguages appLanguage, CMSSectionTypes sectionID)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<CMSSectionResult> cmsSections = (from cms in Database.CMSSections
                                                      join lSectionName in Database.LanguageContents on cms.SectionName equals lSectionName.TranslationID
                                                      join lSectionText in Database.LanguageContents on cms.SectionText equals lSectionText.TranslationID
                                                      where (lSectionName.ContentTypeID == (int)LanguageContentType.CMSSectionName || lSectionText.ContentTypeID == (int)LanguageContentType.CMSSectionText)
                                                      && (lSectionName.LanguageCode == lang && lSectionText.LanguageCode == lang)
                                          && cms.Status == "A" && cms.SectionTypeID == (int)sectionID
                                                      select new CMSSectionResult
                                                     {
                                                         ID = cms.ID,
                                                         SectionName = lSectionName.LanguageContent1,
                                                         SectionText = lSectionText.LanguageContent1,
                                                         SectionTypeID = cms.SectionTypeID,
                                                         Status = cms.Status
                                                     }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList();
                return cmsSections;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<CMSSectionResult> GetCMSContent(ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<CMSSectionResult> cmsSections = (from cms in Database.CMSSections
                                                      join lSectionName in Database.LanguageContents on cms.SectionName equals lSectionName.TranslationID
                                                      join lSectionText in Database.LanguageContents on cms.SectionText equals lSectionText.TranslationID
                                                      where (lSectionName.ContentTypeID == (int)LanguageContentType.CMSSectionName || lSectionText.ContentTypeID == (int)LanguageContentType.CMSSectionText)
                                                      && (lSectionName.LanguageCode == lang && lSectionText.LanguageCode == lang)
                                          && cms.Status == "A"
                                                      select new CMSSectionResult
                                                      {
                                                          ID = cms.ID,
                                                          SectionName = lSectionName.LanguageContent1,
                                                          SectionText = lSectionText.LanguageContent1,
                                                          SectionTypeID = cms.SectionTypeID,
                                                          Status = cms.Status
                                                      }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList();
                return cmsSections;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<CMSSectionResult> GetCMSContent(ApplicationLanguages appLanguage, int sectionID)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<CMSSectionResult> cmsSections = (from cms in Database.CMSSections
                                                      join lSectionName in Database.LanguageContents on cms.SectionName equals lSectionName.TranslationID
                                                      join lSectionText in Database.LanguageContents on cms.SectionText equals lSectionText.TranslationID
                                                      where (lSectionName.ContentTypeID == (int)LanguageContentType.CMSSectionName || lSectionText.ContentTypeID == (int)LanguageContentType.CMSSectionText)
                                                      && (lSectionName.LanguageCode == lang && lSectionText.LanguageCode == lang)
                                          && cms.Status == "A" && cms.SectionTypeID == sectionID
                                                      select new CMSSectionResult
                                                      {
                                                          ID = cms.ID,
                                                          SectionName = lSectionName.LanguageContent1,
                                                          SectionText = lSectionText.LanguageContent1,
                                                          SectionTypeID = cms.SectionTypeID,
                                                          Status = cms.Status
                                                      }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList();
                return cmsSections;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
