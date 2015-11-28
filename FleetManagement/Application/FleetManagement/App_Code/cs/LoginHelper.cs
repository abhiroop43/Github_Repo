using System;
using System.Configuration;
using System.Data;
using System.Security.Principal;
using System.DirectoryServices;
using System.Drawing;
using System.IO;

/// <summary>
/// Gets user profile data from AD server
/// </summary>
public class LoginHelper : IDisposable
{
    //private const string LdapUrl = "LDAP://GCAADCHQ01.gcaa-uae.gov";
    private readonly string _ldapUrl = ConfigurationManager.AppSettings["LDAPURL"];
    private readonly string _ldapUid = ConfigurationManager.AppSettings["LDAPDomain"] + "\\" + ConfigurationManager.AppSettings["LDAPUID"];
    private readonly string _ldapPwd = ConfigurationManager.AppSettings["LDAPPWD"];
    public string GetMgrEmailFromCn(string mgrCn)
    {
        string mgrEmail = "";
        DirectoryEntry entry = new DirectoryEntry(_ldapUrl, _ldapUid, _ldapPwd);
        entry.AuthenticationType=AuthenticationTypes.ReadonlyServer;
        DirectorySearcher dsearch = new DirectorySearcher(entry);

        string strFilter = "(&(objectCategory=person) (objectClass=user) (cn=" + mgrCn + "))";
        dsearch.Filter = strFilter;
        dsearch.PropertiesToLoad.Add("mail");
        dsearch.SearchScope = SearchScope.Subtree;

        foreach (SearchResult res in dsearch.FindAll())
        {
            mgrEmail = res.GetDirectoryEntry().Properties["mail"].Value.ToString();
        }

        return mgrEmail;
    }

    public DataTable GetUserDetailsFromLdap()
    {
        DataTable dtOutput = new DataTable();
        try
        {
            dtOutput.Columns.Add("EmpId");
            dtOutput.Columns.Add("EmpGivenName");
            dtOutput.Columns.Add("EmpName");
            dtOutput.Columns.Add("EmpEmail");
            dtOutput.Columns.Add("EmpDiv");
            dtOutput.Columns.Add("EmpDept");
            dtOutput.Columns.Add("EmpMgrName");
            dtOutput.Columns.Add("EmpMgrEmail");
            dtOutput.Columns.Add("AltMgrName");
            dtOutput.Columns.Add("AltMgrEmail");
            dtOutput.Columns.Add("Mobile");
            dtOutput.Columns.Add("Photo");
            dtOutput.Columns.Add("CurrentUserID");

            var windowsIdentity = WindowsIdentity.GetCurrent();
            if (windowsIdentity != null)
            {
                string targetUser = windowsIdentity.Name.Replace("GCA\\", "");
                //targetUser = "mj";    //for testing//
                //targetUser = "nasser.al-marzouqi";    //for testing//
                DirectoryEntry entry = new DirectoryEntry(_ldapUrl, _ldapUid, _ldapPwd);
                entry.AuthenticationType = AuthenticationTypes.ReadonlyServer;
                DirectorySearcher dsearch = new DirectorySearcher(entry);

                string strFilter = "(&(objectCategory=person) (objectClass=user) (sAMAccountName=" + targetUser +
                                   "))";
                dsearch.Filter = strFilter;
                dsearch.SearchScope = SearchScope.Subtree;
                dsearch.PropertiesToLoad.Add("cn");
                dsearch.PropertiesToLoad.Add("initials"); //staff id//
                dsearch.PropertiesToLoad.Add("mail");
                dsearch.PropertiesToLoad.Add("manager");
                dsearch.PropertiesToLoad.Add("department");
                dsearch.PropertiesToLoad.Add("Description");
                dsearch.PropertiesToLoad.Add("thumbnailPhoto");
                dsearch.PropertiesToLoad.Add("mobile");
                dsearch.PropertiesToLoad.Add("givenName");

                /*objectGUID
            objectSid
            msExchBlockedSendersHash
            msRTCSIP-UserRoutingGroupId
            msExchMailboxGuid
             */
                //SearchResultCollection result = dsearch.FindAll();
                SearchResult result = dsearch.FindOne();

                //foreach (SearchResult resLoopVariable in result)
                //{
                //SearchResult res = resLoopVariable;
                SearchResult res = result;

                DataRow dr = dtOutput.NewRow();
                dr["EmpId"] = res.GetDirectoryEntry().Properties["initials"].Value.ToString();
                dr["EmpGivenName"] = res.GetDirectoryEntry().Properties["givenName"].Value.ToString();
                dr["EmpName"] = res.GetDirectoryEntry().Properties["cn"].Value.ToString();
                dr["EmpEmail"] = res.GetDirectoryEntry().Properties["mail"].Value.ToString();

                dr["EmpDiv"] = res.GetDirectoryEntry().Properties["department"].Value.ToString()
                    .Substring(0,
                        res.GetDirectoryEntry().Properties["department"].Value.ToString()
                            .LastIndexOf(">", StringComparison.Ordinal));

                dr["EmpDept"] =
                    res.GetDirectoryEntry().Properties["department"].Value.ToString()
                        .Substring(
                            res.GetDirectoryEntry().Properties["department"].Value.ToString()
                                .LastIndexOf(">", StringComparison.Ordinal) + 1);

                string mManagerName = res.GetDirectoryEntry().Properties["manager"].Value.ToString();
                string[] manager = mManagerName.Split(',');
                dr["EmpMgrName"] = manager[0].Replace("CN=", "");

                dr["EmpMgrEmail"] = GetMgrEmailFromCn(manager[0].Replace("CN=", ""));
                //dr["EmpMgrEmail"] = "";

                string mAltManager = res.GetDirectoryEntry().Properties["Description"].Value == null ? "" : res.GetDirectoryEntry().Properties["Description"].Value.ToString();
                if (mAltManager.IndexOf("|", StringComparison.Ordinal) >= 0)
                {
                    mAltManager =
                        mAltManager.Substring(mAltManager.IndexOf("|", StringComparison.Ordinal) + 1,
                            mAltManager.Length - mAltManager.IndexOf("|", StringComparison.Ordinal) - 1).Trim();
                }
                else
                {
                    mAltManager = null;
                }
                dr["AltMgrName"] = mAltManager;
                dr["AltMgrEmail"] = mAltManager == null ? "" : GetMgrEmailFromCn(mAltManager);

                dr["Mobile"] = res.GetDirectoryEntry().Properties["mobile"].Value != null ? res.GetDirectoryEntry().Properties["mobile"].Value.ToString() : "---";
                //dr["AltMgrEmail"] = "";
                if (res.GetDirectoryEntry().Properties["thumbnailPhoto"].Value != null &&
                    res.GetDirectoryEntry().Properties["thumbnailPhoto"].Value is byte[])
                {
                    byte[] bb = (byte[]) res.GetDirectoryEntry().Properties["thumbnailPhoto"].Value;
                    //Bitmap photo = new Bitmap(new MemoryStream(bb));
                    string imgString = Convert.ToBase64String(bb);
                    dr["Photo"] = "data:image/jpg;base64," + imgString;
                }
                else
                {
                    dr["Photo"] = "../assets/demo/avatars/1.jpg";
                }

                dr["CurrentUserID"] = targetUser;
                dtOutput.Rows.Add(dr);
                //}
            }

        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog(ex);
            return null;

        }
        return dtOutput;
    }

    public void Dispose()
    {

    }
}