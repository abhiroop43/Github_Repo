using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SEIBK.BL.API.Models
{
    public class Account
    {
        private long accID;
        
        public long AccountID
        {
            get { return accID; }
            set { accID = value; }
        }
        private string accNum;
        
        public string AccountNumber
        {
            get { return accNum; }
            set { accNum = value; }
        }
        private decimal bal;
        
        public decimal Balance
        {
            get { return bal; }
            set { bal = value; }
        }
        private DateTime openDate;
        
        public DateTime AccountOpenDate
        {
            get { return openDate; }
            set { openDate = value; }
        }
        private bool estmtSub;
        
        public bool EstatementSubscribed
        {
            get { return estmtSub; }
            set { estmtSub = value; }
        }
        private decimal overdraw;
        
        public decimal OverDrawLimit
        {
            get { return overdraw; }
            set { overdraw = value; }
        }

        private string accTyp;
        
        public string AccountType
        {
            get { return accTyp; }
            set { accTyp = value; }
        }
        private string branch;
        
        public string BranchName
        {
            get { return branch; }
            set { branch = value; }
        }
        private int branchID;
        
        public int BranchID
        {
            get { return branchID; }
            set { branchID = value; }
        }
        private string isoCurr;
        
        public string ISOCurrencyCode
        {
            get { return isoCurr; }
            set { isoCurr = value; }
        }
        private string currName;
        
        public string CurrencyName
        {
            get { return currName; }
            set { currName = value; }
        }
    }
}