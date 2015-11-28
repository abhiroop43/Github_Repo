using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_I18N : CoreEntity
    {
        public long AddI18N()
        {
            try
            {
                DataAccess.i18n i18n = new i18n();
                Database.i18n.Add(i18n);
                Database.SaveChanges();
                return i18n.ID;
            }
            catch (Exception ex)
            {
                
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
    }
}
