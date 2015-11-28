
using Microsoft.VisualBasic;
using System;
using System.Data;
using System.DirectoryServices;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web;


partial class VehicleMaintenance_VehicleMaintenanceRequest_ALL : System.Web.UI.Page
{
    private SearchResultCollection result;
    const int actCode_DeleteLeaveRequest = 10011;
    DirectoryEntry de = new DirectoryEntry();
    //private DirectorySearcher search = new DirectorySearcher(de);
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
    int ShowSavedPettyCashRequest = 0;
    string MRSrId = "";
    string IsAdminUser = "";

    double randomNumber;
    ERPEnhancementsC_DAL.VehicleMaintenanceRequest_DAL objMR = new ERPEnhancementsC_DAL.VehicleMaintenanceRequest_DAL();

    ERPEnhancementsC_DAL.ProcessWorkflow_DAL objwf = new ERPEnhancementsC_DAL.ProcessWorkflow_DAL();

    public VehicleMaintenance_VehicleMaintenanceRequest_ALL()
    {
        Load += Page_Load;
        search = new DirectorySearcher(de);
    }
    protected void cmdNewRequest_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("VehicleMaintenanceRequest_ALL.aspx");
    }

    protected void cmdViewRequestList_Click(object sender, System.EventArgs e)
    {
        try
        {
            //NewRequestEntry.Visible = false;
            //NewRequestEntryD.Visible = false;
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
            //CurrentLoginUser = "mj";  //for testing//
            //"test1" '
            //CurrentLoginUser = "hermang";
            //CurrentLoginUser = "michael.hayes";
            //CurrentLoginUser = "fayaz";
            //CurrentLoginUser = "khalid.al-romaithi";
            //CurrentLoginUser = "leo.dsouza";
            //CurrentLoginUser = "msaeed"
            //CurrentLoginUser = "shaider";

            Session["CurrentLoginUser"] = CurrentLoginUser;
            wf.eServiceId = "AD07VehicleMaintenance";
            wf.WorkflowID = "VT0701";

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

                //MaterialRequestList.Visible = true;
                // code changes from here
                //if (Session["IsAdminUser"].ToString() == "True")
                //{
                //    MaterialRequestList.Columns[4].Visible = true;
                //}
                //else
                //{
                //    MaterialRequestList.Columns[4].Visible = false;
                //}
                //code changes till here
            }

            if (Page.IsPostBack == false)
            {
                // code changes from here
                FillUserSessionData();
                LoadVehicleData();
                LoadServiceData();
                //Button1.OnClientClick = "aspnetForm.target ='blank';";
                lblDocumentDate.Text = Strings.Format(DateTime.Now.Date, "MM/dd/yyyy");

                // code changes from here
                //IsAdminUser = objMR.GetAdminUser(CurrentLoginUser);
                //Session["IsAdminUser"] = IsAdminUser;


                //if (Session["EmployeeEmail"] == null | Session["ManagerName"] == null | Session["LineManagerEMail"] == null)
                //{
                //    de.Path = "LDAP://192.168.0.20/dc=gcaa-uae,dc=gov";
                //    de.Username = "";
                //    de.Password = "";

                //    ReturnEmployeeName(CurrentLoginUser);
                m_EmployeeName = Session["EmpName"].ToString();
                m_EmployeeEmail = Session["EmployeeEmail"].ToString();
                Session["CurrentUserEMail"] = m_EmployeeEmail;

                m_ManagerName = Session["ManagerName"].ToString();
                m_Department = Session["EmpDept"].ToString();
                m_ManagerEMail = Session["LineManagerEMail"].ToString();
                m_EmployeePhone = Session["Mobile"].ToString();
                if (String.IsNullOrEmpty(m_EmployeeEmail.Trim()))
                    return;

                Session["EmployeeEmail"] = m_EmployeeEmail;
                Session["ManagerName"] = m_ManagerName;
                Session["LineManagerName"] = m_ManagerName;

                Session["LineManagerEMail"] = m_ManagerEMail;
                m_AltManager = Session["AltLineManager"].ToString();
                m_AltManager_email = Session["AltLineManagerEMail"].ToString();

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

                Session["ADGEmail"] = lblADGEmail.Text;
                Session["ShowApprovalList"] = "";

                RefreshMySavedRecords();
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
            //lblErrorMessage.Text = ex.Message;
            //lblErrorMessage.Visible = true;
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }


    public void ResetFormToNewState()
    {
        lblDocumentID.Text = "**New Requisition";

        cmbVehicle.SelectedIndex = -1;
        txtLocation.Text = "";
        txtKM.Text = "";
        txtRemarks.Text = "";
        MaterialRequestList.DataSource = null;
        MaterialRequestList.DataBind();
        MaterialRequestList.Visible = false;
        //NewRequestEntry.Visible = true;
        mrList.Visible = false;
        RefreshWorkflowStatus();
        lblErrorMessage.Text = "";
        lblErrorMessage.Visible = false;
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
                        //NewRequestList.Visible = true;
                        break;
                    default:
                        //NewRequestEntry.Visible = false;
                        //NewRequestList.Visible = true;
                        //lblErrorMessage.Text = "Requisition Number is already submitted !!!";
                        //lblErrorMessage.Visible = true;
                        Logger.ShowNotification("Requisition Number is already submitted", Logger.UiNotificationType.Notify);
                        return;

                        break;
                }
            }

            if (string.IsNullOrEmpty(Strings.Trim(cmbVehicle.SelectedItem.Value.ToString())))
            {
                //lblErrorMessage.Text = "Please select vehicle.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select vehicle", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtLocation.Text)))
            {
                //lblErrorMessage.Text = "Please enter location.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter location", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtRemarks.Text)))
            {
                //lblErrorMessage.Text = "Please enter remarks.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter remarks", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtServiceDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter service date.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter service date", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtKM.Text)))
            {
                //lblErrorMessage.Text = "Please enter KM.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter KM", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtAmount.Text)))
            {
                //lblErrorMessage.Text = "Please enter Amount.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter Amount", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(cmbService.SelectedItem.Value.ToString())))
            {
                //lblErrorMessage.Text = "Please enter service option.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please enter service option", Logger.UiNotificationType.Notify);
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
            }

        }
        catch (Exception ex)
        {
            //lblErrorMessage.Text = ex.Message;
            //lblErrorMessage.Visible = true;
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
            wf.eServiceId = "AD07VehicleMaintenance";
            wf.WorkflowID = "VT0701";
            wf.CurrentUserId = CurrentLoginUser;
            //wf.CurrentUserName = lblEmployeeName.Text;
            //wf.CurrentUserEMail = lblEmail.Text;
            //wf.LineManagerName = lblLMName.Text;
            //wf.LineManagerEmail = lblLMEmail.Text;
            //wf.ADGEmail = lblADGEmail.Text;
            wf.CurrentUserName = Session["CurrentUserName"].ToString();
            wf.CurrentUserEMail = Session["CurrentUserEMail"].ToString();
            wf.LineManagerName = Session["LineManagerName"].ToString();
            wf.LineManagerEmail = Session["LineManagerEmail"].ToString();
            wf.ADGEmail = Session["ADGEmail"].ToString();

            Session["eServiceId"] = "AD07VehicleMaintenance";
            Session["WorkflowID"] = "VT0701";
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
        try
        {
            lblDocumentID.Text = "**New Request";

            cmbVehicle.SelectedIndex = -1;

            lblModel.Text = "";
            txtKM.Text = "";
            cmbService.SelectedIndex = -1;
            txtAmount.Text = "";

            MaterialRequestList.DataSource = null;
            MaterialRequestList.DataBind();
            MaterialRequestList.Visible = false;
            //NewRequestEntry.Visible = true;
            mrList.Visible = false;

            RefreshWorkflowStatus();

            lblErrorMessage.Text = "";
            lblErrorMessage.Visible = false;
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    private void SaveUserRecord()
    {
        try
        {
            objMR.MRInfo.Clear();
            objMR.MRInfo.Add(lblUserID.Text, "UserId", null, null);
            objMR.MRInfo.Add(lblDocumentDate.Text, "Date", null, null);
            objMR.MRInfo.Add(lblEmployeeName.Text, "UserName", null, null);
            objMR.MRInfo.Add(lblEmail.Text, "UserEmail", null, null);
            objMR.MRInfo.Add(lblEmployeeID.Text, "UserEmployeeID", null, null);
            objMR.MRInfo.Add(lblLMName.Text, "LineManagerName", null, null);
            objMR.MRInfo.Add(lblLMEmail.Text, "LineManagerEmail", null, null);
            objMR.MRInfo.Add(lblDivCode.Text.Trim() + "-" + lblDepCode.Text.Trim(), "ADDepartment", null, null);
            objMR.MRInfo.Add(lblDivCode.Text, "DivisionCode", null, null);
            objMR.MRInfo.Add(lblDepCode.Text, "DepartmentCode", null, null);
            objMR.MRInfo.Add(lblMobileNumber.Text, "MobilePhone", null, null);
            objMR.MRInfo.Add(Strings.Trim(txtLocation.Text), "Location", null, null);
            objMR.MRInfo.Add(txtRemarks.Text, "Remarks", null, null);
            objMR.MRInfo.Add(txtServiceDate.Text, "ServiceDate", null, null);
            objMR.MRInfo.Add(cmbVehicle.SelectedItem.Value, "VehicleID", null, null);
            objMR.MRInfo.Add(cmbVehicle.SelectedItem.Text, "RegistrationNumber", null, null);
            objMR.MRInfo.Add(cmbService.SelectedItem.Value, "ServiceSerialNo", null, null);
            objMR.MRInfo.Add(cmbService.SelectedItem.Text, "ServiceType", null, null);
            objMR.MRInfo.Add(lblModel.Text, "Model", null, null);
            objMR.MRInfo.Add(txtAmount.Text, "Amount", null, null);
            objMR.MRInfo.Add(txtKM.Text, "KM", null, null);
            objMR.MRInfo.Add(DateTime.Now, "CreatedDate", null, null);
            objMR.MRInfo.Add(lblUserID.Text, "CreatedBy", null, null);
            objMR.MRInfo.Add(lblDocumentID.Text, "DocumentId", null, null);
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


    private void RefreshMySavedRecords()
    {
        try
        {
            MaterialRequestList.DataSource = objMR.ReturnMySavedItemsList(lblDocumentID.Text);
            MaterialRequestList.DataBind();
            MaterialRequestList.Visible = true;

            if (!lblDocumentID.Text.Contains("**New"))
            {
                //lblDocumentDate.Text = Strings.Format(objMR.MRInfo["VoucherDate"], "dd/MM/yyyy");
                lblDocumentDate.Text = Strings.Format(objMR.MRInfo["Date"], "MM/dd/yyyy");
                txtServiceDate.Text = Strings.Format(objMR.MRInfo["ServiceDate"], "yyyy-MM-dd");
                txtLocation.Text = objMR.MRInfo["Location"].ToString();
                txtRemarks.Text = objMR.MRInfo["Remarks"].ToString();
                txtServiceDate.Enabled = false;
                txtLocation.Enabled = false;
                txtRemarks.Enabled = false;
                //cmbDepartment.SelectedValue = objMR.MRInfo["Department_Code"].ToString();
                cmbVehicle.SelectedIndex = -1;
                lblModel.Text = "";
                txtKM.Text = "";
                cmbService.SelectedIndex = -1;
                txtAmount.Text = "";
                //imgCallDate.Enabled = false;

            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    protected void MaterialRequestList_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                HtmlAnchor _anchor = new HtmlAnchor();
                string dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                string dtItemB = DataBinder.Eval(e.Row.DataItem, "ServiceType").ToString();
                string dtItemA = DataBinder.Eval(e.Row.DataItem, "Attachments").ToString();
                string dtItemC = lblDocumentID.Text;
                Image img = new Image();
                Image imgP = new Image();

                if (Request.QueryString["ShowRequest"] != "1")
                {
                    //_anchor = (HtmlAnchor)e.Row.FindControl("aTagURL_Delete");
                    dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                    //_anchor.HRef = "VehicleMaintenanceRequest_ALL.aspx?MRId=" + lblDocumentID.Text + "&ActionId=" + actCode_DeleteLeaveRequest + "&ID=" + dtItem;
                }
                else
                {
                    //_anchor = (HtmlAnchor)e.Row.FindControl("aTagURL_Delete");
                    dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                   // _anchor.HRef = "VehicleMaintenanceRequest_ALL.aspx";
                }

                _anchor = (HtmlAnchor)e.Row.FindControl("aTagURL_Att");
                img = (Image)e.Row.FindControl("imgAttach");
                imgP = (Image)e.Row.FindControl("imgAttachp");
                dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                dtItemC = lblDocumentID.Text;
                _anchor.HRef = "javascript:HandleAttachments('" + dtItem.Trim() + "','" + dtItemB + "');";
                //_anchor.HRef = "javascript:alert('test');";



                if (dtItemA == "0")
                {
                    imgP.Visible = false;
                }
                else
                {
                    img.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    protected void MaterialRequestList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleMaintenanceRequest_ALL.aspx");

    }
    protected void cmbVehicle_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblModel.Text = objMR.ReturnModel(cmbVehicle.SelectedValue.ToString());
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

    private void LoadVehicleData()
    {
        try
        {
            cmbVehicle.Items.Clear();
            DataTable dtVehicles = objMR.ReturnVehicle();
            if (dtVehicles != null && dtVehicles.Rows.Count > 0)
            {
                cmbVehicle.DataTextField = "RegistrationNumber";
                cmbVehicle.DataValueField = "DocumentID";
                cmbVehicle.DataSource = dtVehicles;
                cmbVehicle.DataBind();
            }
            cmbVehicle.Items.Insert(0, new ListItem("--Select--", ""));
        }
        catch (Exception ex)
        {
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }

    private void LoadServiceData()
    {
        try
        {
            cmbService.Items.Clear();
            DataTable dtVehicles = objMR.ReturnService();
            if (dtVehicles != null && dtVehicles.Rows.Count > 0)
            {
                cmbService.DataTextField = "ServiceType";
                cmbService.DataValueField = "SerialNo";
                cmbService.DataSource = dtVehicles;
                cmbService.DataBind();
            }
            cmbService.Items.Insert(0, new ListItem("--Select--", ""));
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