using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SEIBK.DAL;
using SEIBK.BL.API.Models;
using System.Data;

namespace SEIBK.BL.API.Controllers
{
    public class CustomerController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage GetCustomerDetails(long id)
        {
            Customer customer = new Customer();
            HttpResponseMessage msg = null;
            try
            {
                using (DataAccess objDAL = new DataAccess())
                {
                    DataTable dtOutput = objDAL.CustomerDetails(id);
                    if (dtOutput != null && dtOutput.Rows.Count == 1)
                    {
                        customer.CID = Convert.ToInt64(dtOutput.Rows[0]["CID"]);
                        customer.FirstName = (string)dtOutput.Rows[0]["FirstName"];
                        customer.LastName = (string)dtOutput.Rows[0]["LastName"];
                        customer.Address = (string)dtOutput.Rows[0]["Address"];
                        customer.Mobile = (string)dtOutput.Rows[0]["Mobile"];
                        customer.Email = (string)dtOutput.Rows[0]["Email"];
                        customer.DateOfBirth = (DateTime)dtOutput.Rows[0]["DateOfBirth"];
                        customer.Status = (string)dtOutput.Rows[0]["Status"];
                        msg = Request.CreateResponse<Customer>(HttpStatusCode.OK, customer);
                    }
                    else
                    {
                        msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Customer not found!");
                    }
                    //msg = Request.CreateResponse<Customer>(HttpStatusCode.OK, customer);
                    //if (customer == null)
                    //{
                    //    msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Customer not found!");

                    //}
                    //else
                    //{
                    //    msg = Request.CreateResponse<Customer>(HttpStatusCode.OK, customer);
                    //}
                }
            }
            catch (Exception ex)
            {
                //Log exception//
                msg = Request.CreateErrorResponse(HttpStatusCode.InternalServerError, ex.ToString());
                //return null;
            }
            return msg;
        }
    }
}
