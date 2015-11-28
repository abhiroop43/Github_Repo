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
         

        public DataTable CustomerDetails(int CID)
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

            DataRow dr = dtOutput.NewRow();
            dr["CID"] = custDetails.First<tblCustomer>().ID;
            dr["FirstName"] = custDetails.First<tblCustomer>().FirstName;
            dr["LastName"] = custDetails.First<tblCustomer>().LastName;
            dr["DateOfBirth"] = custDetails.First<tblCustomer>().DateOfBirth;
            dr["Address"] = custDetails.First<tblCustomer>().Address;
            dr["Email"] = custDetails.First<tblCustomer>().Email;
            dr["Mobile"] = custDetails.First<tblCustomer>().Mobile;
            dr["Status"] = custDetails.First<tblCustomer>().Status;
            dtOutput.Rows.Add(dr);

            return dtOutput;
        }

        public DataTable GetCustomerAccountsList(int CID)
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
                                                  where acct.Status == "A"
                              select new { AccID = acct.AccID, AccNumber = acct.AccountNumber, Balance = acct.Balance, CreatedOn = acct.CreatedOn, eStmtSub = acct.EstatementSub, OverdrawLimit = acct.OverdrawLimit, AccountType = accType.TypeName, BranchName = branch.BranchName, BranchID = branch.ID, ISOCurrencyCode = curr.ISOCurrencyCode, CurrencyName = curr.CurrencyName };

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

        public bool ValidateCustomerCredentials(int CID, string password)
        {
            bool isValid = false;

            return isValid;
        }

        public DataTable GetAccountDetails(int CID, int AccID)
        {
            DataTable dtOutput = new DataTable();

            return dtOutput;
        }

        public void Dispose()
        {
            model.Dispose();
        }
    }
}
