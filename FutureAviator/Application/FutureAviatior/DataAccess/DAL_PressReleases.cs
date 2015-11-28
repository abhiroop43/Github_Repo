using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BusinessDTO;
using System.Data.Entity;

namespace DataAccess
{
    public class DAL_PressReleases : CoreEntity
    {
        public List<PressReleaseResult> GetAllPressReleases(ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<PressReleaseResult> pressReleases = (from pr in Database.PressReleases
                                                          join RlsHeader in Database.LanguageContents on pr.Header equals RlsHeader.TranslationID
                                                          join RlsContent in Database.LanguageContents on pr.PressRlsContent equals RlsContent.TranslationID
                                                          where (RlsHeader.ContentTypeID == (int)LanguageContentType.PressReleaseHeader || RlsContent.ContentTypeID == (int)LanguageContentType.PressReleaseContent)
                                               && (RlsHeader.LanguageCode == lang && RlsContent.LanguageCode == lang)
                                               && pr.IsActive == true
                                                          select new PressReleaseResult
                                                          {
                                                              ID = pr.ID,
                                                              IsActive = pr.IsActive,
                                                              Header = RlsHeader.LanguageContent1,
                                                              PressReleaseContent = RlsContent.LanguageContent1,
                                                              PressReleaseDate = pr.PressRlsDate,
                                                              ImagePath = pr.ImagePath
                                                          }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList(); ;

                return pressReleases;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<PressReleaseResult> GetAllPressReleases(ApplicationLanguages appLanguage, int PressRlsID)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<PressReleaseResult> pressReleases = (from pr in Database.PressReleases
                                                          join RlsHeader in Database.LanguageContents on pr.Header equals RlsHeader.TranslationID
                                                          join RlsContent in Database.LanguageContents on pr.PressRlsContent equals RlsContent.TranslationID
                                                          where (RlsHeader.ContentTypeID == (int)LanguageContentType.PressReleaseHeader || RlsContent.ContentTypeID == (int)LanguageContentType.PressReleaseContent)
                                               && (RlsHeader.LanguageCode == lang && RlsContent.LanguageCode == lang)
                                               && pr.IsActive == true && pr.ID == PressRlsID
                                                          select new PressReleaseResult
                                                          {
                                                              ID = pr.ID,
                                                              IsActive = pr.IsActive,
                                                              Header = RlsHeader.LanguageContent1,
                                                              PressReleaseContent = RlsContent.LanguageContent1,
                                                              PressReleaseDate = pr.PressRlsDate,
                                                              ImagePath = pr.ImagePath
                                                          }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList(); ;

                return pressReleases;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public int AddPressRelease(PressReleas newPressRelease)
        {
            try
            {
                Database.PressReleases.Add(newPressRelease);
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public int EditPressRelease(int ID, long UserID, string EnglishHeader, string ArabicHeader, string EnglishContent, string ArabicContent, string ReleaseDate, string ImageFileName)
        {
            //update existing story//
            PressReleas pr = Database.PressReleases.Find(ID);
            if (pr == null)
            {
                return 0;
            }
            pr.UpdateDate = DateTime.Today;
            pr.UpdateBy = UserID;
            pr.IsActive = true;
            if (ImageFileName != "")
            {
                pr.ImagePath = ImageFileName;
            }
            //Press Release Header//
            long HeaderTrsID = DBHelper.GetUniqueID();
            pr.Header = HeaderTrsID;
            DBHelper.AddLanguageContent(HeaderTrsID, EnglishHeader, ArabicHeader, BusinessDTO.LanguageContentType.StoryCustName);

            //Press Release Content//
            long ContentTrsID = DBHelper.GetUniqueID();
            pr.PressRlsContent = ContentTrsID;
            DBHelper.AddLanguageContent(ContentTrsID, EnglishContent, ArabicContent, BusinessDTO.LanguageContentType.StoryCustDesignation);

            Database.Entry(pr).State = EntityState.Modified;
            return Database.SaveChanges();
        }

        public int DeletePressRelease(int ID, long UserID)
        {
            try
            {
                PressReleas pr = Database.PressReleases.Find(ID);
                if (pr == null)
                {
                    return 0;
                }

                pr.IsActive = false;
                pr.DeleteDate = DateTime.Today;
                pr.DeleteBy = UserID;

                Database.Entry(pr).State = EntityState.Modified;
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
    }
}
