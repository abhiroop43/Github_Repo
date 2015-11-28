using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_EmailTemplate : CoreEntity
    {
        public EmailTemplate GetTemplateByTemplateID(int TemplateID)
        {
            try
            {
                return Database.EmailTemplates.Where(p => p.EmailTemplateID == TemplateID).SingleOrDefault();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public List<EmailTemplate> GetAllTemplates()
        {
            try
            {
                return Database.EmailTemplates.ToList();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    
        public bool UpdateTemplateByID(int TemplateID,EmailTemplate template)
        {
            try
            {
                EmailTemplate myTemplate = Database.EmailTemplates.Where(p => p.EmailTemplateID == TemplateID).SingleOrDefault();
                if(myTemplate != null)
                {
                    myTemplate.IsActive = template.IsActive;
                    myTemplate.EmailSubject = template.EmailSubject;
                    myTemplate.TemplateBody = template.TemplateBody;
                    myTemplate.UpdateBy = template.UpdateBy;
                    myTemplate.UpdateDate = template.UpdateDate;
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
