using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess
{
    public class DAL_User : CoreEntity
    {
        public User GetUserDetails(string EmailID, string password)
        {
            try
            {
                return Database.Users.Where(i => i.Email==EmailID && i.Password == password && i.IsActive == true).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }

        public User GetUseByID(long UserID)
        {
            try
            {
                return Database.Users.Where(i => i.UserID == UserID).FirstOrDefault();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
        public int AddNewUser(User userDetails)
        {
            try
            {
                Database.Users.Add(userDetails);
                return Database.SaveChanges();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return 0;
            }
        }
        public List<User> GetAllActiveAdmins()
        {
            try
            {
                return Database.Users.Where(p => p.IsActive == true && p.UserTypeID == (int)BusinessDTO.UserType.Administrator).ToList();
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
                return null;
            }
        }
    }
}
