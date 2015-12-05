using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SEIBK.Web.Models;
using System.Data.SqlClient;
using System.Data;
using SEIBK.Web.IBKService;

namespace SEIBK.Web.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        // GET: Account
        public ActionResult Summary()
        {
            long CID = Convert.ToInt64(Session["CID"]);
            //SqlConnection con = new SqlConnection("Server=homePC;Database=BITS_IBK;User Id=sa;Password=abcd1234");
            //con.Open();
            //SqlCommand cmd = new SqlCommand("Select Acc.AccID, Acc.CID, Acc.AccountNumber, AccType.TypeName AccountType, Acc.Balance from tblAccount Acc inner join tblAccountType AccType on Acc.AccountType=AccType.ID where CID = " + CID, con);
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //da.Fill(dt);
            //con.Close();
            //con.Dispose();

            using (ServiceClient objProxy = new ServiceClient())
            {
                List<IBKService.Account> accountList = objProxy.GetCustomerAccountsList(CID).ToList<IBKService.Account>();
                var accounts = new List<Models.Account>();

                foreach (IBKService.Account account in accountList)
                {
                    accounts.Add(new Models.Account() { CID = Convert.ToInt64(Session["CID"]), AccID = (long)account.AccountID, AccNum = (string)account.AccountNumber, AccType = (string)account.AccountType, Balance = Math.Round((decimal)account.Balance, 2) });
                }

                return View(accounts);
            }
        }

        public ActionResult AccountDetails(long CID, long accId)
        {
            if(CID == Convert.ToInt64(Session["CID"]))
            {
                using (ServiceClient objProxy = new ServiceClient())
                {
                    IBKService.Account account = objProxy.GetAccountDetails(CID, accId);
                    Models.Account acc = new Models.Account();
                    acc.AccID = (long)account.AccountID;
                    acc.AccNum = (string)account.AccountNumber;
                    return View(acc);
                }
            }
            else
            {
                ModelState.AddModelError("message", "You are not authorized to view this account");
                return View();
            }
        }
    }
}