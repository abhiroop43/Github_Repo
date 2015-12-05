using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using SEIBK.DAL;
using System.Data;

namespace SEIBK.BL
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service : IService
    {
        //public string GetData(int value)
        //{
        //    return string.Format("You entered: {0}", value);
        //}

        //public CompositeType GetDataUsingDataContract(CompositeType composite)
        //{
        //    if (composite == null)
        //    {
        //        throw new ArgumentNullException("composite");
        //    }
        //    if (composite.BoolValue)
        //    {
        //        composite.StringValue += "Suffix";
        //    }
        //    return composite;
        //}

        public Customer GetCustomerDetails(long CID)
        {
            Customer customer = new Customer();
            try
            {
                using(DataAccess objDAL = new DataAccess())
                {
                    DataTable dtOutput = objDAL.CustomerDetails(CID);
                    if(dtOutput!=null && dtOutput.Rows.Count == 1)
                    {
                        customer.CID = (int)dtOutput.Rows[0]["CID"];
                        customer.FirstName = (string)dtOutput.Rows[0]["FirstName"];
                        customer.LastName = (string)dtOutput.Rows[0]["LastName"];
                        customer.Address = (string)dtOutput.Rows[0]["Address"];
                        customer.Mobile = (string)dtOutput.Rows[0]["Mobile"];
                        customer.Email = (string)dtOutput.Rows[0]["Email"];
                        customer.DateOfBirth = (DateTime)dtOutput.Rows[0]["DateOfBirth"];
                        customer.Status = (string)dtOutput.Rows[0]["Status"];
                    }
                }
            }
            catch (Exception ex)
            {
               //Log exception//
                return null;
            }
            return customer;
        }

        public Login ValidateCustomerCredentials(long CID, string password)
        {
            Login loginValidation = new Login();
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    bool isValid = objDAL.ValidateCustomerCredentials(CID, password);
                    loginValidation.LoginSuccess = isValid;
                }
            }
            catch (Exception ex)
            {
               //Log exception//
                return null;
            }
            return loginValidation;
        }

        public List<Account> GetCustomerAccountsList(long CID)
        {
            List<Account> accounts = new List<Account>();
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    DataTable dtAccounts = objDAL.GetCustomerAccountsList(CID);
                    if(dtAccounts!=null && dtAccounts.Rows.Count > 0)
                    {
                        foreach(DataRow drAccount in dtAccounts.Rows)
                        {
                            Account account = new Account();
                            account.AccountID = (long)drAccount["AccID"];
                            account.AccountNumber = drAccount["AccNumber"].ToString();
                            account.Balance = (decimal)drAccount["Balance"];
                            account.AccountOpenDate = (DateTime)drAccount["CreatedOn"];
                            account.EstatementSubscribed = (bool)drAccount["eStmtSub"];
                            account.OverDrawLimit = (decimal)drAccount["OverdrawLimit"];
                            account.AccountType = drAccount["AccountType"].ToString();
                            account.BranchName = drAccount["BranchName"].ToString();
                            account.BranchID = (int)drAccount["BranchID"];
                            account.ISOCurrencyCode = drAccount["ISOCurrencyCode"].ToString();
                            account.CurrencyName = drAccount["CurrencyName"].ToString();
                            accounts.Add(account);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //Log exception//
                return null;
            }
            return accounts;
        }

        public Account GetAccountDetails(long CID, long AccID)
        {
            Account account = new Account();
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    DataTable dtAccount = objDAL.GetAccountDetails(CID, AccID);
                    if(dtAccount!=null && dtAccount.Rows.Count > 0)
                    {
                        account.AccountID = (long)dtAccount.Rows[0]["AccID"];
                        account.AccountNumber = dtAccount.Rows[0]["AccNumber"].ToString();
                        account.Balance = (decimal)dtAccount.Rows[0]["Balance"];
                        account.AccountOpenDate = (DateTime)dtAccount.Rows[0]["CreatedOn"];
                        account.EstatementSubscribed = (bool)dtAccount.Rows[0]["eStmtSub"];
                        account.OverDrawLimit = (decimal)dtAccount.Rows[0]["OverdrawLimit"];
                        account.AccountType = dtAccount.Rows[0]["AccountType"].ToString();
                        account.BranchName = dtAccount.Rows[0]["BranchName"].ToString();
                        account.BranchID = (int)dtAccount.Rows[0]["BranchID"];
                        account.ISOCurrencyCode = dtAccount.Rows[0]["ISOCurrencyCode"].ToString();
                        account.CurrencyName = dtAccount.Rows[0]["CurrencyName"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                //Log exception//
                return null;
            }
            return account;
        }
    }
}
