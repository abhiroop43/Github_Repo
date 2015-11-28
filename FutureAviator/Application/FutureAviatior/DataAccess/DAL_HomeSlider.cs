using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_HomeSlider : CoreEntity
    {
        public long AddHomeSlide(HomeSlider homeSlider)
        {
            try
            {
                Database.HomeSliders.Add(homeSlider);
                Database.SaveChanges();
                return homeSlider.HomeSliderID;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public bool DeleteHomeSlideByID(long HomeSlideID)
        {
            try
            {
                HomeSlider mySlide = new HomeSlider();
                mySlide = Database.HomeSliders.Where(p => p.HomeSliderID == HomeSlideID).SingleOrDefault();
                if (mySlide != null)
                {
                    Database.HomeSliders.Remove(mySlide);
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
        public bool UpdateHomeSlide(HomeSlider homeSlider, long HomeSlideID)
        {
            try
            {
                HomeSlider mySlide = new HomeSlider();
                mySlide = Database.HomeSliders.Where(p => p.HomeSliderID == HomeSlideID).SingleOrDefault();
                if (mySlide != null)
                {
                    mySlide.IsActive = homeSlider.IsActive;
                    mySlide.SliderImage = homeSlider.SliderImage;
                    mySlide.UpdateBy = homeSlider.UpdateBy;
                    mySlide.UpdateDate = homeSlider.UpdateDate;
                    mySlide.URL = homeSlider.URL;
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

        public List<SliderResult> GetAllActiveHomeSlides(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);


                List<SliderResult> sliderResult = new List<SliderResult>();
                sliderResult = (from hs in Database.HomeSliders
                                join lng_SliderTitle in Database.LanguageContents on hs.SliderTitleTranslationID equals lng_SliderTitle.TranslationID
                                join lng_SliderSubTitle in Database.LanguageContents on hs.SliderSubTitleTranslationID equals lng_SliderSubTitle.TranslationID
                                join lng_SliderButtonText in Database.LanguageContents on hs.ButtonTextTranslationID equals lng_SliderButtonText.TranslationID
                                where hs.IsActive == true && lng_SliderTitle.LanguageCode == lang && lng_SliderButtonText.LanguageCode == lang && lng_SliderSubTitle.LanguageCode == lang
                                select new SliderResult
                                {
                                    ButtonText = lng_SliderButtonText.LanguageContent1,
                                    ButtonTextTransaltionID = lng_SliderButtonText.TranslationID,
                                    ImagePath = hs.SliderImage,
                                    SliderID = hs.HomeSliderID,
                                    SubTitle = lng_SliderSubTitle.LanguageContent1,
                                    SubTitleTranlationID = lng_SliderSubTitle.TranslationID,
                                    Title = lng_SliderTitle.LanguageContent1,
                                    TitleTranslationID = lng_SliderTitle.TranslationID,
                                    ButtonLink = hs.URL
                                }).ToList();

                return sliderResult;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<SliderResult> GetAllHomeSlides()
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.en);

                List<SliderResult> sliderResult = new List<SliderResult>();
                sliderResult = (from hs in Database.HomeSliders
                                join lng_SliderTitle in Database.LanguageContents on hs.SliderTitleTranslationID equals lng_SliderTitle.TranslationID
                                join lng_SliderSubTitle in Database.LanguageContents on hs.SliderSubTitleTranslationID equals lng_SliderSubTitle.TranslationID
                                join lng_SliderButtonText in Database.LanguageContents on hs.ButtonTextTranslationID equals lng_SliderButtonText.TranslationID
                                where lng_SliderTitle.LanguageCode == lang && lng_SliderButtonText.LanguageCode == lang && lng_SliderSubTitle.LanguageCode == lang
                                select new SliderResult
                                {
                                    ButtonText = lng_SliderButtonText.LanguageContent1,
                                    ButtonTextTransaltionID = lng_SliderButtonText.TranslationID,
                                    ImagePath = hs.SliderImage,
                                    SliderID = hs.HomeSliderID,
                                    SubTitle = lng_SliderSubTitle.LanguageContent1,
                                    SubTitleTranlationID = lng_SliderSubTitle.TranslationID,
                                    Title = lng_SliderTitle.LanguageContent1,
                                    TitleTranslationID = lng_SliderTitle.TranslationID,
                                    ButtonLink = hs.URL,
                                    LanguageCode = lng_SliderSubTitle.LanguageCode,
                                    IsActive = hs.IsActive
                                }).ToList();

                return sliderResult;

            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public EditSliderResult GetSlideByID(long SlideID)
        {
            try
            {

                string langen = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.en);
                string langar = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.ar);
                SliderResult sliderResult = new SliderResult();
                EditSliderResult result = new EditSliderResult();

                var ResultEnglish = (from hs in Database.HomeSliders
                                     join lng_SliderTitle in Database.LanguageContents on hs.SliderTitleTranslationID equals lng_SliderTitle.TranslationID
                                     join lng_SliderSubTitle in Database.LanguageContents on hs.SliderSubTitleTranslationID equals lng_SliderSubTitle.TranslationID
                                     join lng_SliderButtonText in Database.LanguageContents on hs.ButtonTextTranslationID equals lng_SliderButtonText.TranslationID
                                     where lng_SliderTitle.LanguageCode == langen && lng_SliderButtonText.LanguageCode == langen && lng_SliderSubTitle.LanguageCode == langen
                                     && hs.HomeSliderID == SlideID
                                     select new SliderResult
                                     {
                                         ButtonText = lng_SliderButtonText.LanguageContent1,
                                         ButtonTextTransaltionID = lng_SliderButtonText.TranslationID,
                                         ImagePath = hs.SliderImage,
                                         SliderID = hs.HomeSliderID,
                                         SubTitle = lng_SliderSubTitle.LanguageContent1,
                                         SubTitleTranlationID = lng_SliderSubTitle.TranslationID,
                                         Title = lng_SliderTitle.LanguageContent1,
                                         TitleTranslationID = lng_SliderTitle.TranslationID,
                                         ButtonLink = hs.URL,
                                         LanguageCode = lng_SliderSubTitle.LanguageCode,
                                         IsActive = hs.IsActive
                                     }).SingleOrDefault();



                var ResultArabic = (from hs in Database.HomeSliders
                                    join lng_SliderTitle in Database.LanguageContents on hs.SliderTitleTranslationID equals lng_SliderTitle.TranslationID
                                    join lng_SliderSubTitle in Database.LanguageContents on hs.SliderSubTitleTranslationID equals lng_SliderSubTitle.TranslationID
                                    join lng_SliderButtonText in Database.LanguageContents on hs.ButtonTextTranslationID equals lng_SliderButtonText.TranslationID
                                    where lng_SliderTitle.LanguageCode == langar && lng_SliderButtonText.LanguageCode == langar && lng_SliderSubTitle.LanguageCode == langar
                                     && hs.HomeSliderID == SlideID
                                    select new SliderResult
                                    {
                                        ButtonText = lng_SliderButtonText.LanguageContent1,
                                        ButtonTextTransaltionID = lng_SliderButtonText.TranslationID,
                                        ImagePath = hs.SliderImage,
                                        SliderID = hs.HomeSliderID,
                                        SubTitle = lng_SliderSubTitle.LanguageContent1,
                                        SubTitleTranlationID = lng_SliderSubTitle.TranslationID,
                                        Title = lng_SliderTitle.LanguageContent1,
                                        TitleTranslationID = lng_SliderTitle.TranslationID,
                                        ButtonLink = hs.URL,
                                        LanguageCode = lng_SliderSubTitle.LanguageCode,
                                        IsActive = hs.IsActive
                                    }).SingleOrDefault();

                //Common Data
                result.ButtonLink = ResultEnglish.ButtonLink;
                result.SliderID = ResultEnglish.SliderID;
                result.TitleTranslationID = ResultEnglish.TitleTranslationID;
                result.SubTitleTranlationID = ResultEnglish.SubTitleTranlationID;
                result.ButtonTextTransaltionID = ResultEnglish.ButtonTextTransaltionID;
                result.ImagePath = ResultEnglish.ImagePath;
                result.IsActive = ResultEnglish.IsActive;

                //Arabic
                result.ButtonTextArabic = ResultArabic.ButtonText;
                result.TitleArabic = ResultArabic.Title;
                result.SubTitleArabic = ResultArabic.SubTitle;
                //English
                result.ButtonTextEnglish = ResultEnglish.ButtonText;
                result.TitleEnglish = ResultEnglish.Title;
                result.SubTitleEnglish = ResultEnglish.SubTitle;





                return result;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
