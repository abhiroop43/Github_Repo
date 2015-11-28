using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BusinessDTO;

namespace DataAccess
{
    public class DAL_PrivacyPolicy : CoreEntity
    {
        public List<PrivacyPolicyResult> GetPrivacyPolicy(ApplicationLanguages appLanguage)
        {
            try
            {
                string lang = DBHelper.GetLanguageCodeByEnum(appLanguage);
                List<PrivacyPolicyResult> privacyPolicy = (from priv in Database.PrivacyPolicies
                                                      join lSectionName in Database.LanguageContents on priv.PolicyTranslationID equals lSectionName.TranslationID                  where (lSectionName.ContentTypeID == (int)LanguageContentType.PrivacyPolicyContent)
                                                      && (lSectionName.LanguageCode == lang)                                          
                                                      select new PrivacyPolicyResult
                                                      {
                                                          ID = priv.ID,
                                                          PolicyContent = lSectionName.LanguageContent1,
                                                          CreateBy = priv.CreateBy,
                                                          CreateDate = priv.CreateDate,
                                                          UpdateBy = priv.UpdateBy,
                                                          UpdateDate = priv.UpdateDate
                                                      }).GroupBy(x => x.ID).Select(group => group.FirstOrDefault()).ToList();

                return privacyPolicy;
            }
            catch (Exception ex)
            {
               ExceptionLogger.Logger.WriteErrorLog(ex);
               return null;
            }
        }

        public int AddUpdatePrivacyPolicy(DBMethod ops, PrivacyPolicy Priv, string PolicyContentEnglish, string PolicyContentArabic, long UserID)
        {
            int iRetVal = 0;
            try
            {
                //PrivacyPolicy currentPolicy = Database.PrivacyPolicies.Find(Priv.ID);

                if(ops == DBMethod.Add)   //Add new policy
                {
                    long PolicyContentTrsID = DBHelper.GetUniqueID();
                    Priv.PolicyTranslationID = PolicyContentTrsID;

                    DBHelper.AddLanguageContent(PolicyContentTrsID, PolicyContentEnglish, PolicyContentArabic, LanguageContentType.PrivacyPolicyContent);

                    Database.PrivacyPolicies.Add(Priv);
                }
                else //update policy
                {
                    if (Priv.ID == 0)
                    {
                        ExceptionLogger.Logger.WriteErrorLog(new Exception("Privacy Policy ID invalid."));
                        return 0;
                    }
                    PrivacyPolicy currentPolicy = Database.PrivacyPolicies.Find(Priv.ID);
                    long PolicyContentTrsID = DBHelper.GetUniqueID();
                    currentPolicy.PolicyTranslationID = PolicyContentTrsID;

                    DBHelper.AddLanguageContent(PolicyContentTrsID, PolicyContentEnglish, PolicyContentArabic, LanguageContentType.PrivacyPolicyContent);

                    currentPolicy.UpdateDate = Priv.UpdateDate;
                    currentPolicy.UpdateBy = Priv.UpdateBy;
                    Database.Entry(currentPolicy).State = System.Data.Entity.EntityState.Modified;
                }
                iRetVal = Database.SaveChanges();
            }
            catch (Exception ex)
            {
               ExceptionLogger.Logger.WriteErrorLog(ex);
               iRetVal = 0;
            }
            return iRetVal;
        }
    }
}
