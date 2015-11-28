using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BusinessDTO;
using System.Data.Entity;

namespace DataAccess
{
    public class DAL_CustomerStory : CoreEntity
    {
        public int AddCustomerStory(CustomerStory customerDetails)
        {
            try
            {
                Database.CustomerStories.Add(customerDetails);
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }

        public List<CustStoryResult> GetAllStories(BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<CustStoryResult> custStories = (from cs in Database.CustomerStories
                                                     join lCustName in Database.LanguageContents on cs.CustName equals lCustName.TranslationID
                                                     join lCustDesignation in Database.LanguageContents on cs.Designation equals lCustDesignation.TranslationID
                                                     join lStoryContent in Database.LanguageContents on cs.StoryContent equals lStoryContent.TranslationID
                                                     where (lCustName.ContentTypeID == (int)LanguageContentType.StoryCustName || lCustDesignation.ContentTypeID == (int)LanguageContentType.StoryCustDesignation || lStoryContent.ContentTypeID == (int)LanguageContentType.StoryContent)
                                          && (lCustName.LanguageCode == lang && lCustDesignation.LanguageCode == lang && lStoryContent.LanguageCode == lang)
                                          && cs.Status == "A"
                                                     select new CustStoryResult
                                                     {
                                                         StoryID = cs.ID,
                                                         Status = cs.Status,
                                                         StoryContent = lStoryContent.LanguageContent1,
                                                         CustName = lCustName.LanguageContent1,
                                                         Designation = lCustDesignation.LanguageContent1,
                                                         CustPicture = cs.CustPicture
                                                     }).GroupBy(x=>x.StoryID).Select(group=>group.FirstOrDefault()).ToList();
                return custStories;
                //return Database.CustomerStories.Where(i => i.Status == "A");
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public List<CustStoryResult> GetCustStory(int StoryID, BusinessDTO.ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<CustStoryResult> custStories = (from cs in Database.CustomerStories
                                          join lCustName in Database.LanguageContents on cs.CustName equals lCustName.TranslationID
                                          join lCustDesignation in Database.LanguageContents on cs.Designation equals lCustDesignation.TranslationID
                                          join lStoryContent in Database.LanguageContents on cs.StoryContent equals lStoryContent.TranslationID
                                          where (lCustName.ContentTypeID == (int)LanguageContentType.StoryCustName || lCustDesignation.ContentTypeID == (int)LanguageContentType.StoryCustDesignation || lStoryContent.ContentTypeID == (int)LanguageContentType.StoryContent)
                                          && (lCustName.LanguageCode == lang && lCustDesignation.LanguageCode == lang && lStoryContent.LanguageCode == lang)
                                          && cs.ID == StoryID && cs.Status == "A"
                                          select new CustStoryResult
                                          {
                                              StoryID=cs.ID,
                                              Status=cs.Status,
                                              StoryContent=lStoryContent.LanguageContent1,
                                              CustName=lCustName.LanguageContent1,
                                              Designation=lCustDesignation.LanguageContent1,
                                              CustPicture=cs.CustPicture
                                          }).GroupBy(x => x.StoryID).Select(group => group.FirstOrDefault()).ToList();
                return custStories;
                //return Database.CustomerStories.Where(i => i.Status == "A" && i.ID == StoryID);
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public int EditCustStory(int StoryID, long UserID, string EnglishName, string ArabicName, string EnglishDes, string ArabicDes, string EnglishStory, string ArabicStory, byte[] pic)
        {
            //update existing story//
            CustomerStory cs = Database.CustomerStories.Find(StoryID);
            if(cs == null)
            {
                return 0;
            }
            cs.UpdateDate = DateTime.Today;
            cs.UpdateBy = UserID;
            cs.Status = "A";
            if (pic != null && pic.Length > 0)
            {
                cs.CustPicture = pic;
            }
            //customer name//
            long StoryCustNameTrsID = DBHelper.GetUniqueID();
            cs.CustName = StoryCustNameTrsID;
            DBHelper.AddLanguageContent(StoryCustNameTrsID, EnglishName, ArabicName, BusinessDTO.LanguageContentType.StoryCustName);

            //newCust.StoryContent = SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? fbtxtEnglishStoryContent.Text.Trim() : fbtxtArabicStoryContent.Text.Trim();

            //customer designation//
            long StoryCustDesignationTrsID = DBHelper.GetUniqueID();
            cs.Designation = StoryCustDesignationTrsID;
            DBHelper.AddLanguageContent(StoryCustDesignationTrsID, EnglishDes, ArabicDes, BusinessDTO.LanguageContentType.StoryCustDesignation);

            //customer story content//
            long StoryContentTrsID = DBHelper.GetUniqueID();
            cs.StoryContent = StoryContentTrsID;
            DBHelper.AddLanguageContent(StoryContentTrsID, EnglishStory, ArabicStory, BusinessDTO.LanguageContentType.StoryContent);


            Database.Entry(cs).State = EntityState.Modified;
            return Database.SaveChanges();
        }

        public int DeleteStory(int StoryID, long UserID)
        {
            try
            {
                CustomerStory cs = Database.CustomerStories.Find(StoryID);
                if (cs == null)
                {
                    return 0;
                }

                cs.Status = "D";
                cs.DeletedOn = DateTime.Today;
                cs.DeletedBy = UserID;

                Database.Entry(cs).State = EntityState.Modified;
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
