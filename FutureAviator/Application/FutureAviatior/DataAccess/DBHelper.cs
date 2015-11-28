using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace DataAccess
{

    public class DBHelper
    {
        public static long GetUniqueID()
        {
            long uniqueID = 0;
            using (DataAccess.DAL_I18N dali18n = new DataAccess.DAL_I18N())
            {
                uniqueID = dali18n.AddI18N();
            }
            return uniqueID;
        }
        public static string GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages appLanguage)
        {
            return appLanguage == BusinessDTO.ApplicationLanguages.en ? "en" : "ar";
        }
        public static bool AddLanguageContent(long UniqueID, string EnglishContent, string ArabicContent, LanguageContentType contentType)
        {
            try
            {
                using (DataAccess.DAL_LanguageTranslation dal_languageTranslation = new DataAccess.DAL_LanguageTranslation())
                {
                    DataAccess.LanguageContent languageContent = new DataAccess.LanguageContent();
                    languageContent.LanguageContent1 = EnglishContent;
                    languageContent.TranslationID = UniqueID;
                    languageContent.ContentTypeID = (int)contentType;
                    dal_languageTranslation.AddLanguageTranslation(languageContent, BusinessDTO.ApplicationLanguages.en);

                    languageContent = new DataAccess.LanguageContent();
                    languageContent.TranslationID = UniqueID;
                    languageContent.LanguageContent1 = ArabicContent;
                    languageContent.ContentTypeID = (int)contentType;
                    dal_languageTranslation.AddLanguageTranslation(languageContent, BusinessDTO.ApplicationLanguages.ar);
                    return true;
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
        public static bool UpdateLanguageContent(long UniqueID, string EnglishContent, string ArabicContent, LanguageContentType contentType)
        {
            try
            {
                using (DataAccess.DAL_LanguageTranslation dal_languageTranslation = new DataAccess.DAL_LanguageTranslation())
                {
                    DataAccess.LanguageContent languageContent = new DataAccess.LanguageContent();
                    languageContent.LanguageContent1 = EnglishContent;
                    languageContent.TranslationID = UniqueID;
                    languageContent.ContentTypeID = (int)contentType;
                    dal_languageTranslation.UpdateLanguageTranslation(languageContent, BusinessDTO.ApplicationLanguages.en);

                    languageContent = new DataAccess.LanguageContent();
                    languageContent.TranslationID = UniqueID;
                    languageContent.LanguageContent1 = ArabicContent;
                    languageContent.ContentTypeID = (int)contentType;
                    dal_languageTranslation.UpdateLanguageTranslation(languageContent, BusinessDTO.ApplicationLanguages.ar);
                    return true;
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public static bool DeleteLanguageContent(long UniqueID)
        {
            try
            {
                using (DataAccess.DAL_LanguageTranslation dal_languageTranslation = new DataAccess.DAL_LanguageTranslation())
                {
                    return dal_languageTranslation.DeleteLanguageTranslation(UniqueID);
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
    }
}
