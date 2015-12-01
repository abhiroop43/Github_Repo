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

        [OperationContract]
        string GetData(int value);

        [OperationContract]
        CompositeType GetDataUsingDataContract(CompositeType composite);

        // TODO: Add your service operations here

        [OperationContract]
        Customer GetCustomerDetails(int CID);
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
    
}
