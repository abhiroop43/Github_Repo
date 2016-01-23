using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SEIBK.DAL
{
    public class DataAccess : IDisposable
    {
        BITS_IBKEntities model;
        public DataAccess()
        {
            model = new BITS_IBKEntities();
        }
         

        public DataTable CustomerDetails(long CID)
        {
            DataTable dtOutput = new DataTable();
            dtOutput.Columns.Add("CID");
            dtOutput.Columns.Add("FirstName");
            dtOutput.Columns.Add("LastName");
            dtOutput.Columns.Add("DateOfBirth", typeof(DateTime));
            dtOutput.Columns.Add("Address");
            dtOutput.Columns.Add("Email");
            dtOutput.Columns.Add("Mobile");
            dtOutput.Columns.Add("Status");

            IEnumerable<tblCustomer> custDetails = from tblCustomer in model.tblCustomers
                    where tblCustomer.ID == CID
                    select tblCustomer;

            if(custDetails == null || custDetails.Count<tblCustomer>() == 0)
            {
                return null;
            }

            DataRow dr = dtOutput.NewRow();
            dr["CID"] = custDetails.FirstOrDefault<tblCustomer>().ID;
            dr["FirstName"] = custDetails.FirstOrDefault<tblCustomer>().FirstName;
            dr["LastName"] = custDetails.FirstOrDefault<tblCustomer>().LastName;
            dr["DateOfBirth"] = custDetails.FirstOrDefault<tblCustomer>().DateOfBirth;
            dr["Address"] = custDetails.FirstOrDefault<tblCustomer>().Address;
            dr["Email"] = custDetails.FirstOrDefault<tblCustomer>().Email;
            dr["Mobile"] = custDetails.FirstOrDefault<tblCustomer>().Mobile;
            dr["Status"] = custDetails.FirstOrDefault<tblCustomer>().Status;
            dtOutput.Rows.Add(dr);

            return dtOutput;
        }

        public DataTable GetCustomerAccountsList(long CID)
        {
            DataTable dtOutput = new DataTable();
            dtOutput.Columns.Add("AccID", typeof(long));
            dtOutput.Columns.Add("AccNumber");
            dtOutput.Columns.Add("Balance", typeof(decimal));
            dtOutput.Columns.Add("CreatedOn", typeof(DateTime));
            dtOutput.Columns.Add("eStmtSub", typeof(bool));
            dtOutput.Columns.Add("OverdrawLimit", typeof(decimal));
            dtOutput.Columns.Add("AccountType");
            dtOutput.Columns.Add("BranchName");
            dtOutput.Columns.Add("BranchID", typeof(int));
            dtOutput.Columns.Add("ISOCurrencyCode");
            dtOutput.Columns.Add("CurrencyName");

            var accountList = from cust in model.tblCustomers
                                                  join acct in model.tblAccounts on cust.ID equals acct.CID
                                                  join accType in model.tblAccountTypes on acct.AccountType equals accType.ID
                                                  join branch in model.tblBranchMasters on acct.Branch equals branch.ID
                                                  join curr in model.tblCurrencies on acct.CurrencyCode equals curr.ID
                                                  where acct.Status == "A" && acct.CID == CID
                              select new { AccID = acct.AccID, AccNumber = acct.AccountNumber, Balance = acct.Balance, CreatedOn = acct.CreatedOn, eStmtSub = acct.EstatementSub, OverdrawLimit = acct.OverdrawLimit, AccountType = accType.TypeName, BranchName = branch.BranchName, BranchID = branch.ID, ISOCurrencyCode = curr.ISOCurrencyCode, CurrencyName = curr.CurrencyName };

            if (accountList == null || accountList.Count() == 0)
            {
                return null;
            }

            foreach (var account in accountList)
            {
                DataRow drAccount = dtOutput.NewRow();
                drAccount["AccID"] = account.AccID;
                drAccount["AccNumber"] = account.AccNumber;
                drAccount["Balance"] = account.Balance;
                drAccount["CreatedOn"] = account.CreatedOn;
                drAccount["eStmtSub"] = account.eStmtSub;
                drAccount["OverdrawLimit"] = account.OverdrawLimit;
                drAccount["AccountType"] = account.AccountType;
                drAccount["BranchName"] = account.BranchName;
                drAccount["BranchID"] = account.BranchID;
                drAccount["ISOCurrencyCode"] = account.ISOCurrencyCode;
                drAccount["CurrencyName"] = account.CurrencyName;
                dtOutput.Rows.Add(drAccount);
            }
            return dtOutput;
        }

        public bool ValidateCustomerCredentials(long CID, string password)
        {
            bool isValid = false;
            var credentials = from login in model.tblLogins
                        where login.CID == CID && login.Password == password && login.Status == "A"
                        select new { CID = login.CID, LastLogin = login.LastLogin, LoginAttempts = login.LoginAttempts, Islocked = login.Locked, CreateDate = login.CreatedOn };
            if(credentials.Count() == 1)
            {
                isValid = true;
            }
            return isValid;
        }

        public DataTable GetAccountDetails(long CID, long AccID)
        {
            DataTable dtOutput = new DataTable();
            dtOutput.Columns.Add("AccID", typeof(long));
            dtOutput.Columns.Add("AccNumber");
            dtOutput.Columns.Add("Balance", typeof(decimal));
            dtOutput.Columns.Add("CreatedOn", typeof(DateTime));
            dtOutput.Columns.Add("eStmtSub", typeof(bool));
            dtOutput.Columns.Add("OverdrawLimit", typeof(decimal));
            dtOutput.Columns.Add("AccountType");
            dtOutput.Columns.Add("BranchName");
            dtOutput.Columns.Add("BranchID", typeof(int));
            dtOutput.Columns.Add("ISOCurrencyCode");
            dtOutput.Columns.Add("CurrencyName");

            var accountList = from cust in model.tblCustomers
                              join acct in model.tblAccounts on cust.ID equals acct.CID
                              join accType in model.tblAccountTypes on acct.AccountType equals accType.ID
                              join branch in model.tblBranchMasters on acct.Branch equals branch.ID
                              join curr in model.tblCurrencies on acct.CurrencyCode equals curr.ID
                              where acct.Status == "A" && acct.CID == CID && acct.AccID == AccID
                              select new { AccID = acct.AccID, AccNumber = acct.AccountNumber, Balance = acct.Balance, CreatedOn = acct.CreatedOn, eStmtSub = acct.EstatementSub, OverdrawLimit = acct.OverdrawLimit, AccountType = accType.TypeName, BranchName = branch.BranchName, BranchID = branch.ID, ISOCurrencyCode = curr.ISOCurrencyCode, CurrencyName = curr.CurrencyName };

            if (accountList == null || accountList.Count() == 0)
            {
                return null;
            }

            DataRow drAccount = dtOutput.NewRow();
            drAccount["AccID"] = accountList.FirstOrDefault().AccID;
            drAccount["AccNumber"] = accountList.FirstOrDefault().AccNumber;
            drAccount["Balance"] = accountList.FirstOrDefault().Balance;
            drAccount["CreatedOn"] = accountList.FirstOrDefault().CreatedOn;
            drAccount["eStmtSub"] = accountList.FirstOrDefault().eStmtSub;
            drAccount["OverdrawLimit"] = accountList.FirstOrDefault().OverdrawLimit;
            drAccount["AccountType"] = accountList.FirstOrDefault().AccountType;
            drAccount["BranchName"] = accountList.FirstOrDefault().BranchName;
            drAccount["BranchID"] = accountList.FirstOrDefault().BranchID;
            drAccount["ISOCurrencyCode"] = accountList.FirstOrDefault().ISOCurrencyCode;
            drAccount["CurrencyName"] = accountList.FirstOrDefault().CurrencyName;
            dtOutput.Rows.Add(drAccount);
            return dtOutput;
        }

        public void Dispose()
        {
            model.Dispose();
        }
    }
}
