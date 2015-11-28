using System;
using System.Data;
using System.Web;

public partial class MasterPages_Site : System.Web.UI.MasterPage
{
    public string CurrentUser, ProfilePhoto;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //var windowsIdentity = WindowsIdentity.GetCurrent();
            //if (windowsIdentity != null) CurrentUser = windowsIdentity.Name.Replace("GCA\\", "");
            if (Session["GCAA_EmployeeId"] == null)
            {
                DataTable dtCurrentUserDetails = GetCurrentUserDetails();
                if (dtCurrentUserDetails != null && dtCurrentUserDetails.Rows.Count > 0)
                {
                    Session["EmpGivenName"] = dtCurrentUserDetails.Rows[0]["EmpGivenName"].ToString();
                    Session["Photo"] = dtCurrentUserDetails.Rows[0]["Photo"].ToString();
                    CurrentUser = Session["EmpGivenName"].ToString();
                    ProfilePhoto = Session["Photo"].ToString();

                    Session["EmpName"] = dtCurrentUserDetails.Rows[0]["EmpName"].ToString();
                    Session["EmployeeEmail"] = dtCurrentUserDetails.Rows[0]["EmpEmail"].ToString();
                    Session["ManagerName"] = dtCurrentUserDetails.Rows[0]["EmpMgrName"].ToString();
                    Session["EmpDept"] = dtCurrentUserDetails.Rows[0]["EmpDept"].ToString();
                    Session["LineManagerEMail"] = dtCurrentUserDetails.Rows[0]["EmpMgrEmail"].ToString();
                    Session["Mobile"] = dtCurrentUserDetails.Rows[0]["Mobile"].ToString();

                    Session["AltLineManager"] = dtCurrentUserDetails.Rows[0]["AltMgrName"].ToString();
                    Session["AltLineManagerEMail"] = dtCurrentUserDetails.Rows[0]["AltMgrEmail"].ToString();

                    Session["EmpDiv"] = dtCurrentUserDetails.Rows[0]["EmpDiv"].ToString();
                    Session["GCAA_EmployeeId"] = dtCurrentUserDetails.Rows[0]["EmpId"].ToString();

                    //string CurrentLoginUser = HttpContext.Current.User.Identity.Name.ToString().Replace("GCA\\", "");
                    Session["CurrentUserId"] = dtCurrentUserDetails.Rows[0]["CurrentUserID"].ToString();
                }
                ERPEnhancementsC_DAL.TransportRequest_DAL objMR = new ERPEnhancementsC_DAL.TransportRequest_DAL();

                string CurrentLoginUser = HttpContext.Current.User.Identity.Name.ToString().Replace("GCA\\", "");
                //CurrentLoginUser = "mj";   //for testing//
                Session["IsAdminUser"] = objMR.GetAdminUser(CurrentLoginUser);

            }
            else
            {
                CurrentUser = Session["EmpGivenName"].ToString();
                ProfilePhoto = Session["Photo"].ToString();
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }        
    }

    private DataTable GetCurrentUserDetails()
    {
        using (LoginHelper objLogin = new LoginHelper())
        {
            return objLogin.GetUserDetailsFromLdap();
        }
    }
}
