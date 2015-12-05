using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SEIBK.Web.Controllers
{
    [Authorize]
    public class CreditCardController : Controller
    {
        // GET: CreditCard
        public ActionResult Index()
        {
            return View();
        }
    }
}