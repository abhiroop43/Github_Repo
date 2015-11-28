using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_PhotoGalleryCategory : CoreEntity
    {
        public int AddPhotoGalleryCategory(PhotoGalleryCategory GalleryCategory)
        {
            try
            {
                Database.PhotoGalleryCategories.Add(GalleryCategory);
                Database.SaveChanges();
                return GalleryCategory.PhotoGalleryCategoryID;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public bool DeletePhotoGalleryCategory(int GalleryCategoryID)
        {
            try
            {
                PhotoGalleryCategory myCategory = Database.PhotoGalleryCategories.Where(p => p.PhotoGalleryCategoryID == GalleryCategoryID).SingleOrDefault();
                if (myCategory != null)
                {
                    Database.PhotoGalleryCategories.Remove(myCategory);
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
        public bool UpdatePhotoGalleryCategory(int GalleryCategoryID, PhotoGalleryCategory GalleryCategory)
        {
            try
            {
                PhotoGalleryCategory myCategory = Database.PhotoGalleryCategories.Where(p => p.PhotoGalleryCategoryID == GalleryCategoryID).SingleOrDefault();
                if (myCategory != null)
                {
                    myCategory.IsActive = GalleryCategory.IsActive;
                    myCategory.UpdateBy = GalleryCategory.UpdateBy;
                    myCategory.UpdateDate = GalleryCategory.UpdateDate;
                    myCategory.CategoryImage = GalleryCategory.CategoryImage;
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
        public List<GalleryCategoryResult> GetAllActivePhotoGalleryCategories(ApplicationLanguages appLanguage, LanguageContentType languageContentType)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<GalleryCategoryResult> query = (from pgc in Database.PhotoGalleryCategories
                                                     join lng_CategoryTitle in Database.LanguageContents on pgc.CategoryTitleTranslationID equals lng_CategoryTitle.TranslationID
                                                     join lng_CategoryDescription in Database.LanguageContents on pgc.CategoryDescriptionTranslationID equals lng_CategoryDescription.TranslationID
                                                     where (lng_CategoryTitle.LanguageCode == lang && lng_CategoryDescription.LanguageCode == lang) && pgc.IsActive == true
                                                     select new GalleryCategoryResult
                                                     {
                                                         CategoryDescription = lng_CategoryDescription.LanguageContent1,
                                                         CategoryDescriptionTranslationID = pgc.CategoryDescriptionTranslationID,
                                                         CategoryImage = pgc.CategoryImage,
                                                         CategoryTitle = lng_CategoryTitle.LanguageContent1,
                                                         CategoryTitleTranslationID = pgc.CategoryTitleTranslationID,
                                                         CreateDate = pgc.CreateDate,
                                                         PhotoGalleryCategoryID = pgc.PhotoGalleryCategoryID
                                                     }).ToList();

                return query;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<GalleryCategoryResult> GetAllPhotoGalleryCategories()
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.en);

                List<GalleryCategoryResult> query = (from pgc in Database.PhotoGalleryCategories
                                                     join lng_CategoryTitle in Database.LanguageContents on pgc.CategoryTitleTranslationID equals lng_CategoryTitle.TranslationID
                                                     join lng_CategoryDescription in Database.LanguageContents on pgc.CategoryDescriptionTranslationID equals lng_CategoryDescription.TranslationID
                                                     where (lng_CategoryTitle.LanguageCode == lang && lng_CategoryDescription.LanguageCode == lang)
                                                     select new GalleryCategoryResult
                                                     {
                                                         CategoryDescription = lng_CategoryDescription.LanguageContent1,
                                                         CategoryDescriptionTranslationID = pgc.CategoryDescriptionTranslationID,
                                                         CategoryImage = pgc.CategoryImage,
                                                         CategoryTitle = lng_CategoryTitle.LanguageContent1,
                                                         CategoryTitleTranslationID = pgc.CategoryTitleTranslationID,
                                                         CreateDate = pgc.CreateDate,
                                                         PhotoGalleryCategoryID = pgc.PhotoGalleryCategoryID,
                                                         IsActive = pgc.IsActive
                                                     }).ToList();

                return query;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public PhotoGalleryCategory GetPhotoGalleryCategoryByID(int PhotoGalleryCategoryID)
        {
            try
            {
                return Database.PhotoGalleryCategories.Where(p => p.PhotoGalleryCategoryID == PhotoGalleryCategoryID).SingleOrDefault();
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public EditGalleryCategoryResult GetPhotoGalleryCategoryByIDForUpdate(int PhotoGalleryCategoryID)
        {
            try
            {
                string langEn = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.en);
                string langAr = DBHelper.GetLanguageCodeByEnum(ApplicationLanguages.ar);
                EditGalleryCategoryResult galleryResult = new EditGalleryCategoryResult();

                GalleryCategoryResult CategoryEnglish = (from pgc in Database.PhotoGalleryCategories
                                                         join lng_CategoryTitle in Database.LanguageContents on pgc.CategoryTitleTranslationID equals lng_CategoryTitle.TranslationID
                                                         join lng_CategoryDescription in Database.LanguageContents on pgc.CategoryDescriptionTranslationID equals lng_CategoryDescription.TranslationID
                                                         where (lng_CategoryTitle.LanguageCode == langEn && lng_CategoryDescription.LanguageCode == langEn) && pgc.PhotoGalleryCategoryID == PhotoGalleryCategoryID
                                                         select new GalleryCategoryResult
                                                         {
                                                             CategoryDescription = lng_CategoryDescription.LanguageContent1,
                                                             CategoryDescriptionTranslationID = pgc.CategoryDescriptionTranslationID,
                                                             CategoryImage = pgc.CategoryImage,
                                                             CategoryTitle = lng_CategoryTitle.LanguageContent1,
                                                             CategoryTitleTranslationID = pgc.CategoryTitleTranslationID,
                                                             CreateDate = pgc.CreateDate,
                                                             PhotoGalleryCategoryID = pgc.PhotoGalleryCategoryID,
                                                             IsActive = pgc.IsActive
                                                         }).SingleOrDefault();

                GalleryCategoryResult CategoryArabic = (from pgc in Database.PhotoGalleryCategories
                                                        join lng_CategoryTitle in Database.LanguageContents on pgc.CategoryTitleTranslationID equals lng_CategoryTitle.TranslationID
                                                        join lng_CategoryDescription in Database.LanguageContents on pgc.CategoryDescriptionTranslationID equals lng_CategoryDescription.TranslationID
                                                        where (lng_CategoryTitle.LanguageCode == langAr && lng_CategoryDescription.LanguageCode == langAr) && pgc.PhotoGalleryCategoryID == PhotoGalleryCategoryID
                                                        select new GalleryCategoryResult
                                                        {
                                                            CategoryDescription = lng_CategoryDescription.LanguageContent1,
                                                            CategoryDescriptionTranslationID = pgc.CategoryDescriptionTranslationID,
                                                            CategoryImage = pgc.CategoryImage,
                                                            CategoryTitle = lng_CategoryTitle.LanguageContent1,
                                                            CategoryTitleTranslationID = pgc.CategoryTitleTranslationID,
                                                            CreateDate = pgc.CreateDate,
                                                            PhotoGalleryCategoryID = pgc.PhotoGalleryCategoryID,
                                                            IsActive = pgc.IsActive
                                                        }).SingleOrDefault();


                //Set Arabic
                galleryResult.CategoryDescriptionArabic = CategoryArabic.CategoryDescription;
                galleryResult.CategoryTitleArabic = CategoryArabic.CategoryTitle;

                //Set English
                galleryResult.CategoryDescriptionEnglish = CategoryEnglish.CategoryDescription;
                galleryResult.CategoryTitleEnglish = CategoryEnglish.CategoryTitle;

                //Set Common
                galleryResult.CategoryDescriptionTranslationID = CategoryEnglish.CategoryDescriptionTranslationID;
                galleryResult.CategoryTitleTranslationID = CategoryEnglish.CategoryTitleTranslationID;
                galleryResult.CreateDate = CategoryEnglish.CreateDate;
                galleryResult.IsActive = CategoryEnglish.IsActive;
                galleryResult.PhotoGalleryCategoryID = CategoryEnglish.PhotoGalleryCategoryID;
                galleryResult.CategoryImage = CategoryEnglish.CategoryImage;

                return galleryResult;
            }
            catch (Exception ex)
            {

                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
