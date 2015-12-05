using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace SEIBK.BL
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService
    {

        //[OperationContract]
        //string GetData(int value);

        //[OperationContract]
        //CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here

        [OperationContract]
        Customer GetCustomerDetails(long CID);

        [OperationContract]
        Login ValidateCustomerCredentials(long CID, string password);
        [OperationContract]
        List<Account> GetCustomerAccountsList(long CID);
        [OperationContract]
        Account GetAccountDetails(long CID, long AccID);
    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class CompositeType
    {
        bool boolValue = true;
        string stringValue = "Hello ";

        [DataMember]
        public bool BoolValue
        {
            get { return boolValue; }
            set { boolValue = value; }
        }

        [DataMember]
        public string StringValue
        {
            get { return stringValue; }
            set { stringValue = value; }
        }
    }

    [DataContract]
    public class Customer
    {
        string firstname, lastname, address, email, mobile, status;
        DateTime dob;
        int CustID;

        [DataMember]
        public int CID
        {
            get { return CustID; }
            set { CustID = value; }
        }

        [DataMember]
        public string FirstName
        {
            get{return firstname;}
            set{firstname = value;}
        }

        [DataMember]
        public string LastName
        {
            get{return lastname;}
            set{lastname = value;}
        }

        [DataMember]
        public string Address
        {
            get{return address;}
            set{address = value;}
        }

        [DataMember]
        public string Email
        {
            get{return email;}
            set{email = value;}
        }

        [DataMember]
        public string Mobile
        {
            get{return mobile;}
            set{mobile = value;}
        }

        [DataMember]
        public string Status
        {
            get{return status;}
            set{status = value;}
        }

        [DataMember]
        public DateTime DateOfBirth
        {
            get{return dob;}
            set{dob = value;}
        }
    }

    [DataContract]
    public class Login
    {
        private bool loginSuccess;
        [DataMember]
        public bool LoginSuccess
        {
            get { return loginSuccess; }
            set { loginSuccess = value; }
        }       
        
    }

    [DataContract]
    public class Account
    {
        private long accID;
        [DataMember]
        public long AccountID
        {
            get { return accID; }
            set { accID = value; }
        }
        private string accNum;
        [DataMember]
        public string AccountNumber
        {
            get { return accNum; }
            set { accNum = value; }
        }
        private decimal bal;
        [DataMember]
        public decimal Balance
        {
            get { return bal; }
            set { bal = value; }
        }
        private DateTime openDate;
        [DataMember]
        public DateTime AccountOpenDate
        {
            get { return openDate; }
            set { openDate = value; }
        }
        private bool estmtSub;
        [DataMember]
        public bool EstatementSubscribed
        {
            get { return estmtSub; }
            set { estmtSub = value; }
        }
        private decimal overdraw;
        [DataMember]
        public decimal OverDrawLimit
        {
            get { return overdraw; }
            set { overdraw = value; }
        }

        private string accTyp;
        [DataMember]
        public string AccountType
        {
            get { return accTyp; }
            set { accTyp = value; }
        }
        private string branch;
        [DataMember]
        public string BranchName
        {
            get { return branch; }
            set { branch = value; }
        }
        private int branchID;
        [DataMember]
        public int BranchID
        {
            get { return branchID; }
            set { branchID = value; }
        }
        private string isoCurr;
        [DataMember]
        public string ISOCurrencyCode
        {
            get { return isoCurr; }
            set { isoCurr = value; }
        }
        private string currName;
        [DataMember]
        public string CurrencyName
        {
            get { return currName; }
            set { currName = value; }
        }
        
    }
    
}
