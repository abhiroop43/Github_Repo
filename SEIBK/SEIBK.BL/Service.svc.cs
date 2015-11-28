using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using SEIBK.DAL;
using System.Data;

namespace SEIBK.BL
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service : IService
    {
        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        public Customer GetCustomerDetails(int CID)
        {
            Customer customer = new Customer();
            try
            {
                using(DataAccess objDAL = new DataAccess())
                {
                    DataTable dtOutput = objDAL.CustomerDetails(CID);
                    if(dtOutput!=null && dtOutput.Rows.Count == 1)
                    {
                        customer.CID = (int)dtOutput.Rows[0]["CID"];
                        customer.FirstName = (string)dtOutput.Rows[0]["FirstName"];
                        customer.LastName = (string)dtOutput.Rows[0]["LastName"];
                        customer.Address = (string)dtOutput.Rows[0]["Address"];
                        customer.Mobile = (string)dtOutput.Rows[0]["Mobile"];
                        customer.Email = (string)dtOutput.Rows[0]["Email"];
                        customer.DateOfBirth = (DateTime)dtOutput.Rows[0]["DateOfBirth"];
                        customer.Status = (string)dtOutput.Rows[0]["Status"];
                    }
                }
            }
            catch (Exception ex)
            {
               //Log exception//
                return null;
            }
            return customer;
        }
    }
}
