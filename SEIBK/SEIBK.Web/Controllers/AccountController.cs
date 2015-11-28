using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SEIBK.Web.Models;
using System.Data.SqlClient;
using System.Data;

namespace SEIBK.Web.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        public ActionResult Summary()
        {
            int CID = 10001;
            SqlConnection con = new SqlConnection("Server=homePC;Database=BITS_IBK;User Id=sa;Password=abcd1234");
            con.Open();
            SqlCommand cmd = new SqlCommand("Select Acc.AccID, Acc.CID, Acc.AccountNumber, AccType.TypeName AccountType, Acc.Balance from tblAccount Acc inner join tblAccountType AccType on Acc.AccountType=AccType.ID where CID = " + CID, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            con.Dispose();
            //Account []acc = new Account[dt.Rows.Count];

            //for (int i = 0; i < dt.Rows.Count; i++)
            //{
            //    acc[i].AccID = (long)dt.Rows[0]["AccID"];
            //    acc[i].AccNum = (string)dt.Rows[0]["AccountNumber"];
            //}

            var accounts = new List<Account>();

            foreach(DataRow dr in dt.Rows)
            {
                accounts.Add(new Account() { AccID = (long)dr["AccID"], AccNum = (string)dr["AccountNumber"], AccType = (string)dr["AccountType"], Balance = Math.Round((decimal)dr["Balance"], 2) });
            }

            return View(accounts);
        }

        public ActionResult AccountDetails(int accId)
        {
            SqlConnection con = new SqlConnection("Server=homePC;Database=BITS_IBK;User Id=sa;Password=abcd1234");
            con.Open();
            SqlCommand cmd = new SqlCommand("Select Acc.AccID, Acc.CID, Acc.AccountNumber, AccType.TypeName AccountType, Acc.Balance from tblAccount Acc inner join tblAccountType AccType on Acc.AccountType=AccType.ID where AccID = " + accId, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            con.Dispose();
            Account acc = new Account();
            acc.AccID = (long)dt.Rows[0]["AccID"];
            acc.AccNum = (string)dt.Rows[0]["AccountNumber"];
            return View(acc);
        }
    }
}