using SEIBK.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

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
                //using (userDbEntities entities = new userDbEntities())
                //{
                //    string username = model.CID.ToString();
                //    string password = model.Password;

                //    // Now if our password was enctypted or hashed we would have done the
                //    // same operation on the user entered password here, But for now
                //    // since the password is in plain text lets just authenticate directly

                //    bool userValid = entities.Users.Any(user => user.username == username && user.password == password);

                //    // User found in the database
                //    if (userValid)
                //    {

                //        FormsAuthentication.SetAuthCookie(username, false);
                //        if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                //            && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                //        {
                //            return Redirect(returnUrl);
                //        }
                //        else
                //        {
                //            return RedirectToAction("Index", "Home");
                //        }
                //    }
                //    else
                //    {
                //        ModelState.AddModelError("", "The user name or password provided is incorrect.");
                //    }
                //}
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }
    }
}