using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SEIBK.BL.API
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            //config.Routes.MapHttpRoute(
            //    name: "AllCustomerAccountsApi",
            //    routeTemplate: "api/account/{cid}/{accid}",
            //    defaults: new { accid = RouteParameter.Optional }
            //);

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            //config.Routes.MapHttpRoute(
            //    name: "AllCustomerAccountsApi",
            //    routeTemplate: "api/account/{cid}"
            //);

            config.Routes.MapHttpRoute(
                name: "CustomerAccountApi",
                routeTemplate: "api/account/{cid}/{accid}",
                defaults: new { accid = RouteParameter.Optional }
            );
        }
    }
}
