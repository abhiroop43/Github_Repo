using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using SEIBK.DAL;
using SEIBK.BL.API.Models;

namespace SEIBK.BL.API.Controllers
{
    public class AccountController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetAllAccounts(long cid)
        {
            List<Account> accounts = new List<Account>();
            HttpResponseMessage msg = null;
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    DataTable dtAccounts = objDAL.GetCustomerAccountsList(cid);
                    if (dtAccounts != null && dtAccounts.Rows.Count > 0)
                    {
                        foreach (DataRow drAccount in dtAccounts.Rows)
                        {
                            Account account = new Account();
                            account.AccountID = Convert.ToInt64(drAccount["AccID"]);
                            account.AccountNumber = drAccount["AccNumber"].ToString();
                            account.Balance = Convert.ToDecimal(drAccount["Balance"]);
                            account.AccountOpenDate = (DateTime)drAccount["CreatedOn"];
                            account.EstatementSubscribed = (bool)drAccount["eStmtSub"];
                            account.OverDrawLimit = Convert.ToDecimal(drAccount["OverdrawLimit"]);
                            account.AccountType = drAccount["AccountType"].ToString();
                            account.BranchName = drAccount["BranchName"].ToString();
                            account.BranchID = Convert.ToInt32(drAccount["BranchID"]);
                            account.ISOCurrencyCode = drAccount["ISOCurrencyCode"].ToString();
                            account.CurrencyName = drAccount["CurrencyName"].ToString();
                            accounts.Add(account);
                        }
                    }

                    if (accounts == null)
                    {
                        msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Accounts not found!");

                    }
                    else
                    {
                        msg = Request.CreateResponse<List<Account>>(HttpStatusCode.OK, accounts);
                    }
                }
            }
            catch (Exception ex)
            {
                //Log exception//
                msg = Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.ToString());
            }
            return msg;
        }

        [HttpGet]
        public HttpResponseMessage GetAccountDetails(long cid, long accid)
        {
            HttpResponseMessage msg = null;
            Account account = new Account();
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    DataTable dtAccount = objDAL.GetAccountDetails(cid, accid);
                    if (dtAccount != null && dtAccount.Rows.Count > 0)
                    {
                        account.AccountID = Convert.ToInt64(dtAccount.Rows[0]["AccID"]);
                        account.AccountNumber = dtAccount.Rows[0]["AccNumber"].ToString();
                        account.Balance = Convert.ToDecimal(dtAccount.Rows[0]["Balance"]);
                        account.AccountOpenDate = (DateTime)dtAccount.Rows[0]["CreatedOn"];
                        account.EstatementSubscribed = Convert.ToBoolean(dtAccount.Rows[0]["eStmtSub"]);
                        account.OverDrawLimit = Convert.ToDecimal(dtAccount.Rows[0]["OverdrawLimit"]);
                        account.AccountType = dtAccount.Rows[0]["AccountType"].ToString();
                        account.BranchName = dtAccount.Rows[0]["BranchName"].ToString();
                        account.BranchID = Convert.ToInt32(dtAccount.Rows[0]["BranchID"]);
                        account.ISOCurrencyCode = dtAccount.Rows[0]["ISOCurrencyCode"].ToString();
                        account.CurrencyName = dtAccount.Rows[0]["CurrencyName"].ToString();
                    }
                }
                if (account == null)
                {
                    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Account not found!");

                }
                else
                {
                    msg = Request.CreateResponse<Account>(HttpStatusCode.OK, account);
                }
            }
            catch (Exception ex)
            {
                //Log exception//
                msg = Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.ToString());
            }
            return msg;
        }
    }
}
