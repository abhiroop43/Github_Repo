using SEIBK.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using SEIBK.Web.IBKService;

namespace SEIBK.Web.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ViewResult Login()
        {
            return View();
        }

        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return View("Logout");
        }

        [HttpPost]
        public ActionResult Login(LoginViewModel model, string returnUrl)
        {
            // Lets first check if the Model is valid or not
            if (ModelState.IsValid)
            {
                using (ServiceClient objProxy = new ServiceClient())
                {
                    IBKService.Login isValid = objProxy.ValidateCustomerCredentials(model.CID, model.Password);
                    if(isValid.LoginSuccess)
                    {
                        FormsAuthentication.SetAuthCookie(model.CID.ToString(), false);
                        Session["CID"] = model.CID;
                        if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                            && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                        {
                            return Redirect(returnUrl);
                        }
                        else
                        {
                            return RedirectToAction("Index", "Home");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "The user name or password provided is incorrect.");
                    }
                }
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }
    }
}