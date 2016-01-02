using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SEIBK.BL.API.Models
{
    public class Customer
    {
        string firstname, lastname, address, email, mobile, status;
        DateTime dob;
        long CustID;


        public long CID
        {
            get { return CustID; }
            set { CustID = value; }
        }


        public string FirstName
        {
            get { return firstname; }
            set { firstname = value; }
        }


        public string LastName
        {
            get { return lastname; }
            set { lastname = value; }
        }


        public string Address
        {
            get { return address; }
            set { address = value; }
        }


        public string Email
        {
            get { return email; }
            set { email = value; }
        }


        public string Mobile
        {
            get { return mobile; }
            set { mobile = value; }
        }


        public string Status
        {
            get { return status; }
            set { status = value; }
        }


        public DateTime DateOfBirth
        {
            get { return dob; }
            set { dob = value; }
        }
    }
}