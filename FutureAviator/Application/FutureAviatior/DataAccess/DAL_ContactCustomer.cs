using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_ContactCustomer : CoreEntity
    {
        public int AddContactRequest(ContactCustomer customerDetails)
        {
            try
            {
                Database.ContactCustomers.Add(customerDetails);
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
