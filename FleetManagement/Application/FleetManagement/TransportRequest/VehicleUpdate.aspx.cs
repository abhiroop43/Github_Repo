using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Net.Mail;
using System.Security;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Net.Mime;
using AjaxControlToolkit;
using System.DirectoryServices;
using System.Web.UI;
using System.Drawing;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web;
using System.Linq;

public partial class TransportRequest_VehicleUpdate : System.Web.UI.Page
{
    DataTable ed = new DataTable();
    string CurrentLoginUser = "";
    string IsAdminUser = "";
    ERPEnhancementsC_DAL.TransportRequest_DAL objMR = new ERPEnhancementsC_DAL.TransportRequest_DAL();
    ERPEnhancementsC_DAL.ProcessWorkflow_DAL objwf = new ERPEnhancementsC_DAL.ProcessWorkflow_DAL();
    protected void Page_Load(object sender, EventArgs e)
    {
        // code changes from here for the session timeout
        if (Session["SessionLogId"] == null)
        {
            Response.Write("You session has ended. Kindly refresh the page. All unsubmitted information needs to be submit again.");
            Response.End();
        }
        // code changes till here for the session timeout
        try
        {
            CurrentLoginUser = HttpContext.Current.User.Identity.Name.ToString().Replace("GCA\\", "");
            IsAdminUser = objMR.GetAdminUser(CurrentLoginUser);
            if (IsAdminUser.ToUpper().Trim() != "TRUE")
            {
                Response.Redirect("~/Error401.aspx");
            }
            //CurrentLoginUser = "fayaz";
            
            //CurrentLoginUser = "khalid.al-romaithi";
            //CurrentLoginUser = "khalid.al-romaithi";
            //CurrentLoginUser = "leo.dsouza";
            //CurrentLoginUser = "msaeed"
            //CurrentLoginUser = "shaider"
			Session["CurrentLoginUser"] = CurrentLoginUser;
            if (Page.IsPostBack == false)
            {
                
                // code changes from here
                //IsAdminUser = objMR.GetAdminUser(Session["CurrentLoginUser"].ToString());
                //Session["IsAdminUser"] = IsAdminUser;
                //if (IsAdminUser == "False")
                //{
                //    lblErrorMessage.Text = "Only Admin users allowed";
                //    lblErrorMessage.Visible = true;
                //    MaterialRequestList.Visible = false;
                //    cmdSave.Visible = false;
                //    cmdCancel.Visible = false;
                //    return;
                //}
                //else
                //{
                //    MaterialRequestList.Visible = true;
                //    cmdSave.Visible = true;
                //    cmdCancel.Visible = true;
                //}
                //BindLocation();
                BindData();
                //BindDocument();

            }
            else
            {
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
    public TransportRequest_VehicleUpdate()
    {
        Load += Page_Load;
    }
    protected void cmdNewRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleUpdate.aspx");
    }
    protected void cmdSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Strings.Trim(cmbAvailability.SelectedItem.Text) == "No")
            {
                //lblErrorMessage.Text = "Please change the vehicle availability to [ Yes ] !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please change the vehicle availability to [ Yes ]", Logger.UiNotificationType.Notify);
                return;
            }
            else if (String.IsNullOrEmpty(txtODOMeter.Text) )
            {
                //lblErrorMessage.Text = "New ODO Meter value cannot be empty !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("New ODO Meter value cannot be empty", Logger.UiNotificationType.Notify);
                return;
            }
            else if (Convert.ToDecimal(txtODOMeter.Text) > Convert.ToDecimal(txtODOMeterOrg.Text)){
                //lblErrorMessage.Text = "New ODO Meter value should be greater than " + txtODOMeterOrg.Text  + " !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("New ODO Meter value should be greater than " + txtODOMeterOrg.Text + " !!!", Logger.UiNotificationType.Notify);
                return;
            }
            else
            {
                lblErrorMessage.Visible = false;
                UpdateUserRecord();
                BindData();
                
                //lblErrorMessage.Text = "Record Saved Properly !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Record saved.", Logger.UiNotificationType.Success);

                // code changes from here for email.
                if (!string.IsNullOrEmpty(Strings.Trim(cmbDocumentNumber.Text)))
                {
                    objwf.SendEMail_TransportRequest_RV(cmbDocumentNumber.Text, "AD02TransportRequest_VR0201_RV");
                }
                cmdCancel_Click(sender, e);
                
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
    protected void cmdCancel_Click(object sender, EventArgs e)
    {
        try
        {
            lblDocumentID.Text = "**New Request";
            txtChasisNumber.Text = "";
            txtModel.Text = "";
            txtColor.Text = "";
            txtMake.Text = "";
            txtName.Text = "";
            txtODOMeter.Text = "";
            txtOilChangeDate.Text = "";
            txtRegistrationExpiryDate.Text = "";
            txtRegistrationNumber.Text = "";
            txtSalikAccountNumber.Text = "";
            txtTyreChangeDate.Text = "";
            txtInsuranceCompany.Text = "";
            txtInsurancePolicyNumber.Text = "";
            txtEngineNumber.Text = "";
            txtLastServiceDate.Text = "";
            txtInsuranceExpiryDate.Text = "";
            cmbDocumentNumber.Text = "";
        }
        catch (Exception ex)
        {
            //lblErrorMessage.Text = ex.Message;
            //lblErrorMessage.Visible = true;
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
       
    }

    private void UpdateUserRecord()
    {
        try
        {
            objMR.MRInfo.Clear();
            objMR.MRInfo.Add(lblDocumentID.Text, "DocumentID", null, null);
            objMR.MRInfo.Add(txtChasisNumber.Text, "ChasisNumber", null, null);
            objMR.MRInfo.Add(txtColor.Text, "Color", null, null);
            objMR.MRInfo.Add(txtMake.Text, "Make", null, null);
            objMR.MRInfo.Add(txtName.Text, "Name", null, null);
            //objMR.MRInfo.Add(txtODOMeter.Text, "ODOMeter", null, null);
            objMR.MRInfo.Add(txtODOMeter.Text, "ODOMeter", null, null);
            objMR.MRInfo.Add(txtOilChangeDate.Text, "OilChangeDate", null, null);
            objMR.MRInfo.Add(txtRegistrationExpiryDate.Text, "RegistrationExpiryDate", null, null);
            objMR.MRInfo.Add(txtRegistrationNumber.Text, "RegistrationNumber", null, null);
            objMR.MRInfo.Add(txtSalikAccountNumber.Text, "SalikAccountNumber", null, null);
            objMR.MRInfo.Add(txtTyreChangeDate.Text, "TyreChangeDate", null, null);
            objMR.MRInfo.Add(txtInsuranceCompany.Text, "InsuranceCompany", null, null);
            objMR.MRInfo.Add(txtInsurancePolicyNumber.Text, "InsurancePolicyNumber", null, null);
            objMR.MRInfo.Add(txtEngineNumber.Text, "EngineNumber", null, null);
            objMR.MRInfo.Add(txtLastServiceDate.Text, "LastServiceDate", null, null);
            objMR.MRInfo.Add(cmbAvailability.SelectedValue, "Availability", null, null);
            objMR.MRInfo.Add(txtModel.Text, "Model", null, null);
            objMR.MRInfo.Add(txtInsuranceExpiryDate.Text, "InsuranceExpiryDate", null, null);
            objMR.MRInfo.Add(cmbLocation.Text, "Location", null, null);
            objMR.MRInfo.Add(Session["CurrentLoginUser"], "CreatedBy", null, null);
            objMR.MRInfo.Add(DateTime.Now, "CreatedDate", null, null);

            if (objMR.UpdateUserRecord_VehicleMaster())
            {
                lblDocumentID.Text = objMR.MRInfo["DocumentID"].ToString();
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
    public void BindData()
    {
        try
        {
            if (cmbLocation.SelectedItem.Text.Trim() != "")
            {
                ed = objMR.ReturnVMList_NAVehicles_Loc(cmbLocation.SelectedItem.Text);
            }
            else
            {
                ed = objMR.ReturnVMList_NAVehicles();
            }
            MaterialRequestList.DataSource = ed;
            MaterialRequestList.DataBind();
            if (ed.Rows.Count > 0)
            {
                cmdSave.Visible = false;
            }
            else
            {
                cmdSave.Visible = true;
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

    public void BindDocument()
    {
        //ed = objMR.ReturnDocument(lblDocumentID.Text);
        //cmbDocumentNumber.DataSource = ed;
        //cmbDocumentNumber.DataTextField = "DocumentID";
        //cmbDocumentNumber.DataValueField = "DocumentID";
        //cmbDocumentNumber.DataBind();

        //ListItem li = new ListItem();
        //li.Text = "";
        //li.Value = "";
        //cmbDocumentNumber.Items.Insert(0, li);
    }
    //protected void MaterialRequestList_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
        
    //}

    //protected void txtLastServiceDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtLastServiceDate.Text = Convert.ToDateTime(txtLastServiceDate.Text).ToLongDateString();
    //}
    //protected void txtOilChangeDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtOilChangeDate.Text = Convert.ToDateTime(txtOilChangeDate.Text).ToLongDateString();
    //}
    //protected void txtRegistrationExpiryDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtRegistrationExpiryDate.Text = Convert.ToDateTime(txtRegistrationExpiryDate.Text).ToLongDateString();
    //}
    //protected void txtTyreChangeDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtTyreChangeDate.Text = Convert.ToDateTime(txtTyreChangeDate.Text).ToLongDateString();
    //}
    //protected void txtInsuranceExpiryDate_TextChanged(object sender, EventArgs e)
    //{

    //}
    protected void cmbLocation_SelectedIndexChanged(object sender, EventArgs e) 
    {
        try
        {
            ed = objMR.ReturnVMList_NAVehicles_Loc(cmbLocation.SelectedItem.Text);
            MaterialRequestList.DataSource = ed;
            MaterialRequestList.DataBind();
        }
        catch (Exception ex)
        {
            //lblErrorMessage.Text = ex.Message;
            //lblErrorMessage.Visible = true;
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
    }
    protected void MaterialRequestList_PreRender(object sender, EventArgs e)
    {
        if (MaterialRequestList.Rows.Count > 0)
        {
            MaterialRequestList.UseAccessibleHeader = true;
            MaterialRequestList.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
    protected void MaterialRequestList_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        try
        {
            lblErrorMessage.Text = "";
            lblErrorMessage.Visible = false;
            ed = objMR.EditRecord(MaterialRequestList.DataKeys[e.NewSelectedIndex].Value.ToString());
            if (ed != null)
            {
                if (ed.Rows.Count > 0)
                {
                    lblDocumentID.Text = ed.Rows[0]["DocumentID"].ToString();
                    txtChasisNumber.Text = ed.Rows[0]["ChasisNumber"].ToString();
                    txtColor.Text = ed.Rows[0]["Color"].ToString();
                    txtMake.Text = ed.Rows[0]["Make"].ToString();
                    txtName.Text = ed.Rows[0]["Name"].ToString();
                    txtODOMeter.Text = ed.Rows[0]["ODOMeter"].ToString();
                    txtODOMeterOrg.Text = ed.Rows[0]["ODOMeter"].ToString();

                    txtOilChangeDate.Text = DateTime.ParseExact(ed.Rows[0]["OilChangeDate"].ToString(), "dd/MM/yyyy",
                        null).ToString("yyyy-MM-dd");

                    //txtRegistrationExpiryDate.Text = ed.Rows[0]["RegistrationExpiryDate"].ToString();
                    txtRegistrationExpiryDate.Text = DateTime.ParseExact(ed.Rows[0]["RegistrationExpiryDate"].ToString(), "dd/MM/yyyy",
                        null).ToString("yyyy-MM-dd");

                    txtRegistrationNumber.Text = ed.Rows[0]["RegistrationNumber"].ToString();
                    txtSalikAccountNumber.Text = ed.Rows[0]["SalikAccountNumber"].ToString();

                    //txtTyreChangeDate.Text = ed.Rows[0]["TyreChangeDate"].ToString();
                    txtTyreChangeDate.Text = DateTime.ParseExact(ed.Rows[0]["TyreChangeDate"].ToString(), "dd/MM/yyyy",
                        null).ToString("yyyy-MM-dd");

                    txtInsuranceCompany.Text = ed.Rows[0]["InsuranceCompany"].ToString();
                    txtInsurancePolicyNumber.Text = ed.Rows[0]["InsurancePolicyNumber"].ToString();
                    txtEngineNumber.Text = ed.Rows[0]["EngineNumber"].ToString();

                    //txtLastServiceDate.Text = ed.Rows[0]["LastServiceDate"].ToString();
                    txtLastServiceDate.Text = DateTime.ParseExact(ed.Rows[0]["LastServiceDate"].ToString(), "dd/MM/yyyy",
                        null).ToString("yyyy-MM-dd");

                    cmbAvailability.SelectedValue = ed.Rows[0]["Availability"].ToString();
                    txtModel.Text = ed.Rows[0]["Model"].ToString();

                    //txtInsuranceExpiryDate.Text = ed.Rows[0]["InsuranceExpiryDate"].ToString();
                    txtInsuranceExpiryDate.Text = DateTime.ParseExact(ed.Rows[0]["InsuranceExpiryDate"].ToString(), "dd/MM/yyyy",
                        null).ToString("yyyy-MM-dd");

                    cmbLocation.SelectedValue = ed.Rows[0]["Location"].ToString();
                    cmbDocumentNumber.Text = ed.Rows[0]["DOCID"].ToString();
                    BindDocument();
                    cmdSave.Visible = true;
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
}