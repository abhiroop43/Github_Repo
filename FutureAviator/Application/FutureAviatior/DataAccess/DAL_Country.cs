using BusinessDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_Country : CoreEntity
    {
        public int AddCountry(DataAccess.Country country)
        {
            try
            {
                Database.Countries.Add(country);
                Database.SaveChanges();
                return country.CountryID;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public bool UpdateCountryByID(int countryID, DataAccess.Country country)
        {
            try
            {
                DataAccess.Country myCountry = Database.Countries.Where(p => p.CountryID == countryID).SingleOrDefault();
                if (myCountry != null)
                {
                    myCountry.UpdateBy = country.UpdateBy;
                    myCountry.UpdateDate = country.UpdateDate;
                    myCountry.IsActive = country.IsActive;
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
       
        public List<DynamicDTO> GetAllActiveCountries(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<DynamicDTO> query = (from c in Database.Countries
                                          join l in Database.LanguageContents on c.CountryNameTranslationID equals l.TranslationID
                                          where l.LanguageCode == lang && c.IsActive == true
                                          select new DynamicDTO
                             {
                                 Value = l.LanguageContent1,
                                 Key = c.CountryID
                             }).ToList();



                return query;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<LocationResult> GetAllCountries()
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.en);
                List<LocationResult> query = (from c in Database.Countries
                                              join CName in Database.LanguageContents on c.CountryNameTranslationID equals CName.TranslationID
                                              where CName.LanguageCode == lang
                                              select new LocationResult
                                          {
                                              CreateDate = c.CreateDate,
                                              IsActive = c.IsActive,
                                              LocationID = c.CountryID,
                                              LocationName = CName.LanguageContent1
                                          }).ToList();
                return query;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public EditLocationResult GetCountryByIDForEditRecord(int LocationID)
        {
            try
            {
                string langEn = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.en);
                string langAr = DBHelper.GetLanguageCodeByEnum(BusinessDTO.ApplicationLanguages.ar);

                EditLocationResult locationResult = new EditLocationResult();
                
                LocationResult locationEnglish = (from c in Database.Countries
                                                  join CName in Database.LanguageContents on c.CountryNameTranslationID equals CName.TranslationID
                                                  where CName.LanguageCode == langEn && c.CountryID == LocationID
                                                  select new LocationResult
                                                  {
                                                      CreateDate = c.CreateDate,
                                                      IsActive = c.IsActive,
                                                      LocationID = c.CountryID,
                                                      LocationName = CName.LanguageContent1,
                                                     LocationNameTranslationID = CName.TranslationID
                                                  }).SingleOrDefault();


                LocationResult locationArabic = (from c in Database.Countries
                                                  join CName in Database.LanguageContents on c.CountryNameTranslationID equals CName.TranslationID
                                                 where CName.LanguageCode == langAr && c.CountryID == LocationID
                                                  select new LocationResult
                                                  {
                                                      CreateDate = c.CreateDate,
                                                      IsActive = c.IsActive,
                                                      LocationID = c.CountryID,
                                                      LocationName = CName.LanguageContent1,
                                                      LocationNameTranslationID = CName.TranslationID
                                                  }).SingleOrDefault();


                locationResult.CreateDate = locationEnglish.CreateDate;
                locationResult.IsActive = locationEnglish.IsActive;
                locationResult.LocationID = locationEnglish.LocationID;
                locationResult.LocationNameTranslationID = locationEnglish.LocationNameTranslationID;


                locationResult.LocationNameEnglish = locationEnglish.LocationName;
                locationResult.LocationNameArabic = locationArabic.LocationName;

                return locationResult;
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
