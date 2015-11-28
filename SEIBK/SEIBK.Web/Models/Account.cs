using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SEIBK.Web.Models
{
    public class Account
    {
        public long CID { get; set; }
        public long AccID { get; set; }
        public string AccNum { get; set; }
        public string AccType { get; set; }
        public int Branch { get; set; }
        public decimal Balance { get; set; }
        public decimal OverdrawLimit { get; set; }
        public string Status { get; set; }
        public DateTime OpeningDate { get; set; }
        public bool EstatementSub { get; set; }
        public int CurrencyCode { get; set; }
    }
}