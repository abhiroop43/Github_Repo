using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_News : CoreEntity
    {
        public long AddNews(News news)
        {
            try
            {
                Database.News.Add(news);
                Database.SaveChanges();
                return news.NewsID;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public bool DeleteNewsByID(long NewsID)
        {
            try
            {

                News Mynews = Database.News.Where(p => p.NewsID == NewsID).SingleOrDefault();
                if (Mynews != null)
                {
                    Database.News.Remove(Mynews);
                    Database.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }



            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }
        public bool UpdateNewsByID(long NewsID, News news)
        {
            try
            {

                News Mynews = Database.News.Where(p => p.NewsID == NewsID).SingleOrDefault();
                if (Mynews != null)
                {
                    Mynews.IsActive = news.IsActive;
                    Mynews.UpdateBy = news.UpdateBy;
                    Mynews.UpdateDate = news.UpdateDate;
                    Mynews.ImagePath = news.ImagePath;
                    Mynews.PressReleaseDate = news.PressReleaseDate;
                    Database.SaveChanges();
                    return true;
                }
                else
                {
                    return false;
                }



            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return false;
            }
        }


        public NewsResult GetNewsByID(BusinessDTO.ApplicationLanguages appLanguage, long NewsID)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                NewsResult news = (from n in Database.News
                                   join lng_NewsTitle in Database.LanguageContents on n.NewsTitleTranslationID equals lng_NewsTitle.TranslationID
                                   join lng_NewsDescription in Database.LanguageContents on n.NewsDescriptionTranslationID equals lng_NewsDescription.TranslationID
                                   where n.IsActive == true
                                   && lng_NewsTitle.LanguageCode == lang && lng_NewsDescription.LanguageCode == lang
                                   && n.NewsID == NewsID
                                   select new NewsResult
                                   {
                                       NewsID = n.NewsID,
                                       NewsTitle = lng_NewsTitle.LanguageContent1,
                                       NewsDescription = lng_NewsDescription.LanguageContent1,
                                       ImagePath = n.ImagePath,
                                       PressReleaseDate = n.PressReleaseDate
                                   }).SingleOrDefault();

                return news;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public List<NewsResult> GetAllActiveNews(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<NewsResult> newsList = (from n in Database.News
                                             join lng_NewsTitle in Database.LanguageContents on n.NewsTitleTranslationID equals lng_NewsTitle.TranslationID
                                             join lng_NewsDescription in Database.LanguageContents on n.NewsDescriptionTranslationID equals lng_NewsDescription.TranslationID
                                             where n.IsActive == true
                                             && lng_NewsTitle.LanguageCode == lang && lng_NewsDescription.LanguageCode == lang
                                             select new NewsResult
                                             {
                                                 NewsID = n.NewsID,
                                                 NewsTitle = lng_NewsTitle.LanguageContent1,
                                                 NewsDescription = lng_NewsDescription.LanguageContent1,
                                                 ImagePath = n.ImagePath,
                                                 CreateDate = n.CreateDate,
                                                 PressReleaseDate = n.PressReleaseDate
                                             }).ToList();

                return newsList;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<NewsResult> GetAllNews()
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.en);
                List<NewsResult> newsList = (from n in Database.News
                                             join lng_NewsTitle in Database.LanguageContents on n.NewsTitleTranslationID equals lng_NewsTitle.TranslationID
                                             join lng_NewsDescription in Database.LanguageContents on n.NewsDescriptionTranslationID equals lng_NewsDescription.TranslationID
                                             where lng_NewsTitle.LanguageCode == lang && lng_NewsDescription.LanguageCode == lang
                                             select new NewsResult
                                             {
                                                 NewsID = n.NewsID,
                                                 NewsTitle = lng_NewsTitle.LanguageContent1,
                                                 NewsDescription = lng_NewsDescription.LanguageContent1,
                                                 IsActive = n.IsActive,
                                                 CreateDate = n.CreateDate,
                                                 ImagePath = n.ImagePath,
                                                 PressReleaseDate = n.PressReleaseDate
                                             }).ToList();

                return newsList;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public EditNewsResult GetNewsByID(long NewsID)
        {
            try
            {
                string langEn = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.en);
                string langAr = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.ar);
                EditNewsResult newsResult = new EditNewsResult();
                NewsResult newsEnglish = (from n in Database.News
                                          join lng_NewsTitle in Database.LanguageContents on n.NewsTitleTranslationID equals lng_NewsTitle.TranslationID
                                          join lng_NewsDescription in Database.LanguageContents on n.NewsDescriptionTranslationID equals lng_NewsDescription.TranslationID
                                          where lng_NewsTitle.LanguageCode == langEn && lng_NewsDescription.LanguageCode == langEn
                                          && n.NewsID == NewsID
                                          select new NewsResult
                                          {
                                              NewsID = n.NewsID,
                                              NewsTitle = lng_NewsTitle.LanguageContent1,
                                              NewsDescription = lng_NewsDescription.LanguageContent1,
                                              NewsTitleTranslationID = n.NewsTitleTranslationID,
                                              NewsDescriptionTranslationID = n.NewsDescriptionTranslationID,
                                              IsActive = n.IsActive,
                                              ImagePath = n.ImagePath,
                                              PressReleaseDate = n.PressReleaseDate

                                          }).SingleOrDefault();


                NewsResult newsArabic = (from n in Database.News
                                         join lng_NewsTitle in Database.LanguageContents on n.NewsTitleTranslationID equals lng_NewsTitle.TranslationID
                                         join lng_NewsDescription in Database.LanguageContents on n.NewsDescriptionTranslationID equals lng_NewsDescription.TranslationID
                                         where lng_NewsTitle.LanguageCode == langAr && lng_NewsDescription.LanguageCode == langAr
                                         && n.NewsID == NewsID
                                         select new NewsResult
                                         {
                                             NewsID = n.NewsID,
                                             NewsTitle = lng_NewsTitle.LanguageContent1,
                                             NewsDescription = lng_NewsDescription.LanguageContent1,
                                             NewsTitleTranslationID = n.NewsTitleTranslationID,
                                             NewsDescriptionTranslationID = n.NewsDescriptionTranslationID,
                                             IsActive = n.IsActive,
                                             ImagePath = n.ImagePath,
                                             PressReleaseDate = n.PressReleaseDate
                                         }).SingleOrDefault();


                //Set Common Fields
                newsResult.NewsID = newsEnglish.NewsID;
                newsResult.NewsTitleTranslationID = newsEnglish.NewsTitleTranslationID;
                newsResult.NewsDescriptionTranslationID = newsEnglish.NewsDescriptionTranslationID;
                newsResult.IsActive = newsEnglish.IsActive;
                newsResult.ImagePath = newsEnglish.ImagePath;
                newsResult.PressReleaseDate = newsEnglish.PressReleaseDate;

                //Set English
                newsResult.NewsTitleEnglish = newsEnglish.NewsTitle;
                newsResult.NewsDescriptionEnglish = newsEnglish.NewsDescription;

                //Set Arabic
                newsResult.NewsTitleArabic = newsArabic.NewsTitle;
                newsResult.NewsDescriptionArabic = newsArabic.NewsDescription;
                return newsResult;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

    }
}
