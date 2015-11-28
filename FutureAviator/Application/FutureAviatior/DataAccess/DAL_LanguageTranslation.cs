using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_LanguageTranslation : CoreEntity
    {
        public bool AddLanguageTranslation(DataAccess.LanguageContent languageContent, ApplicationLanguages appLanguage)
        {
            try
            {
                languageContent.LanguageCode = appLanguage == ApplicationLanguages.en ? "en" : "ar";
                Database.LanguageContents.Add(languageContent);
                Database.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public bool DeleteLanguageTranslation(long TranslationID)
        {
            try
            {

                List<LanguageContent> myLanguageContent = Database.LanguageContents.Where(p => p.TranslationID == TranslationID).ToList();
                if (myLanguageContent != null && myLanguageContent.Count > 0)
                {
                    foreach (LanguageContent item in myLanguageContent)
                    {
                        Database.LanguageContents.Remove(item);
                        Database.SaveChanges();
                    }
                    
                }
                return true;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
        public bool UpdateLanguageTranslation(DataAccess.LanguageContent languageContent, ApplicationLanguages appLanguage)
        {
            try
            {
                languageContent.LanguageCode = appLanguage == ApplicationLanguages.en ? "en" : "ar";

                LanguageContent myLanguageContent = Database.LanguageContents.Where(p => p.TranslationID == languageContent.TranslationID && p.LanguageCode == languageContent.LanguageCode).SingleOrDefault();
                if (myLanguageContent != null)
                {
                    myLanguageContent.LanguageContent1 = languageContent.LanguageContent1;
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
    }
}
