using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SEIBK.Web.Models
{
    public class Customer
    {
        public long CID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime DOB { get; set; }
        public string Address { get; set; }
        public string Email { get; set; }
        public string MobileNum { get; set; }
        public string Status { get; set; }
    }
}