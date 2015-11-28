using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ExceptionLogger;
using BusinessDTO;

namespace DataAccess
{
    public class DAL_ImageBoxContent : CoreEntity
    {
        public int AddImageContentBox(ImageContentBox imageContentBox)
        {
            try
            {
                Database.ImageContentBoxes.Add(imageContentBox);
                Database.SaveChanges();
                return imageContentBox.ImageContentBoxID;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public bool UpdateImageContentBox(ImageContentBox imageContentBox)
        {
            try
            {
                ImageContentBox myContentBox = Database.ImageContentBoxes.Where(p => p.ImageContentBoxID == imageContentBox.ImageContentBoxID).SingleOrDefault();
                if (myContentBox != null)
                {
                    myContentBox.IsActive = imageContentBox.IsActive;
                    myContentBox.ImagePath = imageContentBox.ImagePath;
                    myContentBox.LinkURL = imageContentBox.LinkURL;
                    myContentBox.UpdateBy = imageContentBox.UpdateBy;
                    myContentBox.UpdateDate = imageContentBox.UpdateDate;
                    Database.SaveChanges();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return false;
            }
        }

        public bool DeleteImageContentBox(int ImageContentBoxID)
        {
            try
            {
                ImageContentBox myContentBox = Database.ImageContentBoxes.Where(p => p.ImageContentBoxID == ImageContentBoxID).SingleOrDefault();
                if (myContentBox != null)
                {
                    Database.ImageContentBoxes.Remove(myContentBox);
                    Database.SaveChanges();
                    return true;
                }
                else
                    return false;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return false;
            }
        }


        public List<ImageContentBoxResult> GetAllImageContentBoxesByTypeID(int ImageContentBoxTypeID, ApplicationLanguages appLanguage, bool IgnoreActive = true)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                 
                List<ImageContentBoxResult> query = (from icb in Database.ImageContentBoxes
                                                     join lcTitle in Database.LanguageContents on icb.TitleTranslationID equals lcTitle.TranslationID
                                                     join lcDescription in Database.LanguageContents on icb.DescriptionTranslatioonID equals lcDescription.TranslationID
                                                     where lcTitle.LanguageCode == lang && lcDescription.LanguageCode == lang 
                                                     && icb.ImageContentBoxTypeID == ImageContentBoxTypeID
                                                     select new ImageContentBoxResult
                                                     {
                                                         CreateBy = icb.CreateBy,
                                                         CreateDate = icb.CreateDate,
                                                         Description = lcDescription.LanguageContent1,
                                                         DescriptionTranslationID = icb.DescriptionTranslatioonID,
                                                         ImageContentBoxID = icb.ImageContentBoxID,
                                                         ImageContentBoxTypeID = icb.ImageContentBoxTypeID,
                                                         ImagePath = icb.ImagePath,
                                                         IsActive = icb.IsActive,
                                                         LinkURL = icb.LinkURL,
                                                         Title = lcTitle.LanguageContent1,
                                                         TitleTranslationID = icb.TitleTranslationID,
                                                         UpdateBy = icb.UpdateBy,
                                                         UpdateDate = icb.UpdateDate,

                                                     }).ToList();

                if (!IgnoreActive)
                    query = query.Where(p => p.IsActive == true).ToList();
                

                return query;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public ImageContentBoxResult GetImageContentBoxByIDAndTypeID(int ImageContentBoxID, int ImageContentBoxTypeID, ApplicationLanguages appLanguage, bool IgnoreActive = true)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                ImageContentBoxResult result = new ImageContentBoxResult();
                var query = (from icb in Database.ImageContentBoxes
                                               join lcTitle in Database.LanguageContents on icb.TitleTranslationID equals lcTitle.TranslationID
                                               join lcDescription in Database.LanguageContents on icb.DescriptionTranslatioonID equals lcDescription.TranslationID
                                               where lcTitle.LanguageCode == lang && lcDescription.LanguageCode == lang
                                               && icb.ImageContentBoxTypeID == ImageContentBoxTypeID && icb.ImageContentBoxID == ImageContentBoxID
                                               select new ImageContentBoxResult
                                  {
                                      CreateBy = icb.CreateBy,
                                      CreateDate = icb.CreateDate,
                                      Description = lcDescription.LanguageContent1,
                                      DescriptionTranslationID = icb.DescriptionTranslatioonID,
                                      ImageContentBoxID = ImageContentBoxID,
                                      ImageContentBoxTypeID = icb.ImageContentBoxTypeID,
                                      ImagePath = icb.ImagePath,
                                      IsActive = icb.IsActive,
                                      LinkURL = icb.LinkURL,
                                      Title = lcTitle.LanguageContent1,
                                      TitleTranslationID = icb.TitleTranslationID,
                                      UpdateBy = icb.UpdateBy,
                                      UpdateDate = icb.UpdateDate,

                                  }).AsQueryable();

                if (!IgnoreActive)
                    result = query.Where(p => p.IsActive == true).SingleOrDefault();
                else
                    result = query.SingleOrDefault();
                return result;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return null;
            }
        }


        public EditImageContentBoxResult GetImageContentBoxByIDAndTypeIDForEdit(int ImageContentBoxID, int ImageContentBoxTypeID)
        {
            try
            {
                EditImageContentBoxResult result = new EditImageContentBoxResult();
                ImageContentBoxResult queryEnglish = GetImageContentBoxByIDAndTypeID(ImageContentBoxID, ImageContentBoxTypeID, ApplicationLanguages.en);
                ImageContentBoxResult queryArabic = GetImageContentBoxByIDAndTypeID(ImageContentBoxID, ImageContentBoxTypeID, ApplicationLanguages.ar);
                if (queryEnglish != null && queryArabic != null)
                {
                    //Common
                    result.CreateBy = queryEnglish.CreateBy;
                    result.CreateDate = queryEnglish.CreateDate;
                    result.DescriptionTranslationID = queryEnglish.DescriptionTranslationID;
                    result.ImageContentBoxID = queryEnglish.ImageContentBoxID;
                    result.ImageContentBoxTypeID = queryEnglish.ImageContentBoxTypeID;
                    result.ImagePath = queryEnglish.ImagePath;
                    result.IsActive = queryEnglish.IsActive;
                    result.LinkURL = queryEnglish.LinkURL;
                    result.TitleTranslationID = queryEnglish.TitleTranslationID;

                    //Set English
                    result.TitleEnglish = queryEnglish.Title;
                    result.DescriptionEnglish = queryEnglish.Description;

                    // Set Arabic
                    result.TitleArabic = queryArabic.Title;
                    result.DescriptionArabic = queryArabic.Description;

                    return result;
                }
                else
                    return null;

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
