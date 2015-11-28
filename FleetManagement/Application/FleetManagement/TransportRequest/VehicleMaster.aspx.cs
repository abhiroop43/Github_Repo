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

public partial class TransportRequest_VehicleMaster : System.Web.UI.Page
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
            if(IsAdminUser.ToUpper().Trim() != "TRUE")
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

                BindData();
                //BindLocation();
                
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
    public TransportRequest_VehicleMaster()
    {
        Load += Page_Load;
    }
    protected void cmdNewRequest_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleMaster.aspx");
    }
    protected void cmdSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(Strings.Trim(cmbAvailability.SelectedItem.Text)))
            {
                //lblErrorMessage.Text = "Please select option";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select option", Logger.UiNotificationType.Notify);
                return;
            }

            else if (string.IsNullOrEmpty(Strings.Trim(txtModel.Text)))
            {
                //lblErrorMessage.Text = "Please select model";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtChasisNumber.Text)))
            {
                //lblErrorMessage.Text = "Please enter ChasisNumber.";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtColor.Text)))
            {
                //lblErrorMessage.Text = "Please enter Color";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtMake.Text)))
            {
                //lblErrorMessage.Text = "Please enter Make";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtODOMeter.Text)))
            {
                //lblErrorMessage.Text = "Please enter ODOMeter";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtOilChangeDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter Oil Change Date";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(cmbLocation.SelectedValue)))
            {
                //lblErrorMessage.Text = "Please select location";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtRegistrationExpiryDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter Registration expiry";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtInsuranceExpiryDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter Insurance Expiry Date";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtRegistrationNumber.Text)))
            {
                //lblErrorMessage.Text = "Please enter Registration number";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtSalikAccountNumber.Text)))
            {
                //lblErrorMessage.Text = "Please enter salik number";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtTyreChangeDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter tyre change date";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtInsuranceCompany.Text)))
            {
                //lblErrorMessage.Text = "Please enter insurance company";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtInsurancePolicyNumber.Text)))
            {
                //lblErrorMessage.Text = "Please enter insurance policy";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtEngineNumber.Text)))
            {
                //lblErrorMessage.Text = "Please enter engine number";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else if (string.IsNullOrEmpty(Strings.Trim(txtLastServiceDate.Text)))
            {
                //lblErrorMessage.Text = "Please enter last service date";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Please select model", Logger.UiNotificationType.Notify);
                return;
            }
            else
            {
                SaveUserRecord();
                BindData();
                cmdCancel_Click(sender, e);
                //lblErrorMessage.Text = "Record Saved Properly !!!";
                //lblErrorMessage.Visible = true;
                Logger.ShowNotification("Record saved.", Logger.UiNotificationType.Success);
               
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
        txtInsuranceExpiryDate.Text = "";
        txtInsurancePolicyNumber.Text = "";
        txtEngineNumber.Text = "";
        txtLastServiceDate.Text = "";
            }
        catch (Exception ex)
        {
            //lblErrorMessage.Text = ex.Message;
            //lblErrorMessage.Visible = true;
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error);
            Logger.WriteErrorLog(ex);
        }
       
    }

    private void SaveUserRecord()
    {
        try
        { 
        objMR.MRInfo.Clear();
            objMR.MRInfo.Add(lblDocumentID.Text, "DocumentID", null, null);
            objMR.MRInfo.Add(txtChasisNumber.Text, "ChasisNumber", null, null);
            objMR.MRInfo.Add(txtColor.Text, "Color", null, null);
            objMR.MRInfo.Add(txtMake.Text, "Make", null, null);
            objMR.MRInfo.Add(txtName.Text, "Name", null, null);
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
            objMR.MRInfo.Add(cmbLocation.SelectedValue, "Location", null, null);
            objMR.MRInfo.Add(Session["CurrentLoginUser"], "CreatedBy", null, null);
            objMR.MRInfo.Add(DateTime.Now, "CreatedDate", null, null);
                if (objMR.SaveUserRecord_VehicleMaster())
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
        ed = objMR.ReturnVMList(cmbLocation.SelectedValue.Trim());
        MaterialRequestList.DataSource = ed;
        MaterialRequestList.DataBind();
    }

    public void BindLocation()
    {
        ed = objMR.ReturnEMPLocation();
        cmbLocation.DataSource = ed;
        cmbLocation.DataTextField= "locatnid";
        cmbLocation.DataValueField= "locatnid";
        cmbLocation.DataBind();
    }
    //protected void MaterialRequestList_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
        
    
    //}


    //protected void txtLastServiceDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtLastServiceDate.Text = txtLastServiceDate.Text;
    //}
    //protected void txtOilChangeDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtOilChangeDate.Text = txtOilChangeDate.Text;
    //}
    //protected void txtRegistrationExpiryDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtRegistrationExpiryDate.Text = txtRegistrationExpiryDate.Text;
    //}
    //protected void txtTyreChangeDate_TextChanged(object sender, EventArgs e)
    //{
    //    txtTyreChangeDate.Text = txtTyreChangeDate.Text;
    //}
    //protected void txtInsuranceExpiryDate_TextChanged(object sender, EventArgs e)
    //{

    //}

    protected void MaterialRequestList_OnPreRender(object sender, EventArgs e)
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

                    //txtOilChangeDate.Text = ed.Rows[0]["OilChangeDate"].ToString();
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