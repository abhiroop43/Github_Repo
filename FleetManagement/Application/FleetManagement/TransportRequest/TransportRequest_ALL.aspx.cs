
using Microsoft.VisualBasic;
using System;
using System.Data;
using System.DirectoryServices;
using System.Web.UI.WebControls;
using System.Web;
using System.Globalization;

partial class TransportRequest_TransportRequest_ALL : System.Web.UI.Page
{
    DataTable ed = new DataTable();
    private SearchResultCollection result;
    const int actCode_DeleteLeaveRequest = 10011;
    DirectoryEntry de = new DirectoryEntry();
    private DirectorySearcher search = new DirectorySearcher();
    string m_EmployeeEmail = "";
    string m_EmployeeName = "";
    string m_Department = "";
    string m_Section = "";
    string m_EmployeePhone = "";

    string m_ManagerEMail = "";
    string m_ManagerName = "";
    string m_ManagersAMName = "";

    string m_AltManager = "";
    string m_AltManager_email = "";

    string CurrentLoginUser = "";
    string mr_LineNumbers = "";

    string MRSrId = "";
    string IsAdminUser = "";

    double randomNumber;
    ERPEnhancementsC_DAL.TransportRequest_DAL objMR = new ERPEnhancementsC_DAL.TransportRequest_DAL();
    ERPEnhancementsC_DAL.ProcessWorkflow_DAL objwf = new ERPEnhancementsC_DAL.ProcessWorkflow_DAL();

    public TransportRequest_TransportRequest_ALL()
    {
        Load += Page_Load;
        search = new DirectorySearcher(de);
    }
    protected void cmdNewRequest_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("TransportRequest_ALL.aspx");
    }

    public void BindData()
    {
        try
        {
            ed = objMR.ReturnVMList(cmbLocation.SelectedValue);
            MaterialRequestList.DataSource = ed;
            MaterialRequestList.DataBind();
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }        
    }
    protected void cmdViewRequestList_Click(object sender, System.EventArgs e)
    {
        try
        {
            //NewRequestEntry.Visible = false;
            //NewRequestEntryD.Visible = false;
            cmdSave.Visible = false;
            cmdCancel.Visible = false;
            MaterialRequestList.Visible = false;
            mrList.Visible = true;
            lblDocumentID.Text = "**New Request";
            RefreshWorkflowStatus();
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    protected void Page_Load(object sender, System.EventArgs e)
    {
        // code changes from here for the session timeout
        if (Session["SessionLogId"] == null)
        {
            Response.Write("You session has ended. Kindly refresh the page. All unsubmitted information needs to be submit again.");
            Response.End();
        }
        // code changes till here for the session timeout
        string ActionId = "";
        string DelLineID = "";
        Button cmdSubmit = new Button();
        DropDownList ddl = new DropDownList();
        try
        {
            cmdSubmit = (Button)wf.FindControl("cmdSubmit");
            cmdSubmit.Click += cmdNewRequest_Click;

            ddl = (DropDownList)mrList.FindControl("cmbRequestTypes");
            ddl.SelectedIndexChanged += cmdViewRequestList_Click;



            CurrentLoginUser = HttpContext.Current.User.Identity.Name.ToString().Replace("GCA\\", "");
            //CurrentLoginUser = "mj"; //for testing//

            //"test1" '
            //CurrentLoginUser = "fayaz";
            //CurrentLoginUser = "khalid.al-romaithi";
            //CurrentLoginUser = "khalid.al-romaithi";
            //CurrentLoginUser = "leo.dsouza";
            //CurrentLoginUser = "msaeed";
            //CurrentLoginUser = "shaider";
            // code changes from here following line added
            Session["CurrentUserId"] = CurrentLoginUser;

            wf.eServiceId = "AD02Transport";
            wf.WorkflowID = "VR0201";

            //MRID=" & dtItem + "&status=1&ShowRequest=1
            ActionId = Request.QueryString["ActionId"];
            DelLineID = Request.QueryString["ID"];
            MRSrId = Request.QueryString["MRID"];

            if ((ActionId != null))
            {
                if (ActionId == actCode_DeleteLeaveRequest.ToString())
                {
                    objMR.DeleteMRLine(DelLineID);
                    lblDocumentID.Text = MRSrId;
                    RefreshWorkflowStatus();
                }
            }


            //lblEmployeeName.Text = CurrentLoginUser

            if (Request.QueryString["ShowRequest"] == "1")
            {
                lblDocumentID.Text = MRSrId;
                RefreshWorkflowStatus();
                //NewRequestEntryD.Visible = false;
                cmdSave.Visible = false;
                cmdCancel.Visible = false;
                //if (ViewRequestList.Visible == true)
                //{
                //    MaterialRequestList.Visible = false;
                //}
                //else
                //{
                //    MaterialRequestList.Visible = true;
                //}
            }

            if (Page.IsPostBack == false)
            {
                FillUserSessionData();
                //BindLocation();
                BindData();

                //lblDocumentDate.Text = DateTime.Now.Date.ToLongDateString();
                //String.Format("{0:dd,MM,YYYY}", objMR.MRInfo["DocumentDate"]);0:d/M/yyyy
                lblDocumentDate.Text = DateTime.Now.Date.ToString("MM/dd/yyyy");


                // code changes from here
                //IsAdminUser = objMR.GetAdminUser(CurrentLoginUser);
                //Session["IsAdminUser"] = IsAdminUser;


                //if (Session["EmployeeEmail"] == null | Session["ManagerName"] == null | Session["LineManagerEMail"] == null)
                //{
                //de.Path = "LDAP://192.168.0.20/dc=gcaa-uae,dc=gov";
                //de.Username = "";
                //de.Password = "";
                //DataTable dtCurrentUserDetails = GetCurrentUserDetails();
                //if (dtCurrentUserDetails != null && dtCurrentUserDetails.Rows.Count > 0)
                //{
                m_EmployeeName = Session["EmpName"].ToString();
                m_EmployeeEmail = Session["EmployeeEmail"].ToString();
                Session["CurrentUserEMail"] = m_EmployeeEmail;

                m_ManagerName = Session["ManagerName"].ToString();
                m_Department = Session["EmpDept"].ToString();
                m_ManagerEMail = Session["LineManagerEMail"].ToString();
                m_EmployeePhone = Session["Mobile"].ToString();
                    //ReturnEmployeeName(CurrentLoginUser);
                    if (String.IsNullOrEmpty(m_EmployeeEmail.Trim()))
                        return;

                    Session["EmployeeEmail"] = m_EmployeeEmail;
                    Session["ManagerName"] = m_ManagerName;
                Session["LineManagerName"] = m_ManagerName;

                    //ReturnManagerEmail(m_ManagerName);
                    Session["LineManagerEMail"] = m_ManagerEMail;
                    m_AltManager = Session["AltLineManager"].ToString();
                    m_AltManager_email = Session["AltLineManagerEMail"].ToString();
                    //Session["AltLineManagerEMail"] = m_AltManager_email;

                    //if ((m_AltManager != null))
                    //{
                    //    m_AltManager_email = ReturnAltManagerEmail(m_AltManager);
                    //    Session["AltLineManagerEMail"] = m_AltManager_email;
                    //}
                    //}
                    //else
                    //{
                    //    if (String.IsNullOrEmpty(Session["EmployeeEmail"].ToString()) | String.IsNullOrEmpty(Session["ManagerName"].ToString()) | String.IsNullOrEmpty(Session["LineManagerEMail"].ToString()))
                    //    {
                    //        de.Path = "LDAP://192.168.0.20/dc=gcaa-uae,dc=gov";
                    //        de.Username = "";
                    //        de.Password = "";

                    //        ReturnEmployeeName(CurrentLoginUser);
                    //        if (String.IsNullOrEmpty(m_EmployeeEmail.Trim()))
                    //            return;

                    //        Session["EmployeeEmail"] = m_EmployeeEmail;
                    //        Session["ManagerName"] = m_ManagerName;

                    //        ReturnManagerEmail(m_ManagerName);
                    //        Session["LineManagerEMail"] = m_ManagerEMail;
                    //        if ((m_AltManager != null))
                    //        {
                    //            m_AltManager_email = ReturnAltManagerEmail(m_AltManager);
                    //        }
                    //    }
                    //    else
                    //    {
                    //        de.Path = "LDAP://192.168.0.20/dc=gcaa-uae,dc=gov";
                    //        de.Username = "";
                    //        de.Password = "";

                    //        ReturnEmployeeName(CurrentLoginUser);
                    //        if (String.IsNullOrEmpty(m_EmployeeEmail.Trim()))
                    //            return;

                    //        Session["EmployeeEmail"] = m_EmployeeEmail;
                    //        Session["ManagerName"] = m_ManagerName;

                    //        ReturnManagerEmail(m_ManagerName);
                    //        Session["LineManagerEMail"] = m_ManagerEMail;
                    //        if ((m_AltManager != null))
                    //        {
                    //            m_AltManager_email = ReturnAltManagerEmail(m_AltManager);
                    //        }
                    //    }
                    //}

                    //Session["AltLineManagerEMail"] = m_AltManager_email;
                    //Session["AltLineManager"] = (m_AltManager ?? "");

                    lblEmployeeID.Text = Session["GCAA_EmployeeId"].ToString();
                    lblUserID.Text = CurrentLoginUser;
                    lblEmployeeName.Text = m_EmployeeName;
                    Session["CurrentUserName"] = m_EmployeeName;
                    lblLMName.Text = m_ManagerName;
                    lblLMEmail.Text = m_ManagerEMail;
                    lblLMUserID.Text = Strings.Left(m_ManagerEMail,
                        Strings.InStr(m_ManagerEMail, "@", CompareMethod.Text) - 1);

                    lblDivCode.Text = Session["EmpDiv"].ToString();
                    lblDepCode.Text = Session["EmpDept"].ToString();
                    lblDepartment.Text = Session["EmpDept"].ToString();
                    lblDivision.Text = Session["EmpDiv"].ToString();

                    //lblMobileNumber.Text = dtCurrentUserDetails.Rows[0]["AltMgrName"].ToString();
                    lblMobileNumber.Text = m_EmployeePhone;
                    lblEmail.Text = m_EmployeeEmail.Trim();

                    //lblADGEmail.Text = "asantra@gcaa.gov.ae";
                    lblADGEmail.Text = objMR.ReturnToEmailAddressADG("VT01");
                    wf.CurrentUserId = CurrentLoginUser;
                    wf.CurrentUserName = m_EmployeeName;
                    wf.CurrentUserEMail = m_EmployeeEmail.Trim();
                    wf.LineManagerName = m_ManagerName;
                    wf.LineManagerEmail = m_ManagerEMail;
                    wf.ADGEmail = lblADGEmail.Text;


                    //Session["EmployeeEmail"] = m_EmployeeEmail;
                    //Session["LineManagerEMail"] = m_ManagerEMail;
                    //Session["ManagerName"] = m_ManagerName;
                    Session["ADGEmail"] = lblADGEmail.Text;
                    //Session["GCAA_EmployeeId"] = lblEmployeeID.Text;
                    Session["ShowApprovalList"] = "";

                    // code changes from here
                    //lblLineManager.Text = Session["ManagerName"].ToString();
                    // code changes till here

                    RefreshMySavedRecords();
                //}
                //if (objMR.GetEmployeeInformation(m_EmployeeEmail))
                //{
                //    if (objMR.EmployeeInfo.Count <= 0)
                //        return;

                //    lblEmployeeID.Text = objMR.EmployeeInfo["EMPLOYEE ID"].ToString().Trim();
                //    lblUserID.Text = CurrentLoginUser;
                //    lblEmployeeName.Text = m_EmployeeName;
                //    lblLMName.Text = m_ManagerName;
                //    lblLMEmail.Text = m_ManagerEMail;
                //    lblLMUserID.Text = Strings.Left(m_ManagerEMail, Strings.InStr(m_ManagerEMail, "@",CompareMethod.Text) - 1);

                //    lblDivCode.Text = objMR.EmployeeInfo["DIVCODE"].ToString().Trim();
                //    lblDepCode.Text = objMR.EmployeeInfo["DEPCODE"].ToString().Trim();
                //    lblDepartment.Text = objMR.EmployeeInfo["DEPLONGDESC_ENG"].ToString().Trim() + " - ";
                //    lblDivision.Text = objMR.EmployeeInfo["DIVLONGDESC_EN"].ToString().Trim() + " - ";

                //    lblMobileNumber.Text = objMR.EmployeeInfo["MobilePhone"].ToString().Trim();

                //    lblEmail.Text = m_EmployeeEmail.Trim();

                //    lblADGEmail.Text = "mulkarim@gcaa.gov.ae";
                //    wf.CurrentUserId = CurrentLoginUser;
                //    wf.CurrentUserName = m_EmployeeName;
                //    wf.CurrentUserEMail = m_EmployeeEmail.Trim();
                //    wf.LineManagerName = m_ManagerName;
                //    wf.LineManagerEmail = m_ManagerEMail;
                //    wf.ADGEmail = lblADGEmail.Text;


                //    Session["EmployeeEmail"] = m_EmployeeEmail;
                //    Session["LineManagerEMail"] = m_ManagerEMail;
                //    Session["ManagerName"] = m_ManagerName;
                //    Session["ADGEmail"] = lblADGEmail.Text;
                //    Session["GCAA_EmployeeId"] = lblEmployeeID.Text;
                //    Session["ShowApprovalList"] = "";

                //    // code changes from here
                //    //lblLineManager.Text = Session["ManagerName"].ToString();
                //    // code changes till here

                //    RefreshMySavedRecords();
                //    //tableGridView.Visible = False

                //}
            }
            else
            {
                if (!string.IsNullOrEmpty(objMR.ERROR_MESSAGE))
                {
                    //lblErrorMessage.Text = objMR.ERROR_MESSAGE;
                    //lblErrorMessage.Visible = true;
                    Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
                    Logger.WriteErrorLog(new Exception(objMR.ERROR_MESSAGE));
                }
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }


    public void ResetFormToNewState()
    {
        lblDocumentID.Text = "**New Requisition";

        txtFrom.Text = "";
        txtTo.Text = "";
        txtDepartureDate.TextMode = TextBoxMode.DateTimeLocal;
        txtDepartureDate.Text = "";
        txtReturnDate.TextMode = TextBoxMode.DateTimeLocal;
        txtReturnDate.Text = "";
        txtComments.Text = "";
        MaterialRequestList.DataSource = null;
        MaterialRequestList.DataBind();
        MaterialRequestList.Visible = false;
        //NewRequestEntry.Visible = true;
        mrList.Visible = false;
        RefreshWorkflowStatus();
        lblErrorMessage.Text = "";
        lblErrorMessage.Visible = false;
    }

    protected void btnCancelGrid_Click(object sender, System.EventArgs e)
    {
        MaterialRequestList.SelectedIndex = -1;
        //((System.Web.UI.UpdatePanel)this.FindControl("updateMaster")).Update();
    }
    protected void cmdSave_Click(object sender, System.EventArgs e)
    {
        try
        {
            //Check the workflow status
            if (!lblDocumentID.Text.Contains("New"))
            {
                string wfStatus = "";

                objwf.eServiceWorkflowInfo.Clear();
                objwf.eServiceWorkflowInfo.Add(wf.eServiceId, "eServiceId", null, null);
                objwf.eServiceWorkflowInfo.Add(wf.WorkflowID, "WorkflowID", null, null);
                objwf.eServiceWorkflowInfo.Add(lblDocumentID.Text, "DocumentNumber", null, null);
                wfStatus = objwf.ReturnWorkflowStatus();
                switch (wfStatus)
                {
                    case "Reject":
                    case "":
                        //NewRequestEntry.Visible = true;
                        break;
                    default:
                        //NewRequestEntry.Visible = false;
                        //lblErrorMessage.Text = "Requisition Number is already submitted !!!";
                        //lblErrorMessage.Visible = true;
                        Logger.ShowNotification("Requisition Number is already submitted", Logger.UiNotificationType.Notify);
                        return;
                        break;
                }
            }
            if (string.IsNullOrEmpty(Strings.Trim(txtFrom.Text)))
            {
                //lblErrorMessage.Text = "Please enter Going From.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter Going From", Logger.UiNotificationType.Notify);
                return;
            }
            else if (MaterialRequestList.SelectedRow == null)
            {
                //lblErrorMessage.Text = "Please select vehicle";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select vehicle", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtTo.Text)))
            {
                //lblErrorMessage.Text = "Please enter Going To.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter Going To", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(cmbLocation.SelectedValue)))
            {
                //lblErrorMessage.Text = "Please select location";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select location", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtDepartureDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter departure date.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter departure date", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtReturnDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter return date.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter return date", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtComments.Text)))
            {
                //lblErrorMessage.Text = "Please enter comments.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter comments", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(rbDriver.SelectedValue)))
            {
                //lblErrorMessage.Text = "Please select driver required.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select driver required", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(rbTripType.SelectedValue)))
            {
                //lblErrorMessage.Text = "Please select trip type.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select trip type", Logger.UiNotificationType.Notify);
                return;
            }
            else if (DateTime.Parse(txtDepartureDate.Text, new CultureInfo("en-GB")) > DateTime.Parse(txtReturnDate.Text, new CultureInfo("en-GB")))
            {
                //lblErrorMessage.Text = "Departure Date cannot be greater than Return Date.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Departure Date cannot be greater than Return Date", Logger.UiNotificationType.Notify);
                return;
            }
            else
            {
                SaveUserRecord();
                RefreshMySavedRecords();
                //cmdCancel_Click(sender, e);
                //lblErrorMessage.Text = "Record Saved Properly !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Record saved.", Logger.UiNotificationType.Success);
                RefreshWorkflowStatus();
                //cmdSave.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    private void RefreshWorkflowStatus()
    {
        try
        {
            if (lblDocumentID.Text.Contains("New"))
            {
                wf.DocumentNumber = "";
                Session["DocumentNumber"] = "";
            }
            else
            {
                wf.DocumentNumber = lblDocumentID.Text;
                Session["DocumentNumber"] = lblDocumentID.Text;
            }
            wf.eServiceId = "AD02Transport";
            wf.WorkflowID = "VR0201";
            wf.CurrentUserId = CurrentLoginUser;
            //wf.CurrentUserName = lblEmployeeName.Text;
            //wf.CurrentUserEMail = lblEmail.Text;
            //wf.LineManagerName = lblLMName.Text;
            //wf.LineManagerEmail = lblLMEmail.Text;
            wf.CurrentUserName = Session["CurrentUserName"].ToString();
            wf.CurrentUserEMail = Session["CurrentUserEMail"].ToString();
            wf.LineManagerName = Session["LineManagerName"].ToString();
            wf.LineManagerEmail = Session["LineManagerEmail"].ToString();
            wf.ADGEmail = Session["ADGEmail"].ToString();

            Session["eServiceId"] = "AD02Transport";
            Session["WorkflowID"] = "VR0201";
            Session["CurrentUserId"] = CurrentLoginUser;
            //Session["CurrentUserName"] = lblEmployeeName.Text;
            //Session["CurrentUserEMail"] = lblEmail.Text;
            //Session["LineManagerName"] = lblLMName.Text;
            //Session["LineManagerEmail"] = lblLMEmail.Text;
            //Session["ADGEmail"] = lblADGEmail.Text;
            wf.ReValidateWorkflowProperties();
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    protected void cmdCancel_Click(object sender, System.EventArgs e)
    {
        txtFrom.Text = "";
        txtTo.Text = "";
        txtDepartureDate.TextMode = TextBoxMode.DateTimeLocal;
        txtDepartureDate.Text = "";
        txtReturnDate.TextMode = TextBoxMode.DateTimeLocal;
        txtReturnDate.Text = "";
        txtComments.Text = "";
    }

    private void SaveUserRecord()
    {
        try
        {
            objMR.MRInfo.Clear();
            objMR.MRInfo.Add(lblUserID.Text, "UserId", null, null);
            objMR.MRInfo.Add(lblEmployeeName.Text, "UserName", null, null);
            objMR.MRInfo.Add(lblEmail.Text, "UserEmail", null, null);
            objMR.MRInfo.Add(lblEmployeeID.Text, "UserEmployeeID", null, null);
            objMR.MRInfo.Add(lblLMName.Text, "LineManagerName", null, null);
            objMR.MRInfo.Add(lblLMEmail.Text, "LineManagerEmail", null, null);
            objMR.MRInfo.Add(lblDivCode.Text.Trim() + "-" + lblDepCode.Text.Trim(), "ADDepartment", null, null);
            objMR.MRInfo.Add(lblDivCode.Text, "DivisionCode", null, null);
            objMR.MRInfo.Add(lblDepCode.Text, "DepartmentCode", null, null);
            objMR.MRInfo.Add(lblMobileNumber.Text, "MobilePhone", null, null);
            objMR.MRInfo.Add(((Label)MaterialRequestList.SelectedRow.FindControl("lblDocumentID")).Text, "VehicleNo", null, null);
            objMR.MRInfo.Add(txtFrom.Text, "From", null, null);
            objMR.MRInfo.Add(txtTo.Text, "To", null, null);
            DateTime dtDeparture = DateTime.Parse(txtDepartureDate.Text, new CultureInfo("en-GB"));
            DateTime dtReturn = DateTime.Parse(txtReturnDate.Text, new CultureInfo("en-GB"));

            //objMR.MRInfo.Add(txtDepartureDate.Text, "DepartureDate", null, null);
            //objMR.MRInfo.Add(txtReturnDate.Text, "ReturnDate", null, null);

            objMR.MRInfo.Add(dtDeparture.Date.ToString("d"), "DepartureDate");
            objMR.MRInfo.Add(dtReturn.Date.ToString("d"), "ReturnDate");

            objMR.MRInfo.Add(rbTripType.SelectedValue, "TripType");
            objMR.MRInfo.Add(rbDriver.SelectedValue, "Driver", null, null);
            objMR.MRInfo.Add(txtComments.Text, "Comments", null, null);
            objMR.MRInfo.Add(lblDocumentID.Text, "DocumentId", null, null);
            objMR.MRInfo.Add(lblDocumentDate.Text, "DocumentDate", null, null);
            objMR.MRInfo.Add(cmbLocation.SelectedValue, "Location", null, null);
            objMR.MRInfo.Add(Session["CurrentUserId"], "CreatedBy", null, null);
            objMR.MRInfo.Add(DateTime.Now.Date, "CreatedDate", null, null);

            //objMR.MRInfo.Add(txtDepartureTime.Text.Trim().Split(':')[0] + txtDepartureTime.Text.Trim().Split(' ')[1], "DepartureHour", null, null);
            //objMR.MRInfo.Add(txtDepartureTime.Text.Trim().Split(' ')[0].Split(':')[1], "DepartureMinutes", null, null);
            //objMR.MRInfo.Add(txtReturnTime.Text.Trim().Split(':')[0] + txtReturnTime.Text.Trim().Split(' ')[1], "ReturnHour", null, null);
            //objMR.MRInfo.Add(txtReturnTime.Text.Trim().Split(' ')[0].Split(':')[1], "ReturnMinutes", null, null);

            objMR.MRInfo.Add(dtDeparture.Hour, "DepartureHour", null, null);
            objMR.MRInfo.Add(dtDeparture.Minute, "DepartureMinutes", null, null);
            objMR.MRInfo.Add(dtReturn.Hour, "ReturnHour", null, null);
            objMR.MRInfo.Add(dtReturn.Minute, "ReturnMinutes", null, null);

            if (objMR.SaveUserRecord())
            {
                lblDocumentID.Text = objMR.MRInfo["DocumentId"].ToString();
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }
    public void BindLocation()
    {
        try
        {
            ed = objMR.ReturnEMPLocation();
            cmbLocation.DataSource = ed;
            cmbLocation.DataTextField = "locatnid";
            cmbLocation.DataValueField = "locatnid";
            cmbLocation.DataBind();
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }
    private void RefreshMySavedRecords()
    {
        try
        {
            if (!lblDocumentID.Text.Contains("**New"))
            {
                MaterialRequestList.DataSource = objMR.ReturnMySavedItemsList(lblDocumentID.Text);
                MaterialRequestList.DataBind();
                if (mrList.Visible == true)
                {
                    MaterialRequestList.Visible = false;
                }
                else
                {
                    MaterialRequestList.Visible = true;
                }
            }
            if (!lblDocumentID.Text.Contains("**New"))
            {
                //lblDocumentDate.Text = String.Format("{0:dd,MM,YYYY}", objMR.MRInfo["DocumentDate"]);
                lblDocumentDate.Text = objMR.MRInfo["DocumentDate"].ToString();
                txtFrom.Text = objMR.MRInfo["From"].ToString();
                txtTo.Text = objMR.MRInfo["To"].ToString();

                string strDepartureDateTime = objMR.MRInfo["DepartureDate"].ToString() + " " +
                                              objMR.MRInfo["DepartureHour"].ToString().PadLeft(2, '0') + ":" +
                                              objMR.MRInfo["DepartureMinutes"].ToString().PadLeft(2, '0');
                DateTime dtDeparture = DateTime.ParseExact(strDepartureDateTime, "dd/MM/yyyy HH:mm", null);
                txtDepartureDate.TextMode = TextBoxMode.SingleLine;
                txtDepartureDate.Text = dtDeparture.ToString("MM/dd/yyyy hh:mm tt");

                string strReturnDateTime = objMR.MRInfo["ReturnDate"].ToString() + " " +
                                              objMR.MRInfo["ReturnHour"].ToString().PadLeft(2, '0') + ":" +
                                              objMR.MRInfo["ReturnMinutes"].ToString().PadLeft(2, '0');

                DateTime dtReturn = DateTime.ParseExact(strReturnDateTime, "dd/MM/yyyy HH:mm", null);
                txtReturnDate.TextMode = TextBoxMode.SingleLine;
                txtReturnDate.Text = dtReturn.ToString("MM/dd/yyyy hh:mm tt");

                //txtDepartureDate.Text = objMR.MRInfo["DepartureDate"].ToString();
                //txtReturnDate.Text = objMR.MRInfo["ReturnDate"].ToString();

                rbTripType.SelectedValue = objMR.MRInfo["TripType"].ToString();
                rbDriver.SelectedValue = objMR.MRInfo["Driver"].ToString();
                txtComments.Text = objMR.MRInfo["Comments"].ToString();
                //lblLineManager.Text = objMR.MRInfo["LineManagerName"].ToString();
                cmbLocation.SelectedValue = objMR.MRInfo["Location"].ToString();
                //cmbDepartureHour.SelectedValue = objMR.MRInfo["DepartureHour"].ToString();
                //cmbDepartureMinutes.SelectedValue = objMR.MRInfo["DepartureMinutes"].ToString();
                //cmbReturnHour.SelectedValue = objMR.MRInfo["ReturnHour"].ToString();
                //cmbReturnMinutes.SelectedValue = objMR.MRInfo["ReturnMinutes"].ToString();
                //cmbDepartureHour.Enabled = false;
                //cmbDepartureMinutes.Enabled = false;
                //cmbReturnHour.Enabled = false;
                //cmbReturnMinutes.Enabled = false;

                txtFrom.Enabled = false;
                txtTo.Enabled = false;
                txtComments.Enabled = false;
                rbTripType.Enabled = false;
                rbDriver.Enabled = false;
                //imgDepartureDate.Enabled = false;
                //imgReturnDate.Enabled = false;
                cmbLocation.Enabled = false;

                //txtDepartureTime.Text = objMR.MRInfo["DepartureHour"].ToString().Split(' ')[0] + ":" + objMR.MRInfo["DepartureMinutes"].ToString() +
                //" " + objMR.MRInfo["DepartureHour"].ToString().Split(' ')[1];

                //txtReturnTime.Text = objMR.MRInfo["ReturnHour"].ToString().Split(' ')[0] + ":" + objMR.MRInfo["ReturnMinutes"].ToString() +
                //" " + objMR.MRInfo["ReturnHour"].ToString().Split(' ')[1];

                //txtDepartureTime.Enabled = false;
                //txtReturnTime.Enabled = false;
                txtDepartureDate.ReadOnly = true;
                txtReturnDate.ReadOnly = true;
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }

    }
    protected void MaterialRequestList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    HtmlAnchor _anchor = new HtmlAnchor();
        //    string dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
        //    string dtItemB = DataBinder.Eval(e.Row.DataItem, "ExpenseCode").ToString();
        //    string dtItemA = DataBinder.Eval(e.Row.DataItem, "Attachments").ToString();
        //    string dtItemC = lblDocumentID.Text;
        //    System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
        //    System.Web.UI.WebControls.Image imgP = new System.Web.UI.WebControls.Image();

        //    if (!(Request.QueryString["ShowRequest"] == "1"))
        //    {
        //        _anchor = (HtmlAnchor) e.Row.FindControl("aTagURL_Delete");
        //        dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
        //        _anchor.HRef = "PettyCashRequest_ALL.aspx?MRId=" + lblDocumentID.Text + "&ActionId=" + actCode_DeleteLeaveRequest + "&ID=" + dtItem;
        //    }
        //    else
        //    {
        //        _anchor = (HtmlAnchor) e.Row.FindControl("aTagURL_Delete");
        //        dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
        //        _anchor.HRef = "PettyCashRequest_ALL.aspx";
        //    }

        //    _anchor = (HtmlAnchor) e.Row.FindControl("aTagURL_Att");
        //    img = (System.Web.UI.WebControls.Image)e.Row.FindControl("imgAttach");
        //    imgP = (System.Web.UI.WebControls.Image) e.Row.FindControl("imgAttachp");
        //    dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
        //    dtItemC = lblDocumentID.Text;
        //    _anchor.HRef = "javascript:HandleAttachments('" + dtItem.Trim() + "','" + dtItemB + "');";
        //    //_anchor.HRef = "javascript:alert('test');";



        //    if (dtItemA == "0")
        //    {
        //        imgP.Visible = false;
        //    }
        //    else
        //    {
        //        img.Visible = false;
        //    }
        //}
    }
    //public Material_Requisition_MaterialRequest_ALL()
    //{
    //    Load += Page_Load;
    //}

    protected void MaterialRequestList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void cmbLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindData();
    }

    private DataTable GetCurrentUserDetails()
    {
        using (LoginHelper objLogin = new LoginHelper())
        {
            return objLogin.GetUserDetailsFromLdap();
        }
    }

    private void FillUserSessionData()
    {
        try
        {
            if (Session["GCAA_EmployeeId"] == null)
            {
                DataTable dtCurrentUserDetails = GetCurrentUserDetails();
                if (dtCurrentUserDetails != null && dtCurrentUserDetails.Rows.Count > 0)
                {
                    Session["EmpGivenName"] = dtCurrentUserDetails.Rows[0]["EmpGivenName"].ToString();
                    Session["Photo"] = dtCurrentUserDetails.Rows[0]["Photo"].ToString();
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
                }
                Session["IsAdminUser"] = objMR.GetAdminUser(CurrentLoginUser);
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    protected void MaterialRequestList_OnPreRender(object sender, EventArgs e)
    {
        if (MaterialRequestList.Rows.Count > 0)
        {
            MaterialRequestList.UseAccessibleHeader = true;
            MaterialRequestList.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}
