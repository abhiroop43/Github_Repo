
using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;

using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


partial class _TransportRequestList : System.Web.UI.UserControl
{

    const int actCode_SubmitLeaveRequest = 10001;
    const int actCode_DeleteLeaveRequest = 10011;
    const int actCode_ApproveLeaveRequest = 10111;

    const int actCode_RejectLeaveRequest = 11111;
    //Private objLeaveList As New GCAA_ESS_LeaveRequest.LeaveRequestList_DAL
    //Private objLeaveReq As New GCAA_ESS_LeaveRequest.LeaveForm_DAL

    private string m_LineManagerEMail = "";
    private bool isHRUser = false;
    private string EmployeeEmail = "";
    private string ManagerName = "";
    private string CurrentUserId = "";
    private string ShowApprovalList = "";
    private SqlConnection sqlConn = new SqlConnection();
    private SqlCommand sqlComm = new SqlCommand();
    private SqlDataAdapter Dadpt = new SqlDataAdapter();
    private SqlDataReader dr;
    private DataSet ds = new DataSet();

    private string SQL = "";

    private ERPEnhancementsC_DAL.TransportRequest_DAL objPC = new ERPEnhancementsC_DAL.TransportRequest_DAL();

    protected void Page_Load(object sender, System.EventArgs e)
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
            EmployeeEmail = Session["EmployeeEmail"].ToString();
            m_LineManagerEMail = Session["LineManagerEMail"].ToString();
            ManagerName = Session["ManagerName"].ToString();

            txtEmployeeID.Text = Session["GCAA_EmployeeId"].ToString();
            ShowApprovalList = Session["ShowApprovalList"].ToString();
            CurrentUserId = Session["CurrentUserId"].ToString();
            // code changes from here
            hEmployeeEmail.Value = EmployeeEmail;
            hLineManagerEMail.Value = m_LineManagerEMail;
            hManagerName.Value = ManagerName;
            hGCAA_EmployeeId.Value = txtEmployeeID.Text;
            hShowApprovalList.Value = ShowApprovalList;
            hCurrentUserId.Value = CurrentUserId;
            //

            if (ShowApprovalList == null)
            {
                ShowApprovalList = "";
            }

        }
        catch (Exception ex)
        {
            Logger.WriteErrorLog(ex);
            EmployeeEmail = "test1@gcaa.ae";
            ManagerName = "test3";
            m_LineManagerEMail = "test3@gcaa.ae";
            //Request.QueryString("ManagerEMail")

            // code changes from here

            EmployeeEmail = hEmployeeEmail.Value;
            ManagerName = hLineManagerEMail.Value;
            m_LineManagerEMail = hManagerName.Value;
            txtEmployeeID.Text = hGCAA_EmployeeId.Value;
            ShowApprovalList = hShowApprovalList.Value;
            CurrentUserId = hCurrentUserId.Value;
        }

         if (!Page.IsPostBack)
        {
            try
            {
                cmbRequestTypes.Items.Add(" ");
                //0
                cmbRequestTypes.Items.Add("All requests");
                //1
                cmbRequestTypes.Items.Add("My inprocess requests");
                //2
                cmbRequestTypes.Items.Add("My approved requests");
                //3
                cmbRequestTypes.Items.Add("My rejected requests");
                //4
                cmbRequestTypes.Items.Add("---------------------");
                //5
                cmbRequestTypes.Items.Add("Waiting for My Approval");
                //6
                cmbRequestTypes.Items.Add("Transport Requests approved by me");
                //7

                if (string.IsNullOrEmpty(Convert.ToString(hcmbRequestTypes.Value)) || string.IsNullOrEmpty(Convert.ToString(Session["CurrentUserId"])))
                {

                }
                else
                { 
                //cmbRequestTypes.SelectedIndex = Convert.ToInt32(Session["cmbRequestTypes"]);
                cmbRequestTypes.SelectedIndex = Convert.ToInt32(hcmbRequestTypes.Value);

                    
                //PettyCashList.DataSource = objPC.ReturnPettyCashRequests(Convert.ToInt32(Session["cmbRequestTypes"]), EmployeeEmail, Session["CurrentUserId"].ToString());
                TransportList.DataSource = objPC.ReturnTransportRequests(Convert.ToInt32(hcmbRequestTypes.Value), EmployeeEmail, Session["CurrentUserId"].ToString());
                TransportList.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = ex.Message;
                lblErrorMessage.Visible = true;
            }
        }
    }

    protected void TransportList_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {
            e.Row.HorizontalAlign = HorizontalAlign.Center;
            e.Row.VerticalAlign = VerticalAlign.Middle;

            e.Row.Cells[0].Visible = false;
            switch (cmbRequestTypes.SelectedIndex)
            {
                case 6:
                     e.Row.Cells[8].Visible = false;
                    //Approve Request
                    e.Row.Cells[9].Visible = false;
                    //Reject Request
                    break;
                default: 
                    e.Row.Cells[8].Visible = false;
                    //Approve Request
                    e.Row.Cells[9].Visible = false;
                    //Reject Request
                    break;
            }


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = new Label();
                HtmlAnchor _anchor = new HtmlAnchor();
                string dtItem = DataBinder.Eval(e.Row.DataItem, "DocumentID").ToString();
                string ApprovalPass = "";
                string RejectPass = "";

                Session["DocId"] = "";
                lbl = (Label) e.Row.FindControl("lblStatus");

                _anchor = ((HtmlAnchor) e.Row.FindControl("aTagURL"));
                
                if (lbl.Text == "Reject" | lbl.Text == "Rejected")
                {
                    //_anchor.Visible = false;
                    //_anchor.HRef = "#";
                    _anchor.Visible = true;
                    _anchor.HRef = "TransportRequest_ALL.aspx?MRID=" + dtItem + "&status=1&ShowRequest=1";

                }
                else
                {
                    _anchor.Visible = true;
                    _anchor.HRef = "TransportRequest_ALL.aspx?MRID=" + dtItem + "&status=1&ShowRequest=1";
                }

                _anchor = ((HtmlAnchor) e.Row.FindControl("aTagURL_Approve"));
                dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                ApprovalPass = DataBinder.Eval(e.Row.DataItem, "ApprovalPass").ToString();

                // code changes from here following line commented new added
                _anchor.HRef = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=41001&ID=" + dtItem + "&ApprovalPass=" + ApprovalPass + "&Method=99&ActionBy=" + EmployeeEmail;
                //_anchor.HRef = "http://localhost:5828/anonymous/ProcessRequestsC.aspx?ActionId=41001&ID=" + dtItem + "&ApprovalPass=" + ApprovalPass + "&Method=99&ActionBy=" + EmployeeEmail;
            
                _anchor = ((HtmlAnchor) e.Row.FindControl("aTagURL_Reject"));
                dtItem = DataBinder.Eval(e.Row.DataItem, "SerialNo").ToString();
                RejectPass = DataBinder.Eval(e.Row.DataItem, "RejectPass").ToString();

                // code changes from here following line commented new added
                _anchor.HRef = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=42001&ID=" + dtItem + "&RejectPass=" + RejectPass + "&Method=99&ActionBy=" + EmployeeEmail;
                //_anchor.HRef = "http://localhost:5828/anonymous/ProcessRequestsC.aspx?ActionId=42001&ID=" + dtItem + "&RejectPass=" + RejectPass + "&Method=99&ActionBy=" + EmployeeEmail;

            }
        }
        catch (Exception ex)
        {
            lblErrorMessage.Text = ex.Message;
            lblErrorMessage.Visible = true;
        }
    }

    protected void cmbRequestTypes_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        try
        {
            Session["cmbRequestTypes"] = cmbRequestTypes.SelectedIndex;
            hcmbRequestTypes.Value = cmbRequestTypes.SelectedIndex.ToString();
            TransportList.DataSource = objPC.ReturnTransportRequests(cmbRequestTypes.SelectedIndex, EmployeeEmail, hCurrentUserId.Value);
            TransportList.DataBind();
        }
        catch (Exception ex)
        {
            lblErrorMessage.Text = ex.Message;
            lblErrorMessage.Visible = true;
        }
    }
    public _TransportRequestList()
    {
        Load += Page_Load;
    }

    protected void TransportList_PreRender(object sender, EventArgs e)
    {
        if (TransportList.Rows.Count > 0)
        {
            TransportList.UseAccessibleHeader = true;
            TransportList.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
}