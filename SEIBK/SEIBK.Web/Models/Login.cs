using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace SEIBK.Web.Models
{
    public class LoginViewModel
    {
        [Required]
        public int CID { get; set; }
        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        //public DateTime LastLogin { get; set; }
        //public int LoginAttempts { get; set; }
        //public bool Locked { get; set; }
        //public string Status { get; set; }
    }
}