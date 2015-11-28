
using Microsoft.VisualBasic;
using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Drawing;
using System.Net.Mail;
using System.Net.Mime;
using System.Web;
using Telerik.Web.UI;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Configuration;

namespace ERPEnhancementsC_DAL
{

    public class ProcessWorkflow_DAL
    {
        const int actCode_ApproveMaterialRequest = 31001;
        const int actCode_RejectMaterialRequest = 32001;

        const int actCode_ApprovePettyCashRequest = 31001;
        const int actCode_RejectPettyCashRequest = 32001;

        const int actCode_ApproveTransportRequest = 41001;
        const int actCode_RejectTransportRequest = 42001;



        const int actCode_ApproveOfficialMission = 61001;
        const int actCode_RejectOfficialMission = 62001;

        const int actCode_ApproveVisaManagement = 71001;
        const int actCode_RejectVisaManagement = 72001;

        const int actCode_ApproveVehicleMaintenance = 81001;
        const int actCode_RejectVehicleMaintenance = 82001;

        private SqlConnection sqlConn;
        private string SQL;
        private string Provider;
        private SqlDataAdapter sqlAdpt;
        private SqlDataReader sqlDr;
        private SqlCommand sqlComm;

        private DataSet dt;
        private DataTable dtable;
        private Collection m_eServiceWorkflowInfo = new Collection();
        private string m_ServerMapPath;
        private bool issqlDrOpen = false;
        private double randomNumber = 0;
        private bool ShowApproverLinks = false;

        // variables for generic functions
        string ReturnValue_1_str_1;
        //


        //private ERPEnhancementsC_DAL.PettyCashRequest_DAL objMR = new ERPEnhancementsC_DAL.PettyCashRequest_DAL();
        public Collection eServiceWorkflowInfo
        {
            get { return m_eServiceWorkflowInfo; }
            set { m_eServiceWorkflowInfo = value; }
        }

        public string ReturnValue_1_String(string sql_query)
        {
            if (OpenConnection())
            {
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = sql_query;
                ReturnValue_1_str_1 = sqlComm.ExecuteScalar().ToString();
            }
            CloseConnection();
            return ReturnValue_1_str_1;
        }
        public DataTable ReturnValue_2_DataTable(string sql_query)
        {
            if (OpenConnection())
            {
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = sql_query;
                sqlAdpt.Dispose();
                sqlAdpt.Fill(dtable);
            }
            CloseConnection();
            return dtable;
        }

        public void ReturnValue_3(string sql_query)
        {
            if (OpenConnection())
            {
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = sql_query;
                sqlComm.ExecuteNonQuery();
            }
            CloseConnection();
        }

        public string Workflow_CheckAttachments(string docid)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;
            string ServiceName = "";

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                //eServiceWorkflowInfo["eServiceID"]
                //eServiceWorkflowInfo["DocumentNumber"];

                SQL = " if ( 0 <(select count(*) from GCAA_ESS_Leave_Attachments_PettyCash WHERE REQUESTID  = '" + docid + "' )) ";
                SQL += "   BEGIN SELECT 'true' END ";
                SQL += "   ELSE ";
                SQL += "   BEGIN SELECT 'false' END ";


                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);
                if (dt.Tables[0].Rows.Count > 0)
                {
                    ServiceName = dt.Tables[0].Rows[0][0].ToString();
                }

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return ServiceName;
        }
        public bool RejectDocumentWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            if (OpenConnection())
            {
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.CommandText = "stpRejectDocumentWorkflow";
                sqlComm.Parameters.Clear();
                sqlComm.Parameters.Add("@eServiceID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@WorkflowID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@DocumentNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@ActionBy", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Comments", SqlDbType.VarChar, 500);
                sqlComm.Parameters.Add("@StepNumber", SqlDbType.Decimal);

                sqlComm.Parameters["@eServiceID"].Value = eServiceWorkflowInfo["eServiceID"];
                sqlComm.Parameters["@WorkflowID"].Value = eServiceWorkflowInfo["WorkflowID"];
                sqlComm.Parameters["@DocumentNumber"].Value = eServiceWorkflowInfo["DocumentNumber"];
                sqlComm.Parameters["@ActionBy"].Value = eServiceWorkflowInfo["CurrentUserId"];
                sqlComm.Parameters["@Comments"].Value = eServiceWorkflowInfo["Comments"];
                sqlComm.Parameters["@StepNumber"].Value = Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]) + 1;

                sqlComm.ExecuteNonQuery();
                // Send Next User EMail if agreed

                functionReturnValue = true;

            }
            CloseConnection();
            return functionReturnValue;
        }


        public DataSet ReturnWorkflowDetailsComplete()
        {
            DataSet functionReturnValue = null;
            functionReturnValue = null;
            if (OpenConnection())
            {
                SQL = "SELECT ";
                SQL += " StepNumber as SerialNo,";
                SQL += " 'true' As RecCounter,";
                SQL += " AD.DisplayName + ' - ' + ActionBy   As UserID,";
                //SQL += "ActionBy   As UserID,";
                SQL += " RTRIM([Action]) + '<br/><i style=' + char(39) + 'font-weight: normal;' + char(39) + '>Action Date & Time: ' + CAST(ActionDate AS VARCHAR(30)) + '</i>' As [Action],";
                SQL += " Comments, StepNumber";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " union all";
                SQL += " SELECT ";
                SQL += " StepNumber,";
                SQL += " 'false' As RecCounter,";
                SQL += " CASE WHEN RoleID IS NOT NULL THEN DBO.GetRoleUserDetails(RoleID) ELSE ";
                SQL += " ISNULL(DefaultValue, '') END As UserID,";
                SQL += " 'Pending Approval: ' + RTRIM([ActionType]) + '<br/><i style=' + char(39) + 'font-weight: normal;' + char(39) + '>Action Date & Time: N/A</i>' As [Action],";
                SQL += " '' Comments, StepNumber";
                SQL += " FROM GCAWF0010111 WF";
                //SQL &= " --LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName"
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "'";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "'";
                SQL += " AND StepNumber NOT IN (SELECT StepNumber FROM GCAWF0010120 ";
                SQL += " WHERE  eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "'";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "')";
                SQL += " ORDER BY 1";

                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();

                sqlAdpt = null;
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt;

            }
            CloseConnection();
            return functionReturnValue;

        }
        public bool wfRejectWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            //DepositRRequest_DAL DRR = new DepositRRequest_DAL();
            //DepositRequest_DAL DR = new DepositRequest_DAL();
            //BankGuaranteesRequest_DAL BG = new BankGuaranteesRequest_DAL();
            //BankGuaranteesRRequest_DAL BR = new BankGuaranteesRRequest_DAL();
            //SupplierReconciliationRequest_DAL SR = new SupplierReconciliationRequest_DAL();
            //PerDiemRequest_DAL PD = new PerDiemRequest_DAL();
            //PrePaymentsRequest_DAL PP = new PrePaymentsRequest_DAL();
            //RecruitmentRequisitionRequest_DAL RR = new RecruitmentRequisitionRequest_DAL();
            //TrainingRequest_DAL TR = new TrainingRequest_DAL();
            //ApplicantInterviewsRequest_DAL AI = new ApplicantInterviewsRequest_DAL();
            //PublishRequest_DAL PB = new PublishRequest_DAL();
            //ContractSetup_DAL CS = new ContractSetup_DAL();

            switch (eServiceWorkflowInfo["eServiceId"].ToString())
            {
                //case "FI08Deposit":
                //    if (RejectDocumentWorkflow())
                //    {
                //        DR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI08DepositR":
                //    if (RejectDocumentWorkflow())
                //    {
                //        DRR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI06BankGuarantees":
                //    if (RejectDocumentWorkflow())
                //    {
                //        BG.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI06BankGuaranteesR":
                //    if (RejectDocumentWorkflow())
                //    {
                //        BR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI03SupplierReconciliation":
                //    if (RejectDocumentWorkflow())
                //    {
                //        DRR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI05PerDiem":
                //    if (RejectDocumentWorkflow())
                //    {
                //        PD.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI07PrePayments":
                //    if (RejectDocumentWorkflow())
                //    {
                //        PP.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "HC11RecruitmentRequisition":
                //    if (RejectDocumentWorkflow())
                //    {
                //        RR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "TR12TrainingRequest":
                //    if (RejectDocumentWorkflow())
                //    {
                //        TR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "HC09ApplicantInterviews":
                //    if (RejectDocumentWorkflow())
                //    {
                //        AI.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "VM06PublishRequest":
                //    if (RejectDocumentWorkflow())
                //    {
                //        PB.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "VM08ContractSetup":
                //    if (RejectDocumentWorkflow())
                //    {
                //        //CS.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //        CS.SendEMail("Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                default:
                    if (RejectDocumentWorkflow())
                    {
                        SendEMail_Pettycash(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject");
                    }
                    break;
            }
            functionReturnValue = true;
            return functionReturnValue;

        }
        public bool wfFinanceEmail()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            if (RejectDocumentWorkflow())
            {
                SendEMail_Pettycash(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject");
            }

            functionReturnValue = true;
            return functionReturnValue;
        }
        public bool wfApproveWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            //DepositRRequest_DAL DRR = new DepositRRequest_DAL();
            //DepositRequest_DAL DR = new DepositRequest_DAL();
            //BankGuaranteesRequest_DAL BG = new BankGuaranteesRequest_DAL();
            //BankGuaranteesRRequest_DAL BR = new BankGuaranteesRRequest_DAL();
            //SupplierReconciliationRequest_DAL SR = new SupplierReconciliationRequest_DAL();
            //PerDiemRequest_DAL PD = new PerDiemRequest_DAL();
            //PrePaymentsRequest_DAL PP = new PrePaymentsRequest_DAL();
            //RecruitmentRequisitionRequest_DAL RR = new RecruitmentRequisitionRequest_DAL();
            //TrainingRequest_DAL TR = new TrainingRequest_DAL();
            //ApplicantInterviewsRequest_DAL AI = new ApplicantInterviewsRequest_DAL();
            //PublishRequest_DAL PB = new PublishRequest_DAL();
            //ContractSetup_DAL CS = new ContractSetup_DAL();

            switch (eServiceWorkflowInfo["eServiceId"].ToString())
            {
                //case "FI08Deposit":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        DR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI08DepositR":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        DRR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI06BankGuarantees":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        BG.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI06BankGuaranteesR":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        BR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI03SupplierReconciliation":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        DRR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI05PerDiem":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        PD.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "FI07PrePayments":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        PP.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "HC11RecruitmentRequisition":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        RR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "TR12TrainingRequest":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        TR.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "HC09ApplicantInterviews":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        AI.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "VM06PublishRequest":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        PB.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                //case "VM08ContractSetup":
                //    if (ApproveDocumentWorkflow())
                //    {
                //        //CS.SendEMail(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Reject", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //        CS.SendEMail("Approve", eServiceWorkflowInfo["LineManagerEmail"].ToString(), eServiceWorkflowInfo["ADGEmail"].ToString(), eServiceWorkflowInfo["eServiceId"].ToString(), eServiceWorkflowInfo["WorkflowID"].ToString(), eServiceWorkflowInfo["DocumentNumber"].ToString(), eServiceWorkflowInfo["CurrentUserId"].ToString(), Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]));
                //    }
                //    break;
                default:
                    if (ApproveDocumentWorkflow())
                    {
                        SendEMail_Pettycash(eServiceWorkflowInfo["eServiceId"] + "_" + eServiceWorkflowInfo["WorkflowID"] + "_" + "Approve");
                    }
                    break;
            }
            functionReturnValue = true;
            return functionReturnValue;
        }
        public bool SendEMail(string _eMailID)
        {
            AlternateView avHtml;
            LinkedResource pic1;
            MailMessage objEmail = new MailMessage();
            string strhost = "192.168.0.150";
            //"smtprelay.gcaa-uae.gov"
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("spsadmin", "gcaa");
            SmtpClient sc = new SmtpClient(strhost);
            string MailBody = "";
            string m_AttachFile = "";
            string mFilePath = "d:\\temp\\" + _eMailID + ".jpeg";
            string ToEmail = "";
            Random rndNum = new Random();
            string eMailID = "";

            switch (_eMailID)
            {
                case "PR01MaterialRequest_PR0101_Submit":
                    eMailID = "PR01MaterialRequest_PR0101_Submit";
                    ToEmail = ReturnToEmailAddress("Submit", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    randomNumber = rndNum.NextDouble();

                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA Material Request");
                    objEmail.Subject = "You have received a new material request for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Approver");

                    avHtml = AlternateView.CreateAlternateViewFromString(MailBody, null, MediaTypeNames.Text.Html);
                    pic1 = new LinkedResource(ServerMapPath + "\\Images\\MR Graphs\\" + eServiceWorkflowInfo["DocumentNumber"].ToString() + ".jpeg", MediaTypeNames.Image.Jpeg);
                    pic1.ContentId = "Pic1" + randomNumber.ToString().Replace("0.", "");
                    avHtml.LinkedResources.Add(pic1);
                    //objEmail.AlternateViews.Add(avHtml);
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    sc.UseDefaultCredentials = true;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Submit", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA Material Request");
                    objEmail.Subject = "Your material request has been submitted for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Requester");

                    AlternateView avHtml1 = AlternateView.CreateAlternateViewFromString(MailBody, null, MediaTypeNames.Text.Html);
                    LinkedResource pic11 = new LinkedResource(ServerMapPath + "\\Images\\MR Graphs\\" + eServiceWorkflowInfo["DocumentNumber"].ToString() + ".jpeg", MediaTypeNames.Image.Jpeg);
                    pic11.ContentId = "Pic1" + randomNumber.ToString().Replace("0.", "");
                    avHtml1.LinkedResources.Add(pic11);
                    //objEmail.AlternateViews.Add(avHtml1);
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    sc.UseDefaultCredentials = true;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                    }

                    break;
                case "PR01MaterialRequest_PR0101_Approve":
                    eMailID = "PR01MaterialRequest_PR0101_Approve";

                    ToEmail = ReturnToEmailAddress("Approve", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    //if (!string.IsNullOrEmpty(ToEmail))
                    //    ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    if (!string.IsNullOrEmpty(ToEmail))
                    {
                        randomNumber = rndNum.NextDouble();

                        objEmail.To.Add(ToEmail);
                        objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
                        objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA Material Request");
                        objEmail.Subject = "You have received a new material request for approval !";
                        MailBody = ReturnBodyText(eMailID, "Approve_Approver");

                        avHtml = AlternateView.CreateAlternateViewFromString(MailBody, null, MediaTypeNames.Text.Html);
                        pic1 = new LinkedResource(ServerMapPath + "\\Images\\MR Graphs\\" + eServiceWorkflowInfo["DocumentNumber"].ToString() + ".jpeg", MediaTypeNames.Image.Jpeg);
                        pic1.ContentId = "Pic1" + randomNumber.ToString().Replace("0.", "");
                        avHtml.LinkedResources.Add(pic1);
                        //objEmail.AlternateViews.Add(avHtml);
                        objEmail.IsBodyHtml = true;
                        objEmail.Priority = MailPriority.High;
                        sc.UseDefaultCredentials = true;
                        if (objEmail.To.Count > 0 & (objEmail.From != null))
                        {
                            sc.Send(objEmail);
                        }
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Approve", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA Material Request");
                    objEmail.Subject = "Your material request has been approved !";
                    MailBody = ReturnBodyText(eMailID, "Approve_Requester");

                    avHtml1 = AlternateView.CreateAlternateViewFromString(MailBody, null, MediaTypeNames.Text.Html);
                    pic11 = new LinkedResource(ServerMapPath + "\\Images\\MR Graphs\\" + eServiceWorkflowInfo["DocumentNumber"].ToString() + ".jpeg", MediaTypeNames.Image.Jpeg);
                    pic11.ContentId = "Pic1" + randomNumber.ToString().Replace("0.", "");
                    avHtml1.LinkedResources.Add(pic11);
                    //objEmail.AlternateViews.Add(avHtml1);
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    sc.UseDefaultCredentials = true;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                    }

                    break;
                case "PR01MaterialRequest_PR0101_Reject":
                    eMailID = "PR01MaterialRequest_PR0101_Reject";
                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Reject", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA Material Request");
                    objEmail.Subject = "Your material request has been rejected !";
                    MailBody = ReturnBodyText(eMailID, "Reject_Requester");

                    avHtml1 = AlternateView.CreateAlternateViewFromString(MailBody, null, MediaTypeNames.Text.Html);
                    pic11 = new LinkedResource(ServerMapPath + "\\Images\\MR Graphs\\" + eServiceWorkflowInfo["DocumentNumber"].ToString() + ".jpeg", MediaTypeNames.Image.Jpeg);
                    pic11.ContentId = "Pic1" + randomNumber.ToString().Replace("0.", "");
                    avHtml1.LinkedResources.Add(pic11);
                    //objEmail.AlternateViews.Add(avHtml1);
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    sc.UseDefaultCredentials = true;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                    }

                    break;


            }
            return true;

        }

        public bool SendEMail_Pettycash_FinanceEmail(string batchnumber, string _eMailID)
        {
            AlternateView avHtml;
            LinkedResource pic1;
            MailMessage objEmail = new MailMessage();
            string strhost = "192.168.0.150";
            //string strhost = "192.168.0.150";
            //string strhost = "smtp.gcaa.ae";
            //"smtprelay.gcaa-uae.gov"
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("spsadmin", "gcaa");
            SmtpClient sc = new SmtpClient(strhost);
            string MailBody = "";
            string m_AttachFile = "";
            string mFilePath = "d:\\temp\\" + _eMailID + ".jpeg";
            string ToEmail = "";
            Random rndNum = new Random();
            string eMailID = "";

            eMailID = "AD01PettyCash_PC0101_FinanceEmail";
            objEmail = null;
            objEmail = new MailMessage();
            ToEmail = ReturnToEmailAddressFinanceEmail();
            //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
            objEmail.To.Add(ToEmail);
            objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
            objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA PA Batch Created - Petty Cash");
            objEmail.Subject = "A petty cash batch has been created !";
            MailBody = ReturnBodyTextFinanceEmail(eMailID, "Reject_Requester", batchnumber);

            objEmail.IsBodyHtml = true;
            objEmail.Priority = MailPriority.High;
            sc.Credentials = credentials;
            objEmail.Body = MailBody;
            if (objEmail.To.Count > 0 & (objEmail.From != null))
            {
                sc.Send(objEmail);

            }

            eMailID = "AD01PettyCash_PC0101_FinanceEmail";
            objEmail = null;
            objEmail = new MailMessage();
            ToEmail = ReturnToEmailAddressFinanceEmailCC(batchnumber);
            //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
            objEmail.To.Add(ToEmail);
            objEmail.Bcc.Add("mulkarim@gcaa.gov.ae");
            objEmail.From = new MailAddress("mdgpadmin@gcaa.gov.ae", "GCAA PA Batch Created - Petty Cash");
            objEmail.Subject = "A petty cash batch has been created !";
            MailBody = ReturnBodyTextFinanceEmail(eMailID, "Reject_Requester", batchnumber);

            objEmail.IsBodyHtml = true;
            objEmail.Priority = MailPriority.High;
            sc.Credentials = credentials;
            objEmail.Body = MailBody;
            if (objEmail.To.Count > 0 & (objEmail.From != null))
            {
                sc.Send(objEmail);

            }
            return true;
        }

        private string ReturnToEmailAddressFinanceEmailCC(string batchnumber)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            if (OpenConnection())
            {
                SQL = " SELECT TOP 1 AD.EmailAddress from GCAPC0110110 ";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON GCAPC0110110.IntegratedBy = AD.LoginName ";
                SQL += " WHERE GCAPC0110110.PettyCashBatchNumber = '" + batchnumber + "' ";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        functionReturnValue += sqlDr[0].ToString() + ",";
                    }
                }
                sqlDr.Close();
                if (!string.IsNullOrEmpty(functionReturnValue))
                {
                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool SendEMail_TransportRequest_RV(string batchnumber, string _eMailID)
        {
            AlternateView avHtml;
            LinkedResource pic1;
            MailMessage objEmail = new MailMessage();
            string strhost = "192.168.0.150";
            //string strhost = "smtp.gcaa.ae";
            //"smtprelay.gcaa-uae.gov"
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("spsadmin", "gcaa");
            SmtpClient sc = new SmtpClient(strhost);
            string MailBody = "";
            string m_AttachFile = "";
            string mFilePath = "d:\\temp\\" + _eMailID + ".jpeg";
            Random rndNum = new Random();
            string eMailID = "";

            eMailID = "AD02TransportRequest_VR0201_RV";
            objEmail = null;
            objEmail = new MailMessage();
            string ToEmail = ReturnToEmailAddressTR_RV(batchnumber);
            //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
            objEmail.To.Add(ToEmail);
            objEmail.Bcc.Add("asantra@gcaa.gov.ae");
            objEmail.From = new MailAddress("gcaafms@gcaa.gov.ae", "Transport Request");
            objEmail.Subject = "Transport Request vehicle returned !";
            MailBody = ReturnBodyTextTransportRequest(eMailID, "Reject_Requester", batchnumber);

            objEmail.IsBodyHtml = true;
            objEmail.Priority = MailPriority.High;
            sc.Credentials = credentials;
            objEmail.Body = MailBody;
            if (objEmail.To.Count > 0 & (objEmail.From != null))
            {
                sc.Send(objEmail);
            }
            return true;
        }

        public bool SendEMail_Pettycash(string _eMailID)
        {
            AlternateView avHtml;
            LinkedResource pic1;
            MailMessage objEmail = new MailMessage();
            string strhost = ConfigurationManager.AppSettings[""];
            //string strhost = "192.168.0.150";
            //string strhost = "smtp.gcaa.ae";
            //"smtprelay.gcaa-uae.gov"
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("spsadmin", "gcaa");
            SmtpClient sc = new SmtpClient(strhost);
            string MailBody = "";
            string m_AttachFile = "";
            string mFilePath = "d:\\temp\\" + _eMailID + ".jpeg";
            string ToEmail = "";
            Random rndNum = new Random();
            string eMailID = "";

            if (_eMailID.Contains("VM08ContractSetup") && _eMailID.Contains("Approve"))
            {
                _eMailID = "VM08ContractSetup_Approve";
            }

            if (_eMailID.Contains("VM08ContractSetup") && _eMailID.Contains("Submit"))
            {
                _eMailID = "VM08ContractSetup_Submit";
            }

            if (_eMailID.Contains("VM08ContractSetup") && _eMailID.Contains("Reject"))
            {
                _eMailID = "VM08ContractSetup_Reject";
            }

            switch (_eMailID)
            {
                case "AD02Transport_VR0201_Submit":
                    eMailID = "AD02Transport_VR0201_Submit";
                    ToEmail = ReturnToEmailAddress("Submit", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    else if (ToEmail == "ADG")
                    {
                        ToEmail = eServiceWorkflowInfo["ADGEmail"].ToString();
                    }
                    randomNumber = rndNum.NextDouble();

                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Transport Request");
                    objEmail.Subject = "[UAT] - You have received a new transport request for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Approver");

                    
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Submit", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Transport Request");
                    objEmail.Subject = "[UAT] - Your transport request has been submitted for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Requester");

                    
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;
                case "AD02Transport_VR0201_Approve":
                    eMailID = "AD02Transport_VR0201_Approve";

                    ToEmail = ReturnToEmailAddress("Approve", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    else if (ToEmail == "ADG")
                    {
                        ToEmail = eServiceWorkflowInfo["ADGEmail"].ToString();
                    }
                    //if (!string.IsNullOrEmpty(ToEmail))
                    //    ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    if (!string.IsNullOrEmpty(ToEmail))
                    {
                        randomNumber = rndNum.NextDouble();

                        objEmail.To.Add(ToEmail);
                        objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                        objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Transport Request");
                        objEmail.Subject = "[UAT] - You have received a new transport request for approval !";
                        MailBody = ReturnBodyText(eMailID, "Approve_Approver");

                       
                        objEmail.IsBodyHtml = true;
                        objEmail.Priority = MailPriority.High;
                        //sc.UseDefaultCredentials = true;
                        sc.Credentials = credentials;
                        objEmail.Body = MailBody;
                        if (objEmail.To.Count > 0 & (objEmail.From != null))
                        {
                            sc.Send(objEmail);
                            Logger.WriteMessage("Email sent to: " + ToEmail);
                        }
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Approve", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Transport Request");
                    objEmail.Subject = "[UAT] - Your transport request has been approved !";
                    MailBody = ReturnBodyText(eMailID, "Approve_Requester");

                    
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;
                case "AD02Transport_VR0201_Reject":
                    eMailID = "AD02Transport_VR0201_Reject";
                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Reject", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Transport Request");
                    objEmail.Subject = "[UAT] - Your transport request has been rejected !";
                    MailBody = ReturnBodyText(eMailID, "Reject_Requester");

                    
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;

                case "AD07VehicleMaintenance_VT0701_Submit":
                    eMailID = "AD07VehicleMaintenance_VT0701_Submit";
                    ToEmail = ReturnToEmailAddress("Submit", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    else if (ToEmail == "ADG")
                    {
                        ToEmail = eServiceWorkflowInfo["ADGEmail"].ToString();
                    }
                    randomNumber = rndNum.NextDouble();

                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Vehicle Maintenance Request");
                    objEmail.Subject = "[UAT] - You have received a vehicle maintenance request for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Approver");

                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Submit", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Vehicle Maintenance Request");
                    objEmail.Subject = "[UAT] - Your vehicle request has been submitted for approval !";
                    MailBody = ReturnBodyText(eMailID, "Submit_Requester");

                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;
                case "AD07VehicleMaintenance_VT0701_Approve":
                    eMailID = "AD07VehicleMaintenance_VT0701_Approve";

                    ToEmail = ReturnToEmailAddress("Approve", "Approver");
                    if (ToEmail == "Line Manager")
                    {
                        ToEmail = eServiceWorkflowInfo["LineManagerEmail"].ToString();
                    }
                    else if (ToEmail == "ADG")
                    {
                        ToEmail = eServiceWorkflowInfo["ADGEmail"].ToString();
                    }
                    //if (!string.IsNullOrEmpty(ToEmail))
                    //    ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    if (!string.IsNullOrEmpty(ToEmail))
                    {
                        randomNumber = rndNum.NextDouble();

                        objEmail.To.Add(ToEmail);
                        objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                        objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Vehicle Maintenance Request");
                        objEmail.Subject = "[UAT] - You have received a new vehicle maintenance request for approval !";
                        MailBody = ReturnBodyText(eMailID, "Approve_Approver");

                        objEmail.IsBodyHtml = true;
                        objEmail.Priority = MailPriority.High;
                        //sc.UseDefaultCredentials = true;
                        sc.Credentials = credentials;
                        objEmail.Body = MailBody;
                        if (objEmail.To.Count > 0 & (objEmail.From != null))
                        {
                            sc.Send(objEmail);
                            Logger.WriteMessage("Email sent to: " + ToEmail);
                        }
                    }

                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Approve", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Vehicle Maintenance Request");
                    objEmail.Subject = "[UAT] - Your vehicle maintenance request has been approved !";
                    MailBody = ReturnBodyText(eMailID, "Approve_Requester");

                    
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;
                case "AD07VehicleMaintenance_VT0701_Reject":
                    eMailID = "AD07VehicleMaintenance_VT0701_Reject";
                    objEmail = null;
                    objEmail = new MailMessage();
                    ToEmail = ReturnToEmailAddress("Reject", "Requester");
                    //ToEmail = "shaider@gcaa.gov.ae,mulkarim@gcaa.gov.ae";
                    objEmail.To.Add(ToEmail);
                    objEmail.Bcc.Add("asantra@gcaa.gov.ae");
                    objEmail.From = new MailAddress("mdgpadminuat@gcaa.gov.ae", "[UAT] GCAA Vehicle Maintenance Request");
                    objEmail.Subject = "[UAT] - Your vehicle maintenance request has been rejected !";
                    MailBody = ReturnBodyText(eMailID, "Reject_Requester");

                  
                    objEmail.IsBodyHtml = true;
                    objEmail.Priority = MailPriority.High;
                    //sc.UseDefaultCredentials = true;
                    sc.Credentials = credentials;
                    objEmail.Body = MailBody;
                    if (objEmail.To.Count > 0 & (objEmail.From != null))
                    {
                        sc.Send(objEmail);
                        Logger.WriteMessage("Email sent to: " + ToEmail);
                    }

                    break;

            }
            return true;

        }

        private string ReturnToEmailAddress(string _ActionID, string _EMailType)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            if (OpenConnection())
            {
                if (_ActionID + "_" + _EMailType == "Submit_Requester" | _ActionID + "_" + _EMailType == "Approve_Requester" | _ActionID + "_" + _EMailType == "Reject_Requester")
                {
                    SQL = " SELECT AD.EmailAddress";
                    SQL += " FROM GCAWF0010120 WF";
                    SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                    SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                    SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                    SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                    SQL += " AND StepNumber = 1";
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    sqlComm.CommandText = SQL;
                    functionReturnValue = sqlComm.ExecuteScalar().ToString();
                }
                if (_ActionID + "_" + _EMailType == "Submit_Approver" | _ActionID + "_" + _EMailType == "Approve_Approver")
                {
                    string UserID = "";
                    SQL = "SELECT ";
                    SQL += " CASE WHEN UserID IS NULL THEN ";
                    SQL += " CASE WHEN RoleID IS NULL THEN 'DEF' + DefaultValue ELSE 'ROL' + RoleID END ";
                    SQL += " Else 'UID' + UserID END AS USERID";
                    SQL += "  FROM GCAWF0010111";
                    SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                    SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                    if (_ActionID == "Submit")
                    {
                        SQL += " AND StepNumber = 2";
                    }
                    else
                    {
                        //int sum_ = Convert.ToInt32(eServiceWorkflowInfo["StepNumber"]) + 2;
                        //SQL += " AND StepNumber = " + sum_;
                        // code changes from here above line commented, below block added
                        SQL += " AND StepNumber = ";
                        SQL += " (SELECT TOP 1 WF.StepNumber ";
                        SQL += " FROM GCAWF0010120 WF";
                        SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                        SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                        SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                        SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                        SQL += " ORDER BY StepNumber DESC) + 1 ";
                    }
                    sqlComm = null;
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    sqlComm.CommandText = SQL;
                    UserID = Convert.ToString(sqlComm.ExecuteScalar());
                    if (!string.IsNullOrEmpty(UserID))
                    {
                        switch (Strings.Left(UserID, 3))
                        {
                            case "DEF":
                                if (UserID.Replace("DEF", "") == "Line Manager")
                                {
                                    functionReturnValue = UserID.Replace("DEF", "");
                                }
                                else if (UserID.Replace("DEF", "") == "ADG")
                                {
                                    functionReturnValue = UserID.Replace("DEF", "");
                                }
                                break;
                            case "ROL":
                                SQL = "SELECT AD.EmailAddress";
                                SQL += " FROM GCAWF0010110 WF";
                                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.UserID = AD.LoginName";
                                SQL += " WHERE RoleID = '" + UserID.Replace("ROL", "") + "' ";
                                sqlComm = null;
                                sqlComm = new SqlCommand();
                                sqlComm.Connection = sqlConn;
                                sqlComm.CommandType = CommandType.Text;
                                sqlComm.CommandText = SQL;
                                sqlDr = sqlComm.ExecuteReader();
                                if (sqlDr.HasRows)
                                {
                                    while (sqlDr.Read())
                                    {
                                        functionReturnValue += sqlDr[0].ToString() + ",";
                                    }
                                }
                                sqlDr.Close();
                                if (!string.IsNullOrEmpty(functionReturnValue))
                                {
                                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                                }
                                break;
                            case "UID":
                                if (UserID.Replace("UID", "") == eServiceWorkflowInfo["CurrentUserId"])
                                {
                                    SQL = "SELECT EmailAddress";
                                    SQL += " FROM GCAA_ESS_ActiveDirectoryUsersList ";
                                    SQL += " WHERE LoginName = '" + UserID.Replace("UID", "") + "' ";
                                    sqlComm = null;
                                    sqlComm = new SqlCommand();
                                    sqlComm.Connection = sqlConn;
                                    sqlComm.CommandType = CommandType.Text;
                                    sqlComm.CommandText = SQL;
                                    functionReturnValue = sqlComm.ExecuteScalar().ToString();
                                }
                                break;
                        }
                    }
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        private string ReturnToEmailAddressFinanceEmail()
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            if (OpenConnection())
            {
                SQL = "SELECT AD.EmailAddress";
                SQL += " FROM GCAWF0010110 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.UserID = AD.LoginName";
                SQL += " WHERE RoleID = 'FinanceUsers' ";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        functionReturnValue += sqlDr[0].ToString() + ",";
                    }
                }
                sqlDr.Close();
                if (!string.IsNullOrEmpty(functionReturnValue))
                {
                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                }
            }
            CloseConnection();
            return functionReturnValue;
        }
        private string ReturnVisaServiceStepNumber()
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            if (OpenConnection())
            {
                SQL = "SELECT ISNULL(MAX(StepNumber),0) FROM GCAWF0010120 where documentnumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        functionReturnValue = sqlDr[0].ToString();
                    }
                }
                sqlDr.Close();
            }
            CloseConnection();
            return functionReturnValue;
        }
        private string ReturnToEmailAddressTR_RV(string doc)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            if (OpenConnection())
            {
                SQL = "SELECT AD.EmailAddress";
                SQL += " FROM GCAWF0010110 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.UserID = AD.LoginName";
                SQL += " WHERE RoleID = 'VR02' ";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        functionReturnValue += sqlDr[0].ToString() + ",";
                    }
                }
                sqlDr.Close();

                SQL = "SELECT Email";
                SQL += " FROM GCAAD0210101 ";
                SQL += " WHERE DocumentID = '" + doc + "' ";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        functionReturnValue += sqlDr[0].ToString() + ",";
                    }
                }
                sqlDr.Close();
                if (!string.IsNullOrEmpty(functionReturnValue))
                {
                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        private bool CloseConnection()
        {
            bool functionReturnValue = false;
            try
            {
                if (sqlConn == null)
                {
                    functionReturnValue = true;
                    return functionReturnValue;
                }
                if (sqlConn.State == ConnectionState.Open)
                {
                    sqlConn.Close();
                    sqlConn.Dispose();
                    functionReturnValue = true;
                }
            }
            catch (Exception ex)
            {
                functionReturnValue = false;
            }
            return functionReturnValue;
        }

        private bool OpenConnection()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            sqlConn = new SqlConnection();
            //Provider = "Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=;Password=;";
            Provider = ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString;
            sqlConn.ConnectionString = Provider;
            sqlConn.Open();
            functionReturnValue = true;
            return functionReturnValue;
        }

        public DataSet ReturnWorkflowDetails()
        {
            DataSet functionReturnValue = default(DataSet);
            functionReturnValue = null;
            if (OpenConnection())
            {
                SQL = "SELECT ";
                SQL += " SerialNo,";
                SQL += " 1 As RecCounter,";
                SQL += " AD.DisplayName + ' - ' + ActionBy   As UserID,";
                SQL += " RTRIM([Action]) + '<br/><i style=' + char(39) + 'font-weight: normal;' + char(39) + '>Action Date & Time: ' + CAST(ActionDate AS VARCHAR(30)) + '</i>' As [Action],";
                SQL += " Comments, StepNumber";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY SerialNo";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = null;
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);
                functionReturnValue = dt;
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool isUserAllowedToSubmit()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            string UserId = "";
            if (OpenConnection())
            {
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = "SELECT ActionBy ";
                SQL += " FROM GCAWF0010120";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " AND StepNumber = 1";
                sqlComm.CommandText = SQL;
                UserId = sqlComm.ExecuteScalar().ToString();
                if (UserId == eServiceWorkflowInfo["CurrentUserId"])
                {
                    functionReturnValue = true;
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool isUserAllowedToApproveReject()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            Int16 CurrentStepNumber = 0;
            Int16 NextStepNumber = 0;
            string UserId = "";
            string LastStepUserID = "";
            string LineManagerUserID = "";
            if (OpenConnection())
            {
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = "SELECT Top 1 StepNumber AS StepNumber";
                SQL += " FROM GCAWF0010120";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY SerialNo Desc";
                sqlComm.CommandText = SQL;
                CurrentStepNumber = Convert.ToInt16(sqlComm.ExecuteScalar().ToString());
                NextStepNumber = Convert.ToInt16(CurrentStepNumber + 1);
                SQL = "SELECT ";
                SQL += " CASE WHEN UserID IS NULL THEN ";
                SQL += " CASE WHEN RoleID IS NULL THEN 'DEF' + DefaultValue ELSE 'ROL' + RoleID END ";
                SQL += " Else 'UID' + UserID END AS USERID";
                SQL += " FROM GCAWF0010111";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND StepNumber = " + NextStepNumber;
                sqlComm.CommandText = SQL;
                if (sqlComm.ExecuteScalar() == null)
                {
                    UserId = "";
                }
                else
                {
                    UserId = sqlComm.ExecuteScalar().ToString();
                }
                if (!string.IsNullOrEmpty(UserId))
                {
                    switch (Strings.Left(UserId, 3))
                    {
                        case "DEF":
                            if (UserId.Replace("DEF", "") == "Employee")
                            {
                                functionReturnValue = true;
                            }
                            else if (UserId.Replace("DEF", "") == "Line Manager")
                            {
                                // Is current user line manager for submitted user
                                SQL = "SELECT ActionBy AS StepNumber";
                                SQL += " FROM GCAWF0010120";
                                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                                SQL += " AND StepNumber = " + CurrentStepNumber;
                                sqlComm.CommandText = SQL;
                                if (sqlComm.ExecuteScalar() == null)
                                {
                                    LastStepUserID = "";
                                }
                                else
                                {
                                    LastStepUserID = sqlComm.ExecuteScalar().ToString();
                                }
                                SQL = "SELECT LoginName FROM GCAA_ESS_ActiveDirectoryUsersList ";
                                SQL += " WHERE DisplayName IN";
                                SQL += " (SELECT LineManagerName FROM GCAA_ESS_ActiveDirectoryUsersList ";
                                SQL += " WHERE LoginName = '" + LastStepUserID + "')";
                                sqlComm.CommandText = SQL;
                                if (sqlComm.ExecuteScalar() == null)
                                {
                                    LineManagerUserID = "";
                                }
                                else
                                {
                                    LineManagerUserID = sqlComm.ExecuteScalar().ToString();
                                }
                                if (LineManagerUserID.ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                                {
                                    functionReturnValue = true;
                                }
                            }
                            else if (UserId.Replace("DEF", "") == "ADG")
                            {
                                SQL = "SELECT ActionBy AS StepNumber";
                                SQL += " FROM GCAWF0010120";
                                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                                SQL += " AND StepNumber = 1";
                                sqlComm.CommandText = SQL;
                                if (sqlComm.ExecuteScalar() == null)
                                {
                                    LastStepUserID = "";
                                }
                                else
                                {
                                    LastStepUserID = sqlComm.ExecuteScalar().ToString();
                                }
                                SQL = " SELECT TOP 1 USERID FROM GCAWF0010110 WHERE RoleID IN (";
                                SQL += "SELECT 'ADG'+RTRIM(GP_DIVCODE) FROM GCAA_COMBINE_API_UPR00100 ";
                                SQL += " WHERE EMAIL IN ";
                                SQL += " (SELECT EMAILADDRESS FROM GCAA_ESS_ActiveDirectoryUsersList ";
                                SQL += " WHERE LoginName = '" + LastStepUserID + "'))";
                                sqlComm.CommandText = SQL;
                                if (sqlComm.ExecuteScalar() == null)
                                {
                                    LineManagerUserID = "";
                                }
                                else
                                {
                                    LineManagerUserID = sqlComm.ExecuteScalar().ToString();
                                }
                                if (LineManagerUserID.ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                                {
                                    functionReturnValue = true;
                                }
                            }
                            break;
                        case "ROL":
                            SQL = "SELECT UserID FROM GCAWF0010110 ";
                            SQL += " WHERE RoleID = '" + UserId.Replace("ROL", "") + "' ";
                            SQL += " AND UserID = '" + eServiceWorkflowInfo["CurrentUserId"] + "'";
                            sqlComm = null;
                            sqlComm = new SqlCommand();
                            sqlComm.Connection = sqlConn;
                            sqlComm.CommandType = CommandType.Text;
                            sqlComm.CommandText = SQL;
                            if (sqlComm.ExecuteScalar() == null)
                            {
                                UserId = "";
                            }
                            else
                            {
                                UserId = sqlComm.ExecuteScalar().ToString();
                            }

                            if (UserId.ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                            {
                                functionReturnValue = true;
                            }
                            break;
                        case "UID":
                            if (UserId.Replace("UID", "").ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                            {
                                functionReturnValue = true;
                            }
                            break;
                    }
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool isWorkflowCompleted()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            string isFinalApprovalDone = "0";
            if (OpenConnection())
            {
                SQL = "SELECT '1' ";
                SQL += " FROM GCAWF0010120";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " AND [Action] = 'Final Approval' ";
                SQL += " ORDER BY SerialNo";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                if (sqlComm.ExecuteScalar() == null)
                {
                    isFinalApprovalDone = "";
                }
                else
                {
                    isFinalApprovalDone = sqlComm.ExecuteScalar().ToString();
                }
                if (isFinalApprovalDone == "1")
                {
                    functionReturnValue = true;
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool isUserAllowedToUseWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            string UserID = "";
            if (OpenConnection())
            {
                SQL = "SELECT ";
                SQL += " CASE WHEN UserID IS NULL THEN ";
                SQL += " CASE WHEN RoleID IS NULL THEN 'DEF' + DefaultValue ELSE 'ROL' + RoleID END ";
                SQL += " Else 'UID' + UserID END AS USERID";
                SQL += "  FROM GCAWF0010111";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND StepNumber = 1";
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                UserID = sqlComm.ExecuteScalar().ToString();
                if (!string.IsNullOrEmpty(UserID))
                {
                    switch (Strings.Left(UserID, 3))
                    {
                        case "DEF":
                            if (UserID.Replace("DEF", "") == "Employee")
                            {
                                functionReturnValue = true;
                            }
                            break;
                        case "ROL":
                            SQL = "SELECT UserID FROM GCAWF0010110 ";
                            SQL += " WHERE RoleID = '" + UserID.Replace("ROL", "") + "' ";
                            SQL += " AND UserID = '" + eServiceWorkflowInfo["CurrentUserId"] + "'";
                            sqlComm = null;
                            sqlComm = new SqlCommand();
                            sqlComm.Connection = sqlConn;
                            sqlComm.CommandType = CommandType.Text;
                            sqlComm.CommandText = SQL;
                            UserID = Convert.ToString(sqlComm.ExecuteScalar());
                            //UserID = sqlComm.ExecuteScalar().ToString();
                            if (UserID.ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                            {
                                functionReturnValue = true;
                            }
                            break;
                        case "UID":
                            if (UserID.Replace("UID", "").ToString() == eServiceWorkflowInfo["CurrentUserId"].ToString())
                            {
                                functionReturnValue = true;
                            }
                            break;
                    }
                }
            }
            CloseConnection();
            return functionReturnValue;
        }

        public bool SubmitDocumentWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            if (OpenConnection())
            {
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.CommandText = "stpSubmitDocumentWorkflow";
                sqlComm.Parameters.Clear();
                sqlComm.Parameters.Add("@eServiceID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@WorkflowID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@DocumentNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@ActionBy", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Comments", SqlDbType.VarChar, 500);
                sqlComm.Parameters["@eServiceID"].Value = eServiceWorkflowInfo["eServiceID"];
                sqlComm.Parameters["@WorkflowID"].Value = eServiceWorkflowInfo["WorkflowID"];
                sqlComm.Parameters["@DocumentNumber"].Value = eServiceWorkflowInfo["DocumentNumber"];
                sqlComm.Parameters["@ActionBy"].Value = eServiceWorkflowInfo["CurrentUserId"];
                sqlComm.Parameters["@Comments"].Value = eServiceWorkflowInfo["Comments"];
                sqlComm.ExecuteNonQuery();
                // Send Next User EMail if agreed
                functionReturnValue = true;
            }
            CloseConnection();
            return functionReturnValue;
        }
        public bool ApproveDocumentWorkflow()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            if (OpenConnection())
            {
                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.CommandText = "stpApproveDocumentWorkflow";
                sqlComm.Parameters.Clear();
                sqlComm.Parameters.Add("@eServiceID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@WorkflowID", SqlDbType.VarChar, 30);
                sqlComm.Parameters.Add("@DocumentNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@ActionBy", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Comments", SqlDbType.VarChar, 500);
                sqlComm.Parameters.Add("@StepNumber", SqlDbType.Decimal);

                sqlComm.Parameters["@eServiceID"].Value = eServiceWorkflowInfo["eServiceID"];
                sqlComm.Parameters["@WorkflowID"].Value = eServiceWorkflowInfo["WorkflowID"];
                sqlComm.Parameters["@DocumentNumber"].Value = eServiceWorkflowInfo["DocumentNumber"];
                sqlComm.Parameters["@ActionBy"].Value = eServiceWorkflowInfo["CurrentUserId"];
                sqlComm.Parameters["@Comments"].Value = eServiceWorkflowInfo["Comments"];
                sqlComm.Parameters["@StepNumber"].Value = eServiceWorkflowInfo["StepNumber"];

                //sqlComm.ExecuteNonQuery();
                // Send Next User EMail if agreed
                //functionReturnValue = true;

                string result = sqlComm.ExecuteScalar().ToString();
                if (result == "True" || result == "1")
                {
                    functionReturnValue = true;
                }
                else
                {
                    functionReturnValue = false;
                }

            }
            CloseConnection();
            return functionReturnValue;
        }

        public string ReturnWorkflowStatus()
        {
            string functionReturnValue = null;
            functionReturnValue = "";

            string isFinalApprovalDone = "0";
            if (OpenConnection())
            {
                SQL = "SELECT TOP 1 [Action] ";
                SQL += " FROM GCAWF0010120";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY SerialNo DESC";

                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;

                //isFinalApprovalDone = sqlComm.ExecuteScalar().ToString();
                isFinalApprovalDone = Convert.ToString(sqlComm.ExecuteScalar());
                functionReturnValue = isFinalApprovalDone;

            }
            CloseConnection();
            return functionReturnValue;

        }

        public string ServerMapPath
        {
            get { return m_ServerMapPath; }
            set { m_ServerMapPath = value; }
        }

        private string ReturnBodyTextFinanceEmail(string _EMailID, string _EmailType, string batchnumber)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string eBody = "";
            string ApprovedLink = "";
            string RejectLink = "";
            string RequestLink = "";
            string httpApprovedLink = "";
            string httpRejectLink = "";
            DataTable _dt = new DataTable();

            string ApproverName = "";
            string DocumentAction = "";

            string LineManagerEmailAddress = "";
            Int16 Rowcount = 0;
            bool OneTimeLoop = true;
            string ImagePath = "";
            Random rnd = new Random();

            randomNumber = rnd.NextDouble();
            if (OpenConnection())
            {
                eBody = "";
                eBody += "<html><body><div style='font-family:Calibri;font-size:11pt;color:Black;'>Greetings,</div><br/>";
                // code changes from here

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                if (sqlDr.IsClosed == false)
                {
                    sqlDr.Close();
                }
                SQL = " select *, CONVERT(Varchar(10), CREATDDT, 103) As CreateDate, Cast(BCHTOTAL as Numeric(18,2)) AS BatAmount from gcaa..SY00500 WHERE BACHNUMB = '" + batchnumber + "' AND BCHSOURC = 'PM_Trxent' ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is new payable batch created.";
                        eBody += " [ " + sqlDr["BACHNUMB"].ToString() + " ].<br/><br/>";

                        eBody += "Batch Details:<br/><br/>";
                        eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                        eBody += "<tr><td >";
                        eBody += "Number of Transactions: </br>Batch Total: </br></br></td><td><B>" + sqlDr["NUMOFTRX"] + "</B><br />";
                        eBody += "<B>" + sqlDr["BatAmount"] + "</B><br /></br>";
                        eBody += "</td>";
                        eBody += "<td >";
                        eBody += "Created Date: </br>Comments: </br></br></td><td><B>" + sqlDr["CreateDate"] + "</B><br />";
                        eBody += "<B>" + sqlDr["BCHCOMNT"] + "</B><br /></br>";
                        eBody += "</td></tr> </table>";
                    }
                }


                if (sqlDr.IsClosed == false)
                {
                    sqlDr.Close();
                }
                SQL = " select *, CONVERT(Varchar(10), DueDate, 103) As DocDueDate, Cast(DOCAMNT as Numeric(18,2)) AS InvAmount from gcaa..PM10000 where BAchnumb = '" + batchnumber + "' AND BCHSOURC = 'PM_Trxent' ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        Rowcount += 1;
                        if (OneTimeLoop)
                        {
                            eBody += "Transaction details:<br/><br/>";
                            eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                            eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Invoice No. </td>";
                            eBody += "<td  style='background-color: #999966;font-weight:bold;'> Document No. </td>";
                            eBody += "<td  style='background-color: #999966;font-weight:bold;'> Vendor. </td>";
                            eBody += "<td  style='background-color: #999966;font-weight:bold;'> Amount </td>";
                            eBody += "<td  style='background-color: #999966;font-weight:bold;'> Due Date </td>";
                            eBody += "<td  style='background-color: #999966;font-weight:bold;'> Currency </td></tr>";

                            OneTimeLoop = false;
                        }


                        if (!(Rowcount % 2 == 1))
                        {
                            eBody += "<tr><td>" + sqlDr["VCHNUMWK"] + "</td>";
                            eBody += "<td>" + sqlDr["DOCNUMBR"] + "</td>";
                            eBody += "<td>" + sqlDr["VENDORID"] + "</td>";
                            eBody += "<td>" + sqlDr["InvAmount"] + "</td>";
                            eBody += "<td>" + sqlDr["DocDueDate"] + "</td>";
                            eBody += "<td>" + sqlDr["CURNCYID"] + "</td></tr>";
                        }
                        else
                        {
                            eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["VCHNUMWK"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["DOCNUMBR"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["VENDORID"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["InvAmount"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["DocDueDate"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["CURNCYID"] + "</td></tr>";
                        }


                    }
                    eBody += "</table>";
                }
                sqlDr.Close();
                eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                eBody += "</div></body></html>";
            }
            return eBody;
        }

        private string ReturnBodyTextTransportRequest(string _EMailID, string _EmailType, string batchnumber)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string eBody = "";
            string ApprovedLink = "";
            string RejectLink = "";
            string RequestLink = "";
            string httpApprovedLink = "";
            string httpRejectLink = "";
            DataTable _dt = new DataTable();

            string ApproverName = "";
            string DocumentAction = "";

            string LineManagerEmailAddress = "";
            Int16 Rowcount = 0;
            bool OneTimeLoop = true;
            string ImagePath = "";
            Random rnd = new Random();

            randomNumber = rnd.NextDouble();
            if (OpenConnection())
            {

                eBody = "";
                eBody += "<html><body><div style='font-family:Calibri;font-size:11pt;color:Black;'>Greetings,</div><br/>";

                // code changes from here

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                if (sqlDr.IsClosed == false)
                {
                    sqlDr.Close();
                }
                SQL = " select *,CONVERT(VARCHAR(10), DepartureDate, 103) AS DepartureDate1,CONVERT(VARCHAR(10), ReturnDate, 103) AS ReturnDate1 from GCAAD0210101 Left outer join GCAAD0210100 ON GCAAD0210101.SelectedVehicleID = GCAAD0210100.DocumentID WHERE GCAAD0210101.DocumentID =  '" + batchnumber + "' ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> The transport request vehicle has been returned.";
                        eBody += " Registration Number:  [ " + sqlDr["RegistrationNumber"].ToString() + " ].<br/><br/>";

                        eBody += "Transaction Details:<br/><br/>";
                        eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                        eBody += "<tr><td >";
                        eBody += "Registration Number: </td><td ><B>" + sqlDr["RegistrationNumber"] + "</td>";
                        eBody += "<td>Requested User: </td><td ><B>" + sqlDr["DisplayName"] + "</td>";
                        eBody += "</tr><tr>";
                        eBody += "<td >";
                        eBody += "Departure Date: </td><td ><B>" + sqlDr["DepartureDate1"] + "</td>";
                        eBody += "<td >Return Date: </td><td ><B>" + sqlDr["ReturnDate1"] + "</td>";
                        eBody += "</td></tr><tr> ";
                        eBody += " <td > ";
                        eBody += "ODO Meter: </td><td ><B>" + sqlDr["ODOMeter"] + "</td>";
                        eBody += "<td>Model: </td><td ><B>" + sqlDr["Model"] + "</td>";
                        eBody += "</tr><tr>";
                        eBody += "<td > ";
                        eBody += "Transport Request No: </td><td ><B>" + batchnumber + "</td>";
                        eBody += "</td></tr>";
                        eBody += "</table>";
                    }
                }

                eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                eBody += "</div></body></html>";
            }
            return eBody;
        }

        private string ReturnBodyText(string _EMailID, string _EmailType)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string eBody = "";
            string ApprovedLink = "";
            string RejectLink = "";
            string RequestLink = "http://gcaaportal/admin/admin/default.aspx";
            string httpApprovedLink = "";
            string httpRejectLink = "";
            DataTable _dt = new DataTable();

            string ApproverName = "";
            string DocumentAction = "";

            string LineManagerEmailAddress = "";
            Int16 Rowcount = 0;
            bool OneTimeLoop = true;
            string ImagePath = "";
            Random rnd = new Random();

            randomNumber = rnd.NextDouble();
            if (OpenConnection())
            {

                eBody = "";
                eBody += "<html><body><div style='font-family:Calibri;font-size:11pt;color:Black;'>Greetings,</div><br/>";

                SQL = " SELECT TOP 1 AD.DisplayName";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY StepNumber DESC";

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                ApproverName = sqlComm.ExecuteScalar().ToString();

                SQL = " SELECT TOP 1 WF.Action";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY StepNumber DESC";
                sqlComm.CommandText = SQL;
                DocumentAction = sqlComm.ExecuteScalar().ToString();

                // code changes from here

                switch (eServiceWorkflowInfo["eServiceId"].ToString().Trim() + "_" + eServiceWorkflowInfo["WorkflowID"].ToString().Trim())
                {

                    //case "AD01PettyCash_PC0101":

                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY ExpenseCode) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " Description,M.VoucherSubject,M.VoucherAmount,Invoiceno,Invoiceamount,Email, M.LineManagerEmail,M.LineManagerName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(12), M.voucherDate, 103) AS DocumentDate,VN.VENDNAME,Name, M.voucherno FROM GCAPC0110110 D ";
                    //    SQL += " LEFT OUTER JOIN GCAPC0110100 M ON M.VoucherNo = D.VoucherNo ";
                    //    SQL += " LEFT OUTER JOIN (SELECT DISTINCT (gcaa..GCAA1002.VENDORID),replace(VENDNAME,'CASH-','')  AS VENDNAME from gcaa..GCAA1002 LEFT OUTER JOIN gcaa..PM00200 ON gcaa..GCAA1002.VENDORID = gcaa..PM00200.VENDORID) VN ";
                    //    SQL += " ON VN.VENDORID = M.Location  ";
                    //    SQL += " LEFT OUTER JOIN (SELECT distinct divcode+'-'+depcode AS CODE, rtrim(DIVSHRTDESC_EN)+'-'+DEPSHRTDESC_EN as NAME FROM			 ";
                    //    SQL += " GCAA_COMBINE_API_UPR00100 where DIVSHRTDESC_EN IS NOT NULL or DEPSHRTDESC_EN IS NOT NULL) DIVDEP ";
                    //    SQL += " ON D.Department_Code = DIVDEP.CODE ";
                    //    SQL += " Where M.VoucherNo  = '" + eServiceWorkflowInfo["DocumentNumber"] + "'  ";
                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApprovePettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectPettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApprovePettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApprovePettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectPettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectPettyCashRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is a petty cash request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your petty cash request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your petty cash request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your petty cash request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                    //                eBody += "<tr><td style='vertical-align:top;'>";
                    //                eBody += "Document ID: </br>Document Date: </br>Location: </br>Created User: <br /><br /></td><td style='vertical-align:top;'><B>" + sqlDr["voucherno"] + "</B><br />";
                    //                eBody += "<B>" + sqlDr["DocumentDate"] + "</B><br />";
                    //                eBody += "<B>" + sqlDr["VENDNAME"] + "</B><br />";
                    //                eBody += "<B>" + sqlDr["displayname"] + "</B><br /><br />";
                    //                eBody += "</td>";
                    //                eBody += "<td  style='vertical-align:top;'>";
                    //                eBody += "Voucher Subject: </br>Voucher Amount: </br>Line Manager: <br /><br /></td style='valign:top;'><td style='vertical-align:top;'><B>" + sqlDr["VoucherSubject"] + "</B><br />";
                    //                eBody += "<B>" + sqlDr["VoucherAmount"] + "</B><br />";
                    //                eBody += "<B>" + sqlDr["LineManagerName"] + "</B><br /><br />";
                    //                eBody += "</td></tr> </table>";
                    //                eBody += "<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                    //                eBody += "<td  style='background-color: #999966;font-weight:bold;'> Invoice No. </td>";
                    //                eBody += "<td  style='background-color: #999966;font-weight:bold;'> Description </td>";
                    //                eBody += "<td  style='background-color: #999966;font-weight:bold;'> Div-Dep </td>";
                    //                eBody += "<td  style='background-color: #999966;font-weight:bold;'> Invoice Amount </td></tr>";

                    //                OneTimeLoop = false;
                    //            }


                    //            if (!(Rowcount % 2 == 1))
                    //            {
                    //                eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Invoiceno"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Description"] + "</td>";
                    //                eBody += "<td>" + sqlDr["NAME"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Invoiceamount"] + "</td></tr>";
                    //            }
                    //            else
                    //            {
                    //                eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Invoiceno"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Description"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["NAME"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Invoiceamount"] + "</td></tr>";
                    //            }


                    //        }
                    //        eBody += "</table>";
                    //    }
                    //    sqlDr.Close();



                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                    //    {


                    //        eBody += "<tr></br><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //        eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //        eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //        eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;


                    case "AD02Transport_VR0201":

                        SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.SerialNo) As RecCounter, M.SerialNo AS mSerialNo,";
                        SQL += " M.Subject,M.GoingFrom,M.GoingTo,CONVERT(VARCHAR(10), M.DepartureDate, 103) AS DepartureDate,CONVERT(VARCHAR(10), M.ReturnDate, 103) AS ReturnDate,M.SelectedVehicleID,M.Comments,Email, M.LineManagerEmail,M.LineManagerName, ApprovalPass, RejectPass, displayname, RegistrationNumber,";
                        SQL += " M.userid, CONVERT(VARCHAR(10), M.Date, 103) AS DocumentDate, M.DocumentID,NAME,MAKE,MODEL,ODOMETER,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate,CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate,CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS RegistrationExpiryDate FROM GCAAD0210101 M LEFT OUTER JOIN GCAAD0210100 ON M.SELECTEDVEHICLEID = GCAAD0210100.DocumentID ";
                        SQL += " Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                        sqlComm = new SqlCommand();
                        sqlComm.Connection = sqlConn;
                        sqlComm.CommandType = CommandType.Text;
                        sqlComm.CommandText = SQL;
                        sqlDr = sqlComm.ExecuteReader();
                        if (sqlDr.HasRows)
                        {
                            while (sqlDr.Read())
                            {
                                Rowcount += 1;
                                if (OneTimeLoop)
                                {
                                    //code changes from here 
                                    ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveTransportRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                                    RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectTransportRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                                    if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is a transport request waiting";
                                        eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                                    }
                                    else if (_EmailType == "Submit_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your transport request has been submitted";
                                        eBody += ".<br/><br/>";
                                    }
                                    else if (_EmailType == "Approve_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your transport request has been actioned as ";
                                        eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                                    }
                                    else if (_EmailType == "Reject_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your transport request has been actioned ";
                                        eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                                    }

                                    eBody += "Request details:<br/><br/>";
                                    eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                                    eBody += "<tr>";
                                    eBody += "<td >Document ID: </td><td ><B>" + sqlDr["DocumentID"] + "</td>";
                                    eBody += "<td >Document Date: </td><td ><B>" + sqlDr["DocumentDate"] + "</td>";
                                    eBody += "</tr><tr><td  >Created User: </td><td ><B>" + sqlDr["displayname"] + "</td>";
                                    eBody += "<td >Departure Date: </td><td ><B>" + sqlDr["DepartureDate"] + "</td>";
                                    eBody += "</tr><tr><td  >Return Date: </td><td ><B>" + sqlDr["ReturnDate"] + "</td>";
                                    eBody += "<td >From: </td><td ><B>" + sqlDr["GoingFrom"] + "</td>";
                                    eBody += "</tr><tr><td  >To: </td><td ><B>" + sqlDr["GoingTo"] + "</td>";
                                    eBody += "<td >Vehicle ID: </td><td ><B>" + sqlDr["SelectedVehicleID"] + "</td>";
                                    eBody += "</tr><tr><td  >Comments: </td><td ><B>" + sqlDr["Comments"] + "</td>";
                                    eBody += "<td >ODO Meter: </td><td ><B>" + sqlDr["ODOMeter"] + "</td>";
                                    eBody += "</tr><tr><td  >Last Service Date: </td><td ><B>" + sqlDr["LastServiceDate"] + "</td>";
                                    eBody += "<td >Oil Change Date: </td><td ><B>" + sqlDr["OilChangeDate"] + "</td>";
                                    eBody += "</tr><tr><td  >Registration Expiry Date: </td><td ><B>" + sqlDr["RegistrationExpiryDate"] + "</td>";
                                    eBody += "<td >Line Manager: </td><td ><B>" + sqlDr["LineManagerName"] + "</td>";
                                    eBody += "</tr> ";
                                    eBody += "</table> ";
                                    eBody += "<br/><br/>";
                                    eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; width: 100%;font-size: 11pt;'>";
                                    eBody += "<tr> ";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'>Registration Number: </td><td >" + sqlDr["RegistrationNumber"] + "</td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'>ODO Meter: </td><td >" + sqlDr["ODOMeter"] + "</td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'>Last Service Date: </td><td >" + sqlDr["LastServiceDate"] + "</td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'>Oil Change Date: </td><td >" + sqlDr["OilChangeDate"] + "</td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'>Registration Expiry Date: </td><td >" + sqlDr["RegistrationExpiryDate"] + "</td>";
                                    eBody += "</tr> ";
                                    eBody += "</table>";

                                    OneTimeLoop = false;
                                }
                                

                            }
                        }
                        sqlDr.Close();

                        if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                        {
                            eBody += "<br/><tr><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";
                        }

                        eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                        eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                        eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                        eBody += "</div></body></html>";
                        break;

                    //case "AD03Hotel_AD0301":
                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY ExpenseCode) As RecCounter, M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " M.ExpenseCode,M.DestinationCity,CONVERT(VARCHAR(10), M.CheckInDate, 103) AS CheckInDate,CONVERT(VARCHAR(10), M.CheckOutDate, 103) AS CheckOutDate,M.Nights,M.Reason,M.TotalAmount,Email, M.LineManagerEmail,M.LineManagerName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(10), M.Date, 103) AS DocumentDate, M.DocumentID FROM [GCAAD0310100] M ";
                    //    SQL += " WHERE M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectHotelRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is a hotel request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your hotel request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your hotel request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your hotel request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 width='450px' style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr>";
                    //                eBody += "<td  >Document ID: </td><td  ><B>" + sqlDr["DocumentID"] + "</td>";
                    //                eBody += "<td  >Document Date: </td><td  ><B>" + sqlDr["DocumentDate"] + "</td>";
                    //                eBody += "</tr><tr><td   >Created User: </td><td  ><B>" + sqlDr["displayname"] + "</td>";
                    //                eBody += "<td   >Expense Code: </td><td  ><B>" + sqlDr["ExpenseCode"] + "</td>";
                    //                eBody += "</tr><tr><td   >City: </td><td  ><B>" + sqlDr["DestinationCity"] + "</td>";
                    //                eBody += "<td   >Check In: </td><td  ><B>" + sqlDr["CheckInDate"] + "</td>";
                    //                eBody += "";
                    //                eBody += "";
                    //                eBody += "</tr><tr><td  >Check Out: </td><td  ><B>" + sqlDr["CheckOutDate"] + "</td>";
                    //                eBody += "<td  >Nights Stay: </td><td  ><B>" + sqlDr["Nights"] + "</td>";
                    //                eBody += "</tr><tr>" ;
                    //                eBody += "<td  >Total Amount: </td><td colspan='3' ><B>" + sqlDr["TotalAmount"] + "</B></td>";
                    //                eBody += "</tr><tr><td  >Reason: </td><td colspan='3' ><B>" + sqlDr["Reason"] + "</B></td></tr> <tr><td  >Line Manager: </td><td  ><B>" + sqlDr["LineManagerName"] + "</B></td>";
                    //                eBody += "</tr> </table>";

                    //                OneTimeLoop = false;
                    //            }
                                

                    //        }
                    //    }
                    //    sqlDr.Close();

                    //    // code changes  from here
                    //    string path = ServerMapPath + "\\Images\\MR Graphs\\";
                    //    GenerateGraphforHotelRequest(Telerik.Charting.ChartSeriesType.Bar, Telerik.Charting.ChartSeriesOrientation.Vertical, false, eServiceWorkflowInfo["DocumentNumber"].ToString(), ref path, ServerMapPath + "\\chart.xml", Rowcount);
                    //    // code changes  till here
                    //    if (_EmailType.Contains("Approve_Approver"))
                    //    {
                    //        eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //        eBody += "<tr><br/><br/><td colspan=6 ><img src=cid:Pic1" + randomNumber.ToString().Replace("0.", "") + "></td></tr>";
                    //        eBody += "</table><br/><br/>";
                    //    }

                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Approval")
                    //    {
                    //        eBody += "<br/><br/><tr><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //        eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //        eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //        eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;

                    //case "AD06OfficialMission_AD0601":

                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " Description,M.MissionName,M.MissionType,CONVERT(VARCHAR(10), M.MissionStart, 103) AS MissionStart,CONVERT(VARCHAR(10), M.MissionEnd, 103) AS MissionEnd,Email, M.LineManagerEmail,M.LineManagerName,GCAAD0600100.PurposeName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " CONVERT(VARCHAR(10), D.FromDate, 103) AS FromDate,CONVERT(VARCHAR(10), D.ToDate, 103) AS ToDate,D.LocationFrom,D.LocationTo,ISNULL(PONUMBER,'') AS PONUMBER, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(12), M.DocumentDate, 103) AS DocumentDate, M.DocumentID FROM GCAAD0610110 D ";
                    //    SQL += " LEFT OUTER JOIN GCAAD0610100 M ON M.DocumentID = D.DocumentID LEFT OUTER JOIN GCAAD0600100 ON GCAAD0600100.PurposeID = D.PurposeID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";


                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is official mission request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                    //                eBody += "<tr><td >";
                    //                eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                    //                eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                    //                eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                    //                eBody += "Mission Type: <B>" + sqlDr["MissionType"] + "</B><br />";
                    //                eBody += "</td>";
                    //                eBody += "<td >";
                    //                eBody += "Mission Name: <B>" + sqlDr["MissionName"] + "</B><br />";
                    //                eBody += "Mission Start: <B>" + sqlDr["MissionStart"] + "</B><br />";
                    //                eBody += "Mission End: <B>" + sqlDr["MissionEnd"] + "</B><br />";
                    //                eBody += "</td></tr> </table>";
                    //                eBody += "<br />";
                    //                eBody += "<br />";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Purpose Name </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location From </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location To </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> From Date </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> To Date </td></tr>";

                    //                OneTimeLoop = false;
                    //            }


                    //            if (!(Rowcount % 2 == 1))
                    //            {
                    //                eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td>" + sqlDr["ToDate"] + "</td></tr>";

                    //            }
                    //            else
                    //            {
                    //                eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["ToDate"] + "</td></tr>";
                    //            }


                    //        }
                    //        eBody += "</table>";
                    //    }
                    //    sqlDr.Close();

                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                    //    {

                    //        if (DocumentAction != "PA Approval")
                    //        {
                    //            eBody += "<tr><br/><br/><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";

                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //        else
                    //        {
                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;

                    //case "AD06OfficialMission_AD06011":

                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " Description,M.MissionName,M.MissionType,CONVERT(VARCHAR(10), M.MissionStart, 103) AS MissionStart,CONVERT(VARCHAR(10), M.MissionEnd, 103) AS MissionEnd,Email, M.LineManagerEmail,M.LineManagerName,GCAAD0600100.PurposeName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " CONVERT(VARCHAR(10), D.FromDate, 103) AS FromDate,CONVERT(VARCHAR(10), D.ToDate, 103) AS ToDate,D.LocationFrom,D.LocationTo, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(12), M.DocumentDate, 103) AS DocumentDate, M.DocumentID FROM GCAAD0610110 D ";
                    //    SQL += " LEFT OUTER JOIN GCAAD0610100 M ON M.DocumentID = D.DocumentID LEFT OUTER JOIN GCAAD0600100 ON GCAAD0600100.PurposeID = D.PurposeID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";


                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is official mission request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                    //                eBody += "<tr><td >";
                    //                eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                    //                eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                    //                eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                    //                eBody += "Mission Type: <B>" + sqlDr["MissionType"] + "</B><br />";
                    //                eBody += "</td>";
                    //                eBody += "<td >";
                    //                eBody += "Mission Name: <B>" + sqlDr["MissionName"] + "</B><br />";
                    //                eBody += "Mission Start: <B>" + sqlDr["MissionStart"] + "</B><br />";
                    //                eBody += "Mission End: <B>" + sqlDr["MissionEnd"] + "</B><br />";
                    //                eBody += "</td></tr> </table>";
                    //                eBody += "<br />";
                    //                eBody += "<br />";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Purpose Name </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location From </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location To </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> From Date </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> To Date </td></tr>";

                    //                OneTimeLoop = false;
                    //            }


                    //            if (!(Rowcount % 2 == 1))
                    //            {
                    //                eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td>" + sqlDr["ToDate"] + "</td></tr>";

                    //            }
                    //            else
                    //            {
                    //                eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["ToDate"] + "</td></tr>";
                    //            }


                    //        }
                    //        eBody += "</table>";
                    //    }
                    //    sqlDr.Close();



                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                    //    {

                    //        if (DocumentAction != "ADG Approval")
                    //        {
                    //            eBody += "<tr><br/><br/><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";

                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //        else
                    //        {
                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;

                    //case "AD06OfficialMission_AD06012":

                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " Description,M.MissionName,M.MissionType,CONVERT(VARCHAR(10), M.MissionStart, 103) AS MissionStart,CONVERT(VARCHAR(10), M.MissionEnd, 103) AS MissionEnd,Email, M.LineManagerEmail,M.LineManagerName,GCAAD0600100.PurposeName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " CONVERT(VARCHAR(10), D.FromDate, 103) AS FromDate,CONVERT(VARCHAR(10), D.ToDate, 103) AS ToDate,D.LocationFrom,D.LocationTo, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(12), M.DocumentDate, 103) AS DocumentDate, M.DocumentID FROM GCAAD0610110 D ";
                    //    SQL += " LEFT OUTER JOIN GCAAD0610100 M ON M.DocumentID = D.DocumentID LEFT OUTER JOIN GCAAD0600100 ON GCAAD0600100.PurposeID = D.PurposeID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";


                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is official mission request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your official mission request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                    //                eBody += "<tr><td >";
                    //                eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                    //                eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                    //                eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                    //                eBody += "Mission Type: <B>" + sqlDr["MissionType"] + "</B><br />";
                    //                eBody += "</td>";
                    //                eBody += "<td >";
                    //                eBody += "Mission Name: <B>" + sqlDr["MissionName"] + "</B><br />";
                    //                eBody += "Mission Start: <B>" + sqlDr["MissionStart"] + "</B><br />";
                    //                eBody += "Mission End: <B>" + sqlDr["MissionEnd"] + "</B><br />";
                    //                eBody += "</td></tr> </table>";
                    //                eBody += "<br />";
                    //                eBody += "<br />";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Purpose Name </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location From </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Location To </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> From Date </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> To Date </td></tr>";

                    //                OneTimeLoop = false;
                    //            }


                    //            if (!(Rowcount % 2 == 1))
                    //            {
                    //                eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td>" + sqlDr["ToDate"] + "</td></tr>";

                    //            }
                    //            else
                    //            {
                    //                eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["PurposeName"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationFrom"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationTo"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["FromDate"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["ToDate"] + "</td></tr>";
                    //            }


                    //        }
                    //        eBody += "</table>";
                    //    }
                    //    sqlDr.Close();



                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                    //    {

                    //        if (DocumentAction != "Submit")
                    //        {
                    //            eBody += "<tr><br/><br/><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";

                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //        else
                    //        {
                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;

                    //case "AD08VisaManagement_VS0801":

                    //    SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                    //    SQL += " M.JobTitle,M.Personal,M.Family,M.ServicePeriod,M.Remarks,Email, M.LineManagerEmail,M.LineManagerName, ApprovalPass, RejectPass, displayname, ";
                    //    SQL += " D.Name,D.Age,D.Relationship,CONVERT(VARCHAR(10), D.EntryDate, 103) AS EntryDate, ";
                    //    SQL += " M.userid, CONVERT(VARCHAR(12), M.Date, 103) AS DocumentDate, M.DocumentID FROM GCAAD0810110 D ";
                    //    SQL += " LEFT OUTER JOIN GCAAD0810100 M ON M.DocumentID = D.DocumentID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                    //    sqlComm = new SqlCommand();
                    //    sqlComm.Connection = sqlConn;
                    //    sqlComm.CommandType = CommandType.Text;
                    //    sqlComm.CommandText = SQL;
                    //    sqlDr = sqlComm.ExecuteReader();
                    //    if (sqlDr.HasRows)
                    //    {
                    //        while (sqlDr.Read())
                    //        {
                    //            Rowcount += 1;
                    //            if (OneTimeLoop)
                    //            {
                    //                //code changes from here 
                    //                //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                    //                ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                    //                ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                    //                RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                    //                RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                    //                RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectVisaManagement + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";


                    //                if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is visa request waiting";
                    //                    eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Submit_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your visa request has been submitted";
                    //                    eBody += ".<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Approve_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your visa request has been actioned as ";
                    //                    eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }
                    //                else if (_EmailType == "Reject_Requester")
                    //                {
                    //                    eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your visa request has been actioned ";
                    //                    eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                    //                }

                    //                eBody += "Request details:<br/><br/>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                    //                eBody += "<tr><td >";
                    //                eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                    //                eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                    //                eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                    //                eBody += "Job Title: <B>" + sqlDr["JobTitle"] + "</B><br />";
                    //                eBody += "</td>";
                    //                eBody += "<td >";
                    //                eBody += "Required Service Personal: <B>" + sqlDr["Personal"] + "</B><br />";
                    //                eBody += "Required Service Family: <B>" + sqlDr["Family"] + "</B><br />";
                    //                eBody += "Service Period: <B>" + sqlDr["ServicePeriod"] + "</B><br />";
                    //                eBody += "</td></tr> </table>";
                    //                eBody += "</br></br>";
                    //                eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                    //                eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Name </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Age </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Relationship </td>";
                    //                eBody += "<td style='background-color: #999966;font-weight:bold;'> Entry Date </td></tr>";

                    //                OneTimeLoop = false;
                    //            }


                    //            if (!(Rowcount % 2 == 1))
                    //            {
                    //                eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Name"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Age"] + "</td>";
                    //                eBody += "<td>" + sqlDr["Relationship"] + "</td>";
                    //                eBody += "<td>" + sqlDr["EntryDate"] + "</td></tr>";
                    //            }
                    //            else
                    //            {
                    //                eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Name"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Age"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Relationship"] + "</td>";
                    //                eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["EntryDate"] + "</td></tr>";
                    //            }
                    //        }
                    //        eBody += "</table>";
                    //    }
                    //    sqlDr.Close();



                    //    if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                    //    {

                    //        if (DocumentAction != "HR Approval")
                    //        {
                    //            eBody += "<tr><br/><br/><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                    //            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    //            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";
                    //        }
                    //        else
                    //        {
                    //            eBody += "<tr><br/><br/><br/>";
                    //            eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                    //            eBody += "</tr>";
                    //        }
                    //    }

                    //    eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                    //    eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                    //    eBody += "</div></body></html>";
                    //    break;

                    case "AD07VehicleMaintenance_VT0701":

                        SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,";
                        SQL += " D.ServiceType,D.RegistrationNumber,D.Model,D.Amount,M.Remarks,Email, M.LineManagerEmail,M.LineManagerName, ApprovalPass, RejectPass, displayname, ";
                        SQL += " CONVERT(VARCHAR(10), M.ServiceDate, 103) AS ServiceDate,M.Location, ";
                        SQL += " M.userid, CONVERT(VARCHAR(12), M.Date, 103) AS DocumentDate, M.DocumentID FROM GCAAD0710110 D ";
                        SQL += " LEFT OUTER JOIN GCAAD0710100 M ON M.DocumentID = D.DocumentID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                        sqlComm = new SqlCommand();
                        sqlComm.Connection = sqlConn;
                        sqlComm.CommandType = CommandType.Text;
                        sqlComm.CommandText = SQL;
                        sqlDr = sqlComm.ExecuteReader();
                        if (sqlDr.HasRows)
                        {
                            while (sqlDr.Read())
                            {
                                Rowcount += 1;
                                if (OneTimeLoop)
                                {
                                    //code changes from here 
                                    //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                                    //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                                    ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveVehicleMaintenance + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                                    RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectVehicleMaintenance + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                                    if (_EmailType == "Submit_Approver" | _EmailType == "Approve_Approver")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> There is Vehicle Maintenance request waiting";
                                        eBody += " for your approval from [ " + sqlDr["displayname"].ToString() + " ].<br/><br/>";
                                    }
                                    else if (_EmailType == "Submit_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your Vehicle Maintenance request has been submitted";
                                        eBody += ".<br/><br/>";
                                    }
                                    else if (_EmailType == "Approve_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your Vehicle Maintenance request has been actioned as ";
                                        eBody += "<B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                                    }
                                    else if (_EmailType == "Reject_Requester")
                                    {
                                        eBody += "<div style='font-family:Calibri;font-size:11pt;'> Your Vehicle Maintenance request has been actioned ";
                                        eBody += "as <B>[ " + DocumentAction + " ]</B> .<br/><br/>";
                                    }

                                    eBody += "Request details:<br/><br/>";
                                    eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                                    eBody += "<tr><td >";
                                    eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                                    eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                                    eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                                    eBody += "</td>";
                                    eBody += "<td >";
                                    eBody += "Location: <B>" + sqlDr["Location"] + "</B><br />";
                                    eBody += "Service Date: <B>" + sqlDr["ServiceDate"] + "</B><br />";
                                    eBody += "Remarks: <B>" + sqlDr["Remarks"] + "</B><br />";
                                    eBody += "</td></tr> </table>";

                                    eBody += "<br /><br /><table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                                    eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'> Service Type </td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'> Registration Number </td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'> Model </td>";
                                    eBody += "<td style='background-color: #999966;font-weight:bold;'> Amount </td></tr>";

                                    OneTimeLoop = false;
                                }


                                if (!(Rowcount % 2 == 1))
                                {
                                    eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                                    eBody += "<td>" + sqlDr["ServiceType"] + "</td>";
                                    eBody += "<td>" + sqlDr["RegistrationNumber"] + "</td>";
                                    eBody += "<td>" + sqlDr["Model"] + "</td>";
                                    eBody += "<td>" + sqlDr["Amount"] + "</td></tr>";
                                }
                                else
                                {
                                    eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                                    eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["ServiceType"] + "</td>";
                                    eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["RegistrationNumber"] + "</td>";
                                    eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Model"] + "</td>";
                                    eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["Amount"] + "</td></tr>";
                                }


                            }
                            eBody += "</table>";
                        }
                        sqlDr.Close();



                        if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                        {


                            eBody += "<tr><br/><br/><b><i>Mobile users can approve/reject using following links:</i></b><br/>";
                            eBody += "<b><a href=" + Strings.Chr(34) + ApprovedLink + Strings.Chr(34) + ">Approve</a>";
                            eBody += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                            eBody += "<a href=" + Strings.Chr(34) + RejectLink + Strings.Chr(34) + ">Reject</a></b><br/><br/></tr>";
                        }

                        eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                        eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                        eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                        eBody += "</div></body></html>";
                        break;
                }
            }
            functionReturnValue = eBody;
            CloseConnection();
            return functionReturnValue;
        }

        private string ReturnBodyTextOM02(string _EMailID, string _EmailType)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string eBody = "";
            string ApprovedLink = "";
            string RejectLink = "";
            string RequestLink = "http://gcaaportal/admin/admin/default.aspx";
            string httpApprovedLink = "";
            string httpRejectLink = "";
            DataTable _dt = new DataTable();

            string ApproverName = "";
            string DocumentAction = "";

            string LineManagerEmailAddress = "";
            Int16 Rowcount = 0;
            bool OneTimeLoop = true;
            string ImagePath = "";
            Random rnd = new Random();

            randomNumber = rnd.NextDouble();
            if (OpenConnection())
            {

                eBody = "";
                eBody += "<html><body><div style='font-family:Calibri;font-size:11pt;color:Black;'>Greetings,</div><br/>";

                SQL = " SELECT TOP 1 AD.DisplayName";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY StepNumber DESC";

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                ApproverName = sqlComm.ExecuteScalar().ToString();

                SQL = " SELECT TOP 1 WF.Action";
                SQL += " FROM GCAWF0010120 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.ActionBy = AD.LoginName ";
                SQL += " WHERE eServiceID = '" + eServiceWorkflowInfo["eServiceId"] + "' ";
                SQL += " AND WorkflowID = '" + eServiceWorkflowInfo["WorkflowID"] + "' ";
                SQL += " AND DocumentNumber = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";
                SQL += " ORDER BY StepNumber DESC";
                sqlComm.CommandText = SQL;
                DocumentAction = sqlComm.ExecuteScalar().ToString();

                if (DocumentAction != "Final Approval")
                {
                    return "";
                }

                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY M.DocumentID) As RecCounter, D.SerialNo,M.SerialNo AS mSerialNo,                 ";
                SQL += " Description,M.MissionName,M.MissionType,CONVERT(VARCHAR(10), M.MissionStart, 103) AS MissionStart,CONVERT(VARCHAR(10), M.MissionEnd, 103) AS MissionEnd,Email, M.LineManagerEmail,M.LineManagerName,GCAAD0600100.PurposeName, ApprovalPass, RejectPass, displayname, ";
                SQL += " CONVERT(VARCHAR(10), D.FromDate, 103) AS FromDate,CONVERT(VARCHAR(10), D.ToDate, 103) AS ToDate,D.LocationFrom,D.LocationTo,ISNULL(PONUMBER,'') AS PONUMBER, ";
                SQL += " M.userid, CONVERT(VARCHAR(12), M.DocumentDate, 103) AS DocumentDate, M.DocumentID FROM GCAAD0610110 D ";
                SQL += " LEFT OUTER JOIN GCAAD0610100 M ON M.DocumentID = D.DocumentID LEFT OUTER JOIN GCAAD0600100 ON GCAAD0600100.PurposeID = D.PurposeID Where M.DocumentID  = '" + eServiceWorkflowInfo["DocumentNumber"] + "' ";

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        Rowcount += 1;
                        if (OneTimeLoop)
                        {
                            //code changes from here 
                            //ApprovedLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                            //RejectLink = "http://auhmdgpspp01:79/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectMaterialRequest + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                            ApprovedLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                            RejectLink = "http://auhmdgpspp01:1981/anonymous/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                            ApprovedLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                            ApprovedLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";
                            ApprovedLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_ApproveOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&ApprovalPass=" + sqlDr["ApprovalPass"] + "&Method=99";

                            RejectLink = "http://213.42.186.230:527/common/landingpage1.aspx?_URL=http://213.42.186.230:527/common/application_login1.aspx?";
                            RejectLink += "Goto=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";
                            RejectLink += "&_t=4&durl=http://213.42.186.230:527/common/ProcessRequestsC.aspx?ActionId=" + actCode_RejectOfficialMission + "&ID=" + sqlDr["mSerialNo"] + "&RejectPass=" + sqlDr["RejectPass"] + "&Method=99";

                            string lnk = "http://auhmdgpspp01:1979/ReportViewer.aspx?RID=1006&POID=" + sqlDr["PONumber"] + "";

                            eBody += "<div style='font-family:Calibri;font-size:11pt;'> The official mission request has been actioned ";
                            eBody += "as <B>[ " + DocumentAction + " ]</B> ; For your reference .<br/><br/>";

                            eBody += "Request details:<br/><br/>";
                            eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";

                            eBody += "<tr><td >";
                            eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                            eBody += "Document Date: <B>" + sqlDr["DocumentDate"] + "</B><br />";
                            eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                            eBody += "Mission Type: <B>" + sqlDr["MissionType"] + "</B><br />";
                            eBody += "</td>";
                            eBody += "<td >";
                            eBody += "Mission Name: <B>" + sqlDr["MissionName"] + "</B><br />";
                            eBody += "Mission Start: <B>" + sqlDr["MissionStart"] + "</B><br />";
                            eBody += "Mission End: <B>" + sqlDr["MissionEnd"] + "</B><br />";
                            eBody += "PO Number: <B>" + sqlDr["PONumber"] + "</B><br />";
                            eBody += "</td></tr> ";
                            eBody += "<tr><td>";
                            eBody += "<b><a href="+ lnk + ">Click here to open Purchase Order</a>";
                            eBody += "</td></tr> ";
                            eBody += "</table>";
                            eBody += "<br />";
                            eBody += "<br />";
                            eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                            eBody += "<tr><td style='background-color: #999966;font-weight:bold;'> Record No. </td>";
                            eBody += "<td style='background-color: #999966;font-weight:bold;'> Purpose Name </td>";
                            eBody += "<td style='background-color: #999966;font-weight:bold;'> Location From </td>";
                            eBody += "<td style='background-color: #999966;font-weight:bold;'> Location To </td>";
                            eBody += "<td style='background-color: #999966;font-weight:bold;'> From Date </td>";
                            eBody += "<td style='background-color: #999966;font-weight:bold;'> To Date </td></tr>";

                            OneTimeLoop = false;
                        }


                        if (!(Rowcount % 2 == 1))
                        {
                            eBody += "<tr><td>" + sqlDr["RecCounter"] + "</td>";
                            eBody += "<td>" + sqlDr["PurposeName"] + "</td>";
                            eBody += "<td>" + sqlDr["LocationFrom"] + "</td>";
                            eBody += "<td>" + sqlDr["LocationTo"] + "</td>";
                            eBody += "<td>" + sqlDr["FromDate"] + "</td>";
                            eBody += "<td>" + sqlDr["ToDate"] + "</td></tr>";

                        }
                        else
                        {
                            eBody += "<tr><td style='background-color: #E0E0E0'>" + sqlDr["RecCounter"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["PurposeName"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationFrom"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["LocationTo"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["FromDate"] + "</td>";
                            eBody += "<td style='background-color: #E0E0E0'>" + sqlDr["ToDate"] + "</td></tr>";
                        }


                    }
                    eBody += "</table>";
                }
                sqlDr.Close();



                if (_EmailType.Contains("Approver") & DocumentAction != "Final Approval")
                {
                    if (DocumentAction != "PA Approval")
                    {
                        eBody += "<tr><br/><br/><br/>";
                        eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                        eBody += "</tr>";
                    }
                    else
                    {
                        eBody += "<tr><br/><br/><br/>";
                        eBody += "<b><a href=" + Strings.Chr(34) + RequestLink + Strings.Chr(34) + ">Click here to open Admin Support E-Services</a>";
                        eBody += "</tr>";
                    }
                }

                eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                eBody += "</div></body></html>";

            }
                functionReturnValue = eBody;
                CloseConnection();
                return functionReturnValue;
        }

        public string ReturnBodyTextCM(string docid)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            string eBody = "";
            DataTable _dt = new DataTable();
            Int16 Rowcount = 0;
            bool OneTimeLoop = true;
            if (OpenConnection())
            {

                eBody = "";
                eBody += "<html><body><div style='font-family:Calibri;font-size:11pt;color:Black;'>Greetings,</div><br/>";

                SQL = "SELECT *,AD.DisplayName AS ADDisplayName,CONVERT(VARCHAR(10), Date, 103) AS DocDate,CONVERT(VARCHAR(10), CallDate, 103) AS CallDate1 from GCAAD0410100 LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON GCAAD0410100.CallFor = AD.LoginName WHERE DocumentID = '" + docid + "' ";

                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlDr = sqlComm.ExecuteReader();
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        Rowcount += 1;
                        if (OneTimeLoop)
                        {
                            eBody += "<div style='font-family:Calibri;font-size:11pt;'> You have received notification from Call Management. ";
                            eBody += "<br/><br/>";
                            eBody += "Details:<br/><br/>";
                            eBody += "<table border=0 style='font-family: Calibri, Arial, Helvetica, sans-serif; font-size: 11pt;'>";
                            eBody += "<tr><td >";
                            eBody += "Document ID: <B>" + sqlDr["DocumentID"] + "</B><br />";
                            eBody += "Created User: <B>" + sqlDr["displayname"] + "</B><br />";
                            eBody += "Call From: <B>" + sqlDr["CallFrom"] + "</B><br />";
                            eBody += "Time: <B>" + sqlDr["Hours"] + " : " + sqlDr["Minutes"] + "</B><br />";
                            eBody += "</td>";
                            eBody += "<td >";
                            eBody += "Document Date : <B>" + sqlDr["DocDate"] + " </B><br />";
                            eBody += "Call Date: <B>" + sqlDr["CallDate1"] + "</B><br />";
                            eBody += "Call For: <B>" + sqlDr["ADDisplayName"] + "</B><br />";
                            eBody += "Message: <B>" + sqlDr["Message"] + "</B><br />";
                            eBody += "</td></tr> </table>";
                            OneTimeLoop = false;
                        }
                    }
                }
                sqlDr.Close();


                eBody += "<br/><br/><span style='color: red;font-family:Calibri;font-size:11pt;'>This is an automated e-mail from the GCAA Portal. Please do not reply to this email.</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>With Regards,</span><br />";
                eBody += "<span style='color: #1F497D;font-family:Calibri;font-size:11pt;'>GCAA Portal</span>";
                eBody += "</div></body></html>";

            }
            functionReturnValue = eBody;
            CloseConnection();
            return functionReturnValue;
        }

        private bool GenerateGraphforHotelRequest(Telerik.Charting.ChartSeriesType dChartType, Telerik.Charting.ChartSeriesOrientation dSeriesOrient, bool dHidePercentage, string p_DocID, ref string FilePath, string LayoutPath, Int16 p_Rowcount)
        {
            bool functionReturnValue = false;
            try
            {
                DataTable dt = new DataTable();

                //dt = objMR.ReturnDashBoardGraphsHotelRequest(p_DocID);

                RadChart rc_Total = new RadChart();


                Int16 r = 0;
                Int16 g = 0;
                Int16 b = 0;
                int j = 0;

                //Random rnd = default(Random);
                //double randomNumber = 0;

                //rnd = new Random();
                //randomNumber = rnd.NextDouble();

                rc_Total.LoadFromXml(LayoutPath);

                rc_Total.Width = 325 * p_Rowcount;
                rc_Total.Legend.Appearance.Position.AlignedPosition = Telerik.Charting.Styles.AlignedPositions.Right;
                rc_Total.Legend.Appearance.Position.Auto = true;
                rc_Total.Legend.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;

                rc_Total.DefaultType = dChartType;
                rc_Total.PlotArea.XAxis.DataLabelsColumn = "ExpenseCode";
                rc_Total.Skin = "GrayStripes";
                rc_Total.SkinsOverrideStyles = true;
                rc_Total.ChartTitle.TextBlock.Text = "Budget Status";
                rc_Total.ChartTitle.Visible = true;

                rc_Total.Series.Clear();
                rc_Total.DataSource = dt;

                rc_Total.DataBind();

                if (dChartType == Telerik.Charting.ChartSeriesType.Bar)
                {
                    rc_Total.SeriesOrientation = Telerik.Charting.ChartSeriesOrientation.Vertical;
                }
                rc_Total.SeriesOrientation = dSeriesOrient;
                Telerik.Charting.ChartSeriesItem item = new Telerik.Charting.ChartSeriesItem();
                if (dChartType == Telerik.Charting.ChartSeriesType.Pie)
                {
                    //Dim item As Telerik.Charting.ChartSeriesItem

                    for (j = 0; j <= rc_Total.Series.Count - 1; j++)
                    {
                        foreach (Telerik.Charting.ChartSeriesItem item_loopVariable in rc_Total.Series[j].Items)
                        {
                            item = item_loopVariable;
                            item.Appearance.Exploded = true;
                            if (dHidePercentage == false)
                            {
                                item.Label.TextBlock.Text = "#% - " + dt.Rows[item.Index].ItemArray[0].ToString().Trim();// .ToString().Trim();
                            }
                            else
                            {
                                item.Label.TextBlock.Text = "# - " + dt.Rows[item.Index].ItemArray[0].ToString().Trim();
                            }
                        }
                    }
                }

                item = new Telerik.Charting.ChartSeriesItem();
                for (j = 0; j <= rc_Total.Series.Count - 1; j++)
                {
                    foreach (Telerik.Charting.ChartSeriesItem item_loopVariable in rc_Total.Series[j].Items)
                    {
                        item = item_loopVariable;
                        item.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
                        if (j == 0)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Blue;
                        }
                        if (j == 1)
                        {
                            item.Appearance.FillStyle.MainColor = Color.LightGray;
                        }
                        if (j == 2)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Yellow;
                        }
                        if (j == 3)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Green;
                        }
                    }
                }
                //Telerik.Charting.ChartLabel item_loopVariable = new Telerik.Charting.ChartLabel();
                Int16 k = 0;
                Telerik.Charting.LabelItem item1 = new Telerik.Charting.LabelItem();
                foreach (Telerik.Charting.LabelItem item_loopVariable in rc_Total.Legend.Items)
                {
                    item1 = item_loopVariable;
                    item1.Marker.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
                    if (k == 0)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Blue;
                    }
                    if (k == 1)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.LightGray;
                    }
                    if (k == 2)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Yellow;
                    }
                    if (k == 3)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Green;
                    }
                    k += 1;
                }

                //FilePath = FilePath.Replace(".jpeg", randomNumber.ToString.Replace("0.", "0") & ".jpeg")
                rc_Total.Save(FilePath + p_DocID + ".jpeg", System.Drawing.Imaging.ImageFormat.Jpeg);

                rc_Total = null;
                functionReturnValue = true;

            }
            catch (Exception ex)
            {
                functionReturnValue = false;
            }
            return functionReturnValue;
        }

        private bool GenerateGraphforMaterialRequest(Telerik.Charting.ChartSeriesType dChartType, Telerik.Charting.ChartSeriesOrientation dSeriesOrient, bool dHidePercentage, string p_DocID, ref string FilePath, string LayoutPath, Int16 p_Rowcount)
        {
            bool functionReturnValue = false;
            try
            {
                DataTable dt = new DataTable();

                //dt = objMR.ReturnDashBoardGraphs(0, p_DocID);

                RadChart rc_Total = new RadChart();


                Int16 r = 0;
                Int16 g = 0;
                Int16 b = 0;
                int j = 0;

                Random rnd = default(Random);
                double randomNumber = 0;

                rnd = new Random();
                randomNumber = rnd.NextDouble();

                rc_Total.LoadFromXml(LayoutPath);

                rc_Total.Width = 225 * p_Rowcount;
                rc_Total.Legend.Appearance.Position.AlignedPosition = Telerik.Charting.Styles.AlignedPositions.Right;
                rc_Total.Legend.Appearance.Position.Auto = true;
                rc_Total.Legend.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;

                rc_Total.DefaultType = dChartType;
                rc_Total.PlotArea.XAxis.DataLabelsColumn = "CategoryName";
                rc_Total.Skin = "GrayStripes";
                rc_Total.SkinsOverrideStyles = true;
                rc_Total.ChartTitle.TextBlock.Text = "Budget Status - Selected Accounts";
                rc_Total.ChartTitle.Visible = true;

                rc_Total.Series.Clear();
                rc_Total.DataSource = dt;

                rc_Total.DataBind();

                if (dChartType == Telerik.Charting.ChartSeriesType.Bar)
                {
                    rc_Total.SeriesOrientation = Telerik.Charting.ChartSeriesOrientation.Vertical;
                }
                rc_Total.SeriesOrientation = dSeriesOrient;
                Telerik.Charting.ChartSeriesItem item = new Telerik.Charting.ChartSeriesItem();
                if (dChartType == Telerik.Charting.ChartSeriesType.Pie)
                {
                    //Dim item As Telerik.Charting.ChartSeriesItem

                    for (j = 0; j <= rc_Total.Series.Count - 1; j++)
                    {
                        foreach (Telerik.Charting.ChartSeriesItem item_loopVariable in rc_Total.Series[j].Items)
                        {
                            item = item_loopVariable;
                            item.Appearance.Exploded = true;
                            if (dHidePercentage == false)
                            {
                                item.Label.TextBlock.Text = "#% - " + dt.Rows[item.Index].ItemArray[0].ToString().Trim();// .ToString().Trim();
                            }
                            else
                            {
                                item.Label.TextBlock.Text = "# - " + dt.Rows[item.Index].ItemArray[0].ToString().Trim();
                            }
                        }
                    }
                }

                item = new Telerik.Charting.ChartSeriesItem();
                for (j = 0; j <= rc_Total.Series.Count - 1; j++)
                {
                    foreach (Telerik.Charting.ChartSeriesItem item_loopVariable in rc_Total.Series[j].Items)
                    {
                        item = item_loopVariable;
                        item.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
                        if (j == 0)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Blue;
                        }
                        if (j == 1)
                        {
                            item.Appearance.FillStyle.MainColor = Color.LightGray;
                        }
                        if (j == 2)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Yellow;
                        }
                        if (j == 3)
                        {
                            item.Appearance.FillStyle.MainColor = Color.Green;
                        }
                    }
                }
                //Telerik.Charting.ChartLabel item_loopVariable = new Telerik.Charting.ChartLabel();
                Int16 k = 0;
                Telerik.Charting.LabelItem item1 = new Telerik.Charting.LabelItem();
                foreach (Telerik.Charting.LabelItem item_loopVariable in rc_Total.Legend.Items)
                {
                    item1 = item_loopVariable;
                    item1.Marker.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid;
                    if (k == 0)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Blue;
                    }
                    if (k == 1)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.LightGray;
                    }
                    if (k == 2)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Yellow;
                    }
                    if (k == 3)
                    {
                        item1.Marker.Appearance.FillStyle.MainColor = Color.Green;
                    }
                    k += 1;
                }

                //FilePath = FilePath.Replace(".jpeg", randomNumber.ToString.Replace("0.", "0") & ".jpeg")
                rc_Total.Save(FilePath + p_DocID + ".jpeg", System.Drawing.Imaging.ImageFormat.Jpeg);

                rc_Total = null;
                functionReturnValue = true;

            }
            catch (Exception ex)
            {
                functionReturnValue = false;
            }
            return functionReturnValue;
        }

        private string DownloadFile(string p_LineID, ref System.Net.Mail.MailMessage p_MailMessage)
        {
            string functionReturnValue = null;
            functionReturnValue = "";
            //SqlConnection oConn = new SqlConnection("Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=WebLeave;User Id=;Password=;");
            SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString);
            oConn.Open();

            SqlCommand sComm = new SqlCommand("SELECT FILENAME AS FILE_NAME, REQUESTID as [Request Id] FROM GCAA_ESS_Leave_Attachments as FILES Where REQUESTID = '" + p_LineID + "'", oConn);
            SqlDataReader myReader = sComm.ExecuteReader();
            string m_AttachFile = "";
            Attachment att_file = default(Attachment);

            while (myReader.Read())
            {
                m_AttachFile = "d:\\temp\\" + myReader["FILE_NAME"].ToString();
                if (System.IO.File.Exists(m_AttachFile))
                {
                    att_file = null;
                    att_file = new Attachment(m_AttachFile);
                    p_MailMessage.Attachments.Add(att_file);
                }
            }
            myReader.Close();

            oConn.Close();
            return functionReturnValue;


        }

    }

    public class TransportRequest_DAL
    {
        private string eServiceId = "AD02Transport";
        private string WorkflowID = "VR0201";
        private SqlConnection sqlConn;
        private string SQL;
        private string Provider;
        private SqlDataAdapter sqlAdpt;
        private SqlDataReader dr;
        private SqlCommand sqlComm;

        private DataSet dt;
        private DataTable dtable;
        private Collection m_EmployeeInfo = new Collection();
        private Collection m_MRInfo = new Collection();
        private bool issqlDrOpen = false;

        public string ERROR_MESSAGE = "";
        public Collection EmployeeInfo
        {
            get { return m_EmployeeInfo; }
            set { m_EmployeeInfo = value; }
        }

        public Collection MRInfo
        {
            get { return m_MRInfo; }
            set { m_MRInfo = value; }
        }

        private bool CloseConnection()
        {
            bool functionReturnValue = false;
            try
            {
                if (sqlConn == null)
                {
                    functionReturnValue = true;
                    return functionReturnValue;
                }

                if (sqlConn.State == ConnectionState.Open)
                {
                    sqlConn.Close();
                    sqlConn.Dispose();
                    functionReturnValue = true;
                }
            }
            catch (Exception ex)
            {
                functionReturnValue = false;
            }
            return functionReturnValue;
        }

        private bool OpenConnection()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            sqlConn = new SqlConnection();

            //Provider = "Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=;Password=;";
            Provider = ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString;
            sqlConn.ConnectionString = Provider;
            sqlConn.Open();
            functionReturnValue = true;
            return functionReturnValue;

        }

        public bool GetEmployeeInformation(string p_Email)
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            bool isdrOpen = false;

            if (OpenConnection())
            {

                if (string.IsNullOrEmpty(p_Email.Trim()) | !p_Email.Contains("@"))
                {
                    //functionReturnValue = null;
                    functionReturnValue = false;
                    return functionReturnValue;
                }

                //GET EMPLOYEE INFORMATION FROM EMPLOYEE MASTER USING EMAIL ADDRESS OF EMPLOYEE.
                SQL = "SELECT * FROM GCAA_COMBINE_API_UPR00100  LEFT OUTER JOIN GCAA_USER_INFO ON GCAA_USER_INFO.EmployID = GCAA_COMBINE_API_UPR00100.Employid WHERE GCAA_COMBINE_API_UPR00100.EMAIL = '" + p_Email.ToString().Trim() + "'";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        isdrOpen = true;
                        if (string.IsNullOrEmpty(dr["EMPLOYID"].ToString().Trim()))
                        {
                            ERROR_MESSAGE = "Message: Employee id is not found for specified email address [" + p_Email.ToString().Trim() + "]";
                            return functionReturnValue;
                        }
                        //DIVLONGDESC_EN	DIVSHRTDESC_EN	DIVLONGDESC_AR	DEPLONGDESC_ENG	DEPLONGDESC_AR	DEPSHRTDESC_EN
                        //EMPLOYID	EMPLCLAS	INACTIVE	LASTNAME	FRSTNAME	MIDLNAME	ADRSCODE	SOCSCNUM	BRTHDATE	GENDER	ETHNORGN	Calc_Min_Wage_Bal	DIVISIONCODE_I	DEPRTMNT	JOBTITLE	SUPERVISORCODE_I	LOCATNID	WCACFPAY	ACTINDX	WKHRPRYR	STRTDATE	DEMPINAC	RSNEMPIN	MINETPAY	SUTASTAT	WRKRCOMP	ATACRVAC	VACCRAMT	VACCRMTH	VACAPRYR	VACAVLBL	WRNVCNFLSBLWZR	ATACRSTM	STMACMTH	SKTMACAM	SIKTIMAV	SKTMHPYR	WRNSTFLSBLWZR	USERDEF1	USERDEF2	EMPLOYMENTTYPE	MARITALSTATUS	BENADJDATE	LASTDAYWORKED_I	BIRTHDAY	BIRTHMONTH	SPOUSE	SPOUSESSN	NICKNAME	ALTERNATENAME	HRSTATUS	DATEOFLASTREVIEW_I	DATEOFNEXTREVIEW_I	BENEFITEXPIRE_I	HANDICAPPED	VETERAN	VIETNAMVETERAN	DISABLEDVETERAN	UNIONEMPLOYEE	SMOKER_I	CITIZEN	VERIFIED	I9RENEW	Primary_Pay_Record	CHANGEBY_I	CHANGEDATE_I	NOTEINDX	NOTEINDX2	UNIONCD	RATECLSS	FEDCLSSCD	OTHERVET	Military_Discharge_Date	EMPLSUFF	STATUSCD	Workflow_Approval_Status	Workflow_Priority	AFSMVET	RECSEPVET	DEX_ROW_TS	DEX_ROW_ID	EMAIL	DIVCODE	DEPCODE
                        string ab;
                        EmployeeInfo.Clear();
                        EmployeeInfo.Add(dr["EMPLOYID"], "EMPLOYEE ID", null, null);
                        EmployeeInfo.Add(dr["DIVCODE"], "DIVCODE", null, null);
                        EmployeeInfo.Add(dr["DEPCODE"].ToString(), "DEPCODE", null, null);

                        EmployeeInfo.Add(dr["DIVLONGDESC_EN"].ToString(), "DIVLONGDESC_EN", null, null);
                        EmployeeInfo.Add(dr["DEPLONGDESC_ENG"].ToString(), "DEPLONGDESC_ENG", null, null);
                        EmployeeInfo.Add(dr["MobilePhone"].ToString(), "MobilePhone", null, null);
                        functionReturnValue = true;
                        dr.Close();
                        isdrOpen = false;
                    }
                }
                else
                {
                    ERROR_MESSAGE = "Message: Your information is not updated in the system.<br/>";
                    ERROR_MESSAGE += "Kindly contact IT Helpdesk to update your email information [" + p_Email.ToString().Trim() + "].";
                    return functionReturnValue;
                }
                functionReturnValue = true;
            }
            CloseConnection();
            return functionReturnValue;

        }

        public string GetAdminUser(string p_curruser)
        {
            string functionReturnValue = "False";
            bool isdrOpen = false;

            if (OpenConnection())
            {

                if (string.IsNullOrEmpty(p_curruser.Trim()))
                {
                    //functionReturnValue = null;
                    functionReturnValue = "False";
                    return functionReturnValue;
                }

                //GET EMPLOYEE INFORMATION FROM EMPLOYEE MASTER USING EMAIL ADDRESS OF EMPLOYEE.
                SQL = "select * from GCAWF0010110 WHERE UserID = '" + p_curruser.ToString().Trim() + "' and ROLEID = 'VR02' ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {

                    functionReturnValue = "True";
                    dr.Close();
                    isdrOpen = false;
                }
                else
                {
                    ERROR_MESSAGE = "Message: Your information is not updated in the system.<br/>";
                    ERROR_MESSAGE += "Kindly contact IT Helpdesk to update the information [" + p_curruser.ToString().Trim() + "].";
                    return functionReturnValue;
                }
                //functionReturnValue = "True";
            }
            CloseConnection();
            return functionReturnValue;

        }

        //public DataTable ReturnCategory()
        //{
        //    DataTable functionReturnValue = default(DataTable);
        //    functionReturnValue = null;

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;
        //        SQL = " select * from [GCAA_CATEGORY] ";

        //        sqlComm.CommandText = SQL;
        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);

        //        functionReturnValue = dt.Tables[0];
        //    }

        //    CloseConnection();
        //    return functionReturnValue;
        //}


        public string ReturnToEmailAddressADG(string _RoleID)
        {
            string functionReturnValue = null;
            functionReturnValue = "";


            if (OpenConnection())
            {


                SQL = "SELECT AD.EmailAddress";
                SQL += " FROM GCAWF0010110 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.UserID = AD.LoginName";
                SQL += " WHERE RoleID = '" + _RoleID + "'  ";

                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        functionReturnValue += dr[0].ToString() + ",";
                    }
                }
                dr.Close();
                if (!string.IsNullOrEmpty(functionReturnValue))
                {
                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                }
            }
            CloseConnection();
            return functionReturnValue;

        }

        //public DataTable ReturnLocation()
        //{
        //    DataTable functionReturnValue = default(DataTable);
        //    functionReturnValue = null;

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;
        //        SQL = " select Distinct(locatnid) from UPr00100 where locatnid <> '' AND locatnid in ('Abu Dhabi      ','DUABI          ','SZC            ') ";

        //        sqlComm.CommandText = SQL;
        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);

        //        functionReturnValue = dt.Tables[0];
        //    }

        //    CloseConnection();
        //    return functionReturnValue;
        //}

        //public DataTable ReturnCurency()
        //{
        //    DataTable functionReturnValue = default(DataTable);
        //    functionReturnValue = null;

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;
        //        SQL = " select DISTINCT(CURNCYID) from gcaa..POP10100 WHERE CURNCYID<>'' ORDER BY 1 ";

        //        sqlComm.CommandText = SQL;
        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);

        //        functionReturnValue = dt.Tables[0];
        //    }

        //    CloseConnection();
        //    return functionReturnValue;
        //}

        public DataTable ReturnDivDep()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = "SELECT distinct divcode+'-'+depcode AS CODE, rtrim(DIVSHRTDESC_EN)+'-'+DEPSHRTDESC_EN as NAME FROM GCAA_COMBINE_API_UPR00100 where DIVSHRTDESC_EN IS NOT NULL or DEPSHRTDESC_EN IS NOT NULL";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }

            CloseConnection();
            return functionReturnValue;
        }



        public bool SaveUserRecord()
        {
            bool functionReturnValue = false;

            string DocumentId = "";
            double ApprovalPass = 0;
            double RejectPass = 0;
            Random rdmNumber = new Random();

            ApprovalPass = rdmNumber.NextDouble();
            RejectPass = rdmNumber.NextDouble();
            do
            {
                if (RejectPass == ApprovalPass)
                {
                    RejectPass = rdmNumber.NextDouble();
                }
                if (ApprovalPass != RejectPass)
                {
                    break; // TODO: might not be correct. Was : Exit Do
                }
            } while (true);

            functionReturnValue = false;

            if (OpenConnection())
            {

                if (MRInfo["DocumentId"].ToString().Contains("New"))
                {
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    SQL = "SELECT MAX(DocumentId) FROM GCAAD0210101 WHERE RIGHT(LEFT(documentID, 7), 4) = '" + DateTime.Now.Year + "'";
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    if (dt.Tables.Count > 0)
                    {
                        if (dt.Tables[0].Rows.Count > 0)
                        {
                            DocumentId = dt.Tables[0].Rows[0][0].ToString();
                        }
                    }

                    if (string.IsNullOrEmpty(DocumentId))
                    {
                        DocumentId = "VR-" + DateTime.Now.Year + "-0000001";
                    }
                    else
                    {
                        DocumentId = "VR-" + DateTime.Now.Year + "-" + Strings.Format(Conversion.Val(Strings.Right(DocumentId, 7)) + 1, "0000000");
                    }

                    //[GCAA_MR_SAVEMASTERRECORD]

                    SQL = "GCAA_VR_SAVEMASTERRECORD";
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlComm.CommandText = SQL;

                    sqlComm.Parameters.Clear();

                    sqlComm.Parameters.Add("@UserId", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DocumentId", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DocumentDate", SqlDbType.DateTime);
                    sqlComm.Parameters.Add("@EmployID", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DisplayName", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@Email", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@DivisionCode", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DepartmentCode", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@VehicleNo", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@MobilePhone", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@From", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@To", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@DepartureDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@ReturnDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@TripType", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Driver", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Comments", SqlDbType.VarChar, 200);
                    sqlComm.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100);
                    sqlComm.Parameters.Add("@CreatedDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@ApprovalPass", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@RejectPass", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@LineManagerName", SqlDbType.VarChar, 100);
                    sqlComm.Parameters.Add("@LineManagerEmail", SqlDbType.VarChar, 100);
                    sqlComm.Parameters.Add("@Location", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@ReturnHour", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@ReturnMinutes", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DepartureHour", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DepartureMinutes", SqlDbType.VarChar, 50);

                   

                    sqlComm.Parameters["@UserId"].Value = MRInfo["UserId"];
                    sqlComm.Parameters["@DocumentId"].Value = DocumentId;
                    //sqlComm.Parameters["@DocumentDate"].Value = DateTime.Parse(MRInfo["DocumentDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@DocumentDate"].Value = DateTime.Parse(MRInfo["DocumentDate"].ToString(), new CultureInfo("en-US"));
                    sqlComm.Parameters["@EmployID"].Value = MRInfo["UserEmployeeID"];
                    sqlComm.Parameters["@DisplayName"].Value = MRInfo["UserName"];
                    sqlComm.Parameters["@Email"].Value = MRInfo["UserEmail"];
                    sqlComm.Parameters["@DivisionCode"].Value = MRInfo["DivisionCode"];
                    sqlComm.Parameters["@DepartmentCode"].Value = MRInfo["DepartmentCode"];
                    sqlComm.Parameters["@VehicleNo"].Value = MRInfo["VehicleNo"];
                    sqlComm.Parameters["@MobilePhone"].Value = MRInfo["MobilePhone"];
                    sqlComm.Parameters["@From"].Value = MRInfo["From"];
                    sqlComm.Parameters["@To"].Value = MRInfo["To"];
                    sqlComm.Parameters["@DepartureDate"].Value = DateTime.Parse(MRInfo["DepartureDate"].ToString(), new CultureInfo("en-US"));
                    sqlComm.Parameters["@ReturnDate"].Value = DateTime.Parse(MRInfo["ReturnDate"].ToString(), new CultureInfo("en-US"));
                    sqlComm.Parameters["@TripType"].Value = MRInfo["TripType"];
                    sqlComm.Parameters["@Driver"].Value = MRInfo["Driver"];
                    sqlComm.Parameters["@Comments"].Value = MRInfo["Comments"];
                    sqlComm.Parameters["@CreatedBy"].Value = MRInfo["UserId"];
                    sqlComm.Parameters["@CreatedDate"].Value = MRInfo["CreatedDate"];
                    sqlComm.Parameters["@ApprovalPass"].Value = ApprovalPass;
                    sqlComm.Parameters["@RejectPass"].Value = RejectPass;
                    sqlComm.Parameters["@LineManagerName"].Value = MRInfo["LineManagerName"];
                    sqlComm.Parameters["@LineManagerEmail"].Value = MRInfo["LineManagerEmail"];
                    sqlComm.Parameters["@Location"].Value = MRInfo["Location"];
                    sqlComm.Parameters["@ReturnHour"].Value = MRInfo["ReturnHour"];
                    sqlComm.Parameters["@ReturnMinutes"].Value = MRInfo["ReturnMinutes"];
                    sqlComm.Parameters["@DepartureHour"].Value = MRInfo["DepartureHour"];
                    sqlComm.Parameters["@DepartureMinutes"].Value = MRInfo["DepartureMinutes"];




                    sqlComm.ExecuteNonQuery();
                    if (MRInfo.Contains("DocumentId"))
                    {
                        MRInfo.Remove("DocumentId");
                    }
                    MRInfo.Add(DocumentId, "DocumentID", null, null);

                    SQL = " UPDATE GCAAD0210100 SET Availability = 'No' WHERE DocumentID ='" + MRInfo["VehicleNo"].ToString() + "' ";
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    sqlComm.CommandText = SQL;
                    // code changes from here to be uncommented
                    sqlComm.ExecuteNonQuery();
                }
                else
                {
                    DocumentId = MRInfo["DocumentID"].ToString();
                }

                functionReturnValue = true;
            }
            CloseConnection();
            return functionReturnValue;


        }
        public bool SaveUserRecord_VehicleMaster()
        {
            bool functionReturnValue = false;

            string DocumentId = "";
            Random rdmNumber = new Random();

            functionReturnValue = false;

            if (OpenConnection())
            {

                if (MRInfo["DocumentID"].ToString().Contains("New"))
                {
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    SQL = "SELECT MAX(DocumentID) FROM GCAAD0210100 ";
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    if (dt.Tables.Count > 0)
                    {
                        if (dt.Tables[0].Rows.Count > 0)
                        {
                            DocumentId = dt.Tables[0].Rows[0][0].ToString();
                        }
                    }


                    if (string.IsNullOrEmpty(DocumentId))
                    {
                        DocumentId = "VM-0000001";
                    }
                    else
                    {
                        DocumentId = "VM-" + Strings.Format(Conversion.Val(Strings.Right(DocumentId, 7)) + 1, "0000000");
                    }

                    //[GCAA_VM_SAVEMASTERRECORD]
                    if (MRInfo["DocumentID"].ToString().Contains("New"))
                    {
                        SQL = "GCAA_VM_SAVEMASTERRECORD";
                        sqlComm = new SqlCommand();
                        sqlComm.Connection = sqlConn;
                        sqlComm.CommandType = CommandType.StoredProcedure;
                        sqlComm.CommandText = SQL;

                        sqlComm.Parameters.Clear();

                        sqlComm.Parameters.Add("@DocumentID", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@ChasisNumber", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@Color", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@Make", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@Name", SqlDbType.VarChar, 150);
                        sqlComm.Parameters.Add("@ODOMeter", SqlDbType.Decimal, 18);
                        sqlComm.Parameters.Add("@OilChangeDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@RegistrationExpiryDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@RegistrationNumber", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@SalikAccountNumber", SqlDbType.VarChar, 75);
                        sqlComm.Parameters.Add("@TyreChangeDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@InsuranceCompany", SqlDbType.VarChar, 75);
                        sqlComm.Parameters.Add("@InsurancePolicyNumber", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@EngineNumber", SqlDbType.VarChar, 75);
                        sqlComm.Parameters.Add("@LastServiceDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@Availability", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@Model", SqlDbType.VarChar, 50);
                        sqlComm.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100);
                        sqlComm.Parameters.Add("@CreatedDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@InsuranceExpiryDate", SqlDbType.Date);
                        sqlComm.Parameters.Add("@Location", SqlDbType.VarChar, 100);

                        sqlComm.Parameters["@DocumentID"].Value = DocumentId;
                        sqlComm.Parameters["@ChasisNumber"].Value = MRInfo["ChasisNumber"];
                        sqlComm.Parameters["@Color"].Value = MRInfo["Color"];
                        sqlComm.Parameters["@Make"].Value = MRInfo["Make"];
                        sqlComm.Parameters["@Name"].Value = MRInfo["Name"];
                        sqlComm.Parameters["@ODOMeter"].Value = Convert.ToDecimal(MRInfo["ODOMeter"]);
                        sqlComm.Parameters["@OilChangeDate"].Value = DateTime.Parse(MRInfo["OilChangeDate"].ToString(), new CultureInfo("en-GB"));
                        sqlComm.Parameters["@RegistrationExpiryDate"].Value = DateTime.Parse(MRInfo["RegistrationExpiryDate"].ToString(), new CultureInfo("en-GB"));
                        sqlComm.Parameters["@RegistrationNumber"].Value = MRInfo["RegistrationNumber"];
                        sqlComm.Parameters["@SalikAccountNumber"].Value = MRInfo["SalikAccountNumber"];
                        sqlComm.Parameters["@TyreChangeDate"].Value = DateTime.Parse(MRInfo["TyreChangeDate"].ToString(), new CultureInfo("en-GB"));
                        sqlComm.Parameters["@InsuranceCompany"].Value = MRInfo["InsuranceCompany"];
                        sqlComm.Parameters["@InsurancePolicyNumber"].Value = MRInfo["InsurancePolicyNumber"];
                        sqlComm.Parameters["@EngineNumber"].Value = MRInfo["EngineNumber"];
                        sqlComm.Parameters["@LastServiceDate"].Value = DateTime.Parse(MRInfo["LastServiceDate"].ToString(), new CultureInfo("en-GB"));
                        sqlComm.Parameters["@Availability"].Value = MRInfo["Availability"];
                        sqlComm.Parameters["@Model"].Value = MRInfo["Model"];
                        sqlComm.Parameters["@CreatedBy"].Value = MRInfo["CreatedBy"];
                        sqlComm.Parameters["@CreatedDate"].Value = MRInfo["CreatedDate"];
                        sqlComm.Parameters["@InsuranceExpiryDate"].Value = DateTime.Parse(MRInfo["InsuranceExpiryDate"].ToString(), new CultureInfo("en-GB"));
                        sqlComm.Parameters["@Location"].Value = MRInfo["Location"];

                        sqlComm.ExecuteNonQuery();
                    }

                    if (MRInfo.Contains("DocumentID"))
                    {
                        MRInfo.Remove("DocumentID");
                    }
                    MRInfo.Add(DocumentId, "DocumentID", null, null);

                }
                else
                {
                    // code changes from here *
                    DocumentId = MRInfo["DocumentID"].ToString();

                    SQL = "GCAA_VM_UPDATEMASTERRECORD";
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlComm.CommandText = SQL;

                    sqlComm.Parameters.Clear();

                    sqlComm.Parameters.Add("@DocumentID", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@ChasisNumber", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Color", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Make", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Name", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@ODOMeter", SqlDbType.Decimal, 18);
                    sqlComm.Parameters.Add("@OilChangeDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@RegistrationExpiryDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@RegistrationNumber", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@SalikAccountNumber", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@TyreChangeDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@InsuranceCompany", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@InsurancePolicyNumber", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@EngineNumber", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@LastServiceDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@InsuranceExpiryDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@Availability", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Model", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100);
                    sqlComm.Parameters.Add("@CreatedDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@Location", SqlDbType.VarChar, 100);


                    sqlComm.Parameters["@DocumentID"].Value = MRInfo["DocumentID"];
                    sqlComm.Parameters["@ChasisNumber"].Value = MRInfo["ChasisNumber"];
                    sqlComm.Parameters["@Color"].Value = MRInfo["Color"];
                    sqlComm.Parameters["@Make"].Value = MRInfo["Make"];
                    sqlComm.Parameters["@Name"].Value = MRInfo["Name"];
                    sqlComm.Parameters["@ODOMeter"].Value = Convert.ToDecimal(MRInfo["ODOMeter"]);
                    sqlComm.Parameters["@OilChangeDate"].Value = DateTime.Parse(MRInfo["OilChangeDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@RegistrationExpiryDate"].Value = DateTime.Parse(MRInfo["RegistrationExpiryDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@RegistrationNumber"].Value = MRInfo["RegistrationNumber"];
                    sqlComm.Parameters["@SalikAccountNumber"].Value = MRInfo["SalikAccountNumber"];
                    sqlComm.Parameters["@TyreChangeDate"].Value = DateTime.Parse(MRInfo["TyreChangeDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@InsuranceCompany"].Value = MRInfo["InsuranceCompany"];
                    sqlComm.Parameters["@InsurancePolicyNumber"].Value = MRInfo["InsurancePolicyNumber"];
                    sqlComm.Parameters["@EngineNumber"].Value = MRInfo["EngineNumber"];
                    sqlComm.Parameters["@LastServiceDate"].Value = DateTime.Parse(MRInfo["LastServiceDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@InsuranceExpiryDate"].Value = DateTime.Parse(MRInfo["InsuranceExpiryDate"].ToString(), new CultureInfo("en-GB"));
                    sqlComm.Parameters["@Availability"].Value = MRInfo["Availability"];
                    sqlComm.Parameters["@Model"].Value = MRInfo["Model"];
                    sqlComm.Parameters["@CreatedBy"].Value = MRInfo["CreatedBy"];
                    sqlComm.Parameters["@CreatedDate"].Value = DateTime.Now.Date;
                    sqlComm.Parameters["@Location"].Value = MRInfo["Location"];
                    sqlComm.ExecuteNonQuery();

                }

                functionReturnValue = true;

            }
            CloseConnection();
            return functionReturnValue;


        }

        public bool UpdateUserRecord_VehicleMaster()
        {
            bool functionReturnValue = false;

            string DocumentId = "";
            Random rdmNumber = new Random();

            functionReturnValue = false;

            if (OpenConnection())
            {




                // code changes from here *
                DocumentId = MRInfo["DocumentID"].ToString();

                SQL = "GCAA_VM_UPDATEMASTERRECORD";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.CommandText = SQL;

                sqlComm.Parameters.Clear();

                sqlComm.Parameters.Add("@DocumentID", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@ChasisNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Color", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Make", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Name", SqlDbType.VarChar, 150);
                sqlComm.Parameters.Add("@ODOMeter", SqlDbType.Decimal, 18);
                sqlComm.Parameters.Add("@OilChangeDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@RegistrationExpiryDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@RegistrationNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@SalikAccountNumber", SqlDbType.VarChar, 75);
                sqlComm.Parameters.Add("@TyreChangeDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@InsuranceCompany", SqlDbType.VarChar, 75);
                sqlComm.Parameters.Add("@InsurancePolicyNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@EngineNumber", SqlDbType.VarChar, 75);
                sqlComm.Parameters.Add("@LastServiceDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@InsuranceExpiryDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@Availability", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Model", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 100);
                sqlComm.Parameters.Add("@CreatedDate", SqlDbType.Date);
                sqlComm.Parameters.Add("@Location", SqlDbType.VarChar, 100);

                sqlComm.Parameters["@DocumentID"].Value = MRInfo["DocumentID"];
                sqlComm.Parameters["@ChasisNumber"].Value = MRInfo["ChasisNumber"];
                sqlComm.Parameters["@Color"].Value = MRInfo["Color"];
                sqlComm.Parameters["@Make"].Value = MRInfo["Make"];
                sqlComm.Parameters["@Name"].Value = MRInfo["Name"];
                sqlComm.Parameters["@ODOMeter"].Value = Convert.ToDecimal(MRInfo["ODOMeter"]);
                sqlComm.Parameters["@OilChangeDate"].Value = DateTime.Parse(MRInfo["OilChangeDate"].ToString(), new CultureInfo("en-GB"));
                sqlComm.Parameters["@RegistrationExpiryDate"].Value = DateTime.Parse(MRInfo["RegistrationExpiryDate"].ToString(), new CultureInfo("en-GB"));
                sqlComm.Parameters["@RegistrationNumber"].Value = MRInfo["RegistrationNumber"];
                sqlComm.Parameters["@SalikAccountNumber"].Value = MRInfo["SalikAccountNumber"];
                sqlComm.Parameters["@TyreChangeDate"].Value = DateTime.Parse(MRInfo["TyreChangeDate"].ToString(), new CultureInfo("en-GB"));
                sqlComm.Parameters["@InsuranceCompany"].Value = MRInfo["InsuranceCompany"];
                sqlComm.Parameters["@InsurancePolicyNumber"].Value = MRInfo["InsurancePolicyNumber"];
                sqlComm.Parameters["@EngineNumber"].Value = MRInfo["EngineNumber"];
                sqlComm.Parameters["@LastServiceDate"].Value = DateTime.Parse(MRInfo["LastServiceDate"].ToString(), new CultureInfo("en-GB"));
                sqlComm.Parameters["@InsuranceExpiryDate"].Value = DateTime.Parse(MRInfo["InsuranceExpiryDate"].ToString(), new CultureInfo("en-GB"));
                sqlComm.Parameters["@Availability"].Value = MRInfo["Availability"];
                sqlComm.Parameters["@Model"].Value = MRInfo["Model"];
                sqlComm.Parameters["@CreatedBy"].Value = MRInfo["CreatedBy"];
                sqlComm.Parameters["@CreatedDate"].Value = MRInfo["CreatedDate"];
                sqlComm.Parameters["@Location"].Value = MRInfo["Location"];
                sqlComm.ExecuteNonQuery();

                functionReturnValue = true;

            }
            CloseConnection();
            return functionReturnValue;


        }
        public DataTable EditRecord(string record)
        {
            try
            {
                if (OpenConnection())
                {
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    SQL = " SELECT Top 1 ROW_NUMBER() OVER (ORDER BY MR.DocumentID) As RecCounter, MR.DocumentID,MR.Location,Name,Make,Model,Color,";
                    SQL += " RegistrationNumber,MR.SerialNo,Availability,ODOMEter,CONVERT(VARCHAR(10), OilChangeDate, 103) AS [OilChangeDate],";
                    SQL += " CONVERT(VARCHAR(10), LastServiceDate, 103) AS [LastServiceDate],CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS [RegistrationExpiryDate],";
                    SQL += " CONVERT(VARCHAR(10), InsuranceExpiryDate, 103) AS [InsuranceExpiryDate],displayname,mobilephone,email,GCAAD0210101.DocumentID AS DOCID,ChasisNumber,SalikAccountNumber, ";
                    SQL += " CONVERT(VARCHAR(10), TyreChangeDate, 103) AS [TyreChangeDate],InsuranceCompany,InsurancePolicyNumber,EngineNumber ";
                    SQL += " FROM GCAAD0210100 MR  ";
                    SQL += " LEFT OUTER JOIN GCAAD0210101 ";
                    SQL += " ON MR.DocumentID = GCAAD0210101.SelectedVehicleID  ";
                    SQL += " WHERE MR.DocumentID = '" + record + "' ";
                    SQL += " ORDER BY GCAAD0210101.DocumentID desc ";

                    sqlComm.CommandText = SQL;
                    dtable = null;
                    dtable = new DataTable();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dtable);
                    return dtable;
                }
                return dtable;

            }
            catch (System.Exception x)
            {
                return dtable;
            }
            finally
            {
                //return dt;
            }

        }

        public DataTable ReturnMySavedItemsList(string p_DocId)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                if (!p_DocId.Contains("**New"))
                {
                    SQL = " SELECT CONVERT(VARCHAR(10), Date, 103) AS Date,GoingFrom,GoingTo,TripType,DriverRequired,Comments,LineManagerName, ";
                    SQL += " CONVERT(VARCHAR(10), DepartureDate, 103) AS DepartureDate,CONVERT(VARCHAR(10), ReturnDate, 103) AS ReturnDate, ";
                    SQL += " GCAAD0210101.Location,GCAAD0210100.RegistrationNumber,rtrim(GCAAD0210100.Name)+'-'+rtrim(GCAAD0210100.Make) AS NAMEMAKE, ";
                    SQL += " GCAAD0210100.MODEL,GCAAD0210100.COLOR,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate, ";
                    SQL += " CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate,ReturnHour as ReturnHour, ReturnMinutes as ReturnMinutes,DepartureHour as DepartureHour, DepartureMinutes as DepartureMinutes,   ";
                    SQL += " CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS RegistrationExpiryDate FROM GCAAD0210101 LEFT OUTER JOIN  ";
                    SQL += " GCAAD0210100 ON GCAAD0210101.SELECTEDVEHICLEID =  GCAAD0210100.DocumentID WHERE GCAAD0210101.DocumentID = '" + p_DocId + "' ";
                    //--SerialNo	DocumentID	DocumentDate	RequestType	BudgetCodeType	RequestedItemType	CreateUser	CreateDate	CreateUserEmail	ApprovalUser	ApprovalDate	ApprovalUserEmail	ApprovalPass	RejectPass	LineManagerApproval	IntergratedToGP	FinalStatus	CreateUserDisplayName	ApprovalUserDisplayName
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    MRInfo.Clear();
                    MRInfo.Add(dt.Tables[0].Rows[0]["Date"], "DocumentDate", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["GoingFrom"], "From", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["GoingTo"], "To", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["DepartureDate"], "DepartureDate", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["ReturnDate"], "ReturnDate", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["TripType"], "TripType", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["DriverRequired"], "Driver", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["Comments"], "Comments", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["LineManagerName"], "LineManagerName", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["Location"], "Location", null, null);

                    MRInfo.Add(dt.Tables[0].Rows[0]["DepartureHour"], "DepartureHour", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["DepartureMinutes"], "DepartureMinutes", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["ReturnHour"], "ReturnHour", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["ReturnMinutes"], "ReturnMinutes", null, null);
                    dt = null;
                    sqlAdpt = null;
                }

                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY DocumentID) As RecCounter,DocumentID, SerialNo,Name,Make,Model,Color,RegistrationNumber,ODOMeter,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate,CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate,CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS RegistrationExpiryDate,";
                SQL += " rtrim(MR.Name)+'-'+rtrim(MR.Make) AS NAMEMAKE  FROM GCAAD0210100 MR  ";
                SQL += " Where DocumentID= (SELECT SELECTEDVEHICLEID FROM GCAAD0210101 WHERE DocumentID = '" + p_DocId + "') GROUP BY DocumentID,SerialNo,Name,Make,Model,Color,RegistrationNumber,ODOMeter,LastServiceDate,OilChangeDate,RegistrationExpiryDate";

                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }

        public DataTable ReturnEMPLocation()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = " Select Distinct(LocatnID) from gcaa..UPR00100 where RTrim(LocatnID) in ('Abu Dhabi','Dubai','SZC') ";

                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }

        //public DataTable ReturnDocument(string docid)
        //{
        //    DataTable functionReturnValue = default(DataTable);
        //    functionReturnValue = null;

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;

        //        SQL = " select * from GCAAD0210101 where finalstatus = 'Final Approval' and SelectedVehicleID = '" + docid + "' ";

        //        sqlComm.CommandText = SQL;

        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);

        //        functionReturnValue = dt.Tables[0];
        //    }
        //    CloseConnection();
        //    return functionReturnValue;
        //}
        public DataTable ReturnVMList(string location)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY DocumentID) As RecCounter, DocumentID,Name,ODOMETER,Model,RegistrationNumber,";
                SQL += " SerialNo,Availability,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate,";
                SQL += " CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate,CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS RegistrationExpiryDate,";
                SQL += " ODOMeter, ";
                SQL += " GCAAD0210100.RegistrationNumber,rtrim(GCAAD0210100.Name)+'-'+rtrim(GCAAD0210100.Make) AS NAMEMAKE,";
                SQL += " GCAAD0210100.MODEL,GCAAD0210100.COLOR,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate,";
                SQL += " CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate, Location ";
                SQL += " FROM GCAAD0210100 WHERE Availability = 'Yes'";

                if (location != "")
                {
                    SQL += " And Location = '" + location + "' ";
                }

                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }

        public DataTable ReturnVMList_NAVehicles()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY MR.DocumentID) As RecCounter, MR.DocumentID,MR.Location,Name,Make,Model,Color,";
                SQL += " RegistrationNumber,MR.SerialNo,Availability,ODOMEter,CONVERT(VARCHAR(10), OilChangeDate, 103) AS [OilChangeDate],";
                SQL += " CONVERT(VARCHAR(10), LastServiceDate, 103) AS [LastServiceDate],CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS [RegistrationExpiryDate],";
                SQL += " CONVERT(VARCHAR(10), InsuranceExpiryDate, 103) AS [InsuranceExpiryDate],'' as displayname,'' as mobilephone,'' as email  ";
                SQL += " FROM GCAAD0210100 MR  ";
                SQL += " WHERE Availability = 'No' ";

                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }


        public DataTable ReturnVMList_NAVehicles_Loc(string locid)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = " SELECT TOP 1 ROW_NUMBER() OVER (ORDER BY MR.DocumentID) As RecCounter, MR.DocumentID,MR.Location,Name,Make,Model,Color,";
                SQL += " RegistrationNumber,MR.SerialNo,Availability,ODOMEter,CONVERT(VARCHAR(10), OilChangeDate, 103) AS [OilChangeDate],";
                SQL += " CONVERT(VARCHAR(10), LastServiceDate, 103) AS [LastServiceDate],CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS [RegistrationExpiryDate],";
                SQL += " CONVERT(VARCHAR(10), InsuranceExpiryDate, 103) AS [InsuranceExpiryDate],displayname,mobilephone,email,GCAAD0210101.DocumentID AS DOCID ";
                SQL += " FROM GCAAD0210100 MR  ";
                SQL += " LEFT OUTER JOIN GCAAD0210101 ON MR.DocumentID = GCAAD0210101.SelectedVehicleID  ";
                SQL += " WHERE Availability = 'No'  AND MR.Location = '" + locid + "' ";
                SQL += " ORDER BY GCAAD0210101.DocumentID desc ";
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }


        //public DataTable ReturnPC_LocationFilter(string CurUserID)
        //{
        //    DataTable functionReturnValue = default(DataTable);
        //    functionReturnValue = null;
        //    string ServiceName = "Petty Cash Request";

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;

        //        SQL = " SELECT ROW_NUMBER() OVER (ORDER BY MR.VoucherNo,MR.SerialNo) As RecCounter,MR.VoucherNo,MR.SerialNo,VoucherDate,'" + ServiceName + "' as ServiceName,VoucherSubject,ExpenseCode,Description,InvoiceNo,InvoiceAmount,";
        //        SQL += " COUNT(MRA.REQUESTID) AS Attachments FROM GCAPC0110110 MR LEFT OUTER JOIN GCAA_ESS_Leave_Attachments_PettyCash MRA ON CAST(MR.SerialNo AS VARCHAR(10)) = MRA.REQUESTID ";
        //        SQL += " LEFT OUTER JOIN GCAPC0110100 ON GCAPC0110100.VoucherNo = MR.VoucherNo";
        //        SQL += " INNER JOIN GCAPC0100100 ON GCAPC0110100.Location = GCAPC0100100.Location AND GCAPC0100100.UserID =  '" + CurUserID + "' AND IntegratedToGP IS NULL";
        //        SQL += " GROUP BY MR.VoucherNo,MR.SerialNo,VoucherDate,VoucherSubject,ExpenseCode,Description,InvoiceNo,InvoiceAmount";

        //        sqlComm.CommandText = SQL;

        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);



        //        functionReturnValue = dt.Tables[0];
        //    }
        //    CloseConnection();
        //    return functionReturnValue;
        //}

        //public string Return_Location(string CurUserID)
        //{

        //    string ServiceName = "";

        //    if (OpenConnection())
        //    {
        //        sqlComm = new SqlCommand();
        //        sqlComm.Connection = sqlConn;
        //        sqlComm.CommandType = CommandType.Text;

        //        SQL = "SELECT TOP 1 VENDNAME FROM GCAPC0110110 MR ";
        //        SQL += " LEFT OUTER JOIN GCAPC0110100 ON GCAPC0110100.VoucherNo = MR.VoucherNo";
        //        SQL += " INNER JOIN GCAPC0100100 ON GCAPC0110100.Location = GCAPC0100100.Location AND GCAPC0100100.UserID = '" + CurUserID + "' AND IntegratedToGP IS NULL";
        //        SQL += " LEFT OUTER JOIN";
        //        SQL += " (SELECT DISTINCT (gcaa..GCAA1002.VENDORID),rtrim(gcaa..GCAA1002.VENDORID) + '-' + replace(VENDNAME,'CASH-','')  AS VENDNAME from gcaa..GCAA1002 ";
        //        SQL += " LEFT OUTER JOIN gcaa..PM00200 ON gcaa..GCAA1002.VENDORID = gcaa..PM00200.VENDORID) TR";
        //        SQL += " ON TR.VENDORID = GCAPC0110100.Location";
        //        sqlComm.CommandText = SQL;

        //        dt = null;
        //        dt = new DataSet();
        //        sqlAdpt = new SqlDataAdapter(sqlComm);
        //        sqlAdpt.Fill(dt);

        //        if (dt.Tables.Count > 0)
        //        {
        //            if (dt.Tables[0].Rows.Count > 0)
        //            {
        //                ServiceName = dt.Tables[0].Rows[0][0].ToString();
        //            }
        //        }
        //    }
        //    CloseConnection();
        //    return ServiceName;
        //}
        public void DeleteMRLine(string p_ID)
        {

            if (OpenConnection())
            {
                SQL = "Delete From GCAAD0210101 Where SerialNo = " + p_ID;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlComm.ExecuteNonQuery();

            }
            CloseConnection();

        }
        public DataTable ReturnTransportRequests(int leaveStatus, string _EmployeeEmailAddress, string _CurrentUser)
        {
            DataTable functionReturnValue = default(DataTable);

            functionReturnValue = null;

            if (OpenConnection())
            {
                SQL = " SELECT PC.SerialNo,PC.DocumentID,CONVERT(VARCHAR(10), PC.Date, 103) AS Date,PC.EMPLOYID,PC.DisplayName,PC.EMail,PC.Division_Code,PC.Department_Code,PC.LineManagerName,PC.DriverRequired, ";
                SQL += " GCAAD0210100.Name,GCAAD0210100.RegistrationNumber,ApprovalPass,RejectPass,PC.FinalStatus,CONVERT(VARCHAR(10), DepartureDate, 103) AS DepartureDate,CONVERT(VARCHAR(10), ReturnDate, 103) AS ReturnDate FROM GCAAD0210101 PC ";
                SQL += " LEFT OUTER JOIN GCAAD0210100 ON PC.SelectedVehicleID = GCAAD0210100.DocumentID LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON PC.UserID = AD.LoginName ";
                SQL += " Where 1 = 1 ";
                switch (leaveStatus)
                {
                    case 0:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                    case 1:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "'";
                        break;
                    case 2:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Submited'";
                        break;
                    case 3:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And  FinalStatus IN ('Approval','Final Approval')";
                        break;
                    case 4:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Reject'";
                        break;
                    case 5:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                    case 6:
                        SQL += " And LineManagerEmail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Submited'";
                        // code changes from here
                        SQL += " UNION ALL";
                        //---CHECK LINE MANAGER IF HE IS MEMBER OF ANY ROLE.
                        SQL += " SELECT PC.SerialNo,PC.DocumentID,CONVERT(VARCHAR(10), PC.Date, 103) AS Date,PC.EMPLOYID,PC.DisplayName,PC.EMail,PC.Division_Code,PC.Department_Code,PC.LineManagerName,PC.DriverRequired, ";
                        SQL += " GCAAD0210100.Name,GCAAD0210100.RegistrationNumber,ApprovalPass,RejectPass,PC.FinalStatus,CONVERT(VARCHAR(10), DepartureDate, 103) AS DepartureDate,CONVERT(VARCHAR(10), ReturnDate, 103) AS ReturnDate FROM GCAAD0210101 PC ";
                        SQL += " LEFT OUTER JOIN GCAAD0210100 ON PC.SelectedVehicleID = GCAAD0210100.DocumentID LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON PC.UserID = AD.LoginName ";
                        SQL += " Where 1 = 1 ";
                        SQL += " AND PC.DocumentID IN ";
                        SQL += " (select DocumentNumber from GCAWF0010120 where eServiceID = 'AD02Transport' AND WorkflowID = 'VR0201' AND StepNumber IN (";
                        SQL += " select StepNumber - 1 from GCAWF0010111 WHERE eServiceID = 'AD02Transport' AND WorkflowID = 'VR0201' AND RoleID IN ";
                        SQL += " (select RoleID from GCAWF0010110 WHERE UserID = '" + _CurrentUser + "'))) And FinalStatus NOT IN ('Final Approval','Reject') ";

                        // code changes till here
                        break;
                    case 7:
                        //SQL += " And LineManagerEmail = '" + _EmployeeEmailAddress + "' And  FinalStatus IN ('Approval','Final Approval')";
                        SQL += " And DocumentID In (Select Distinct DocumentNumber From GCAWF0010120 where eServiceID = 'AD02Transport' AND WorkflowID in ('VR0201') And ActionBy = '" + _CurrentUser + "' And Action like '%Approval%')";
                        break;
                    case 8:
                        //SQL += " And LineManagerEmail = '" + _EmployeeEmailAddress + "' And  FinalStatus IN ('Approval','Final Approval')";
                        SQL += " And DocumentID In (Select Distinct DocumentNumber From GCAWF0010120 where eServiceID = 'AD02Transport' AND WorkflowID in ('VR0201') And ActionBy = '" + _CurrentUser + "' And Action like '%Reject%' )";
                        break;
                    default:
                        SQL += " AND EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                }
                SQL += " ORDER BY DocumentID ";
                sqlComm = new SqlCommand();

                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);

                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;

        }
        public bool ReutrnMRRequestDetails(Int32 _SerialNo, double _Password)
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = "SELECT TOP 1 A.*, B.Action, B.StepNumber";
                SQL += " FROM GCAAD0210101 A";
                SQL += " LEFT OUTER JOIN GCAWF0010120 B ON A.DocumentID = B.DocumentNumber";
                SQL += " WHERE A.SerialNo = " + _SerialNo + " ";
                SQL += " AND B.eServiceID = '" + eServiceId + "' AND B.WorkflowID = '" + WorkflowID + "'";
                SQL += " And (ApprovalPass = '" + _Password + "' Or RejectPass = '" + _Password + "')";
                SQL += " ORDER BY B.StepNumber DESC";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                MRInfo.Clear();
                MRInfo.Add(eServiceId, "eServiceId", null, null);
                MRInfo.Add(WorkflowID, "WorkflowID", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["DocumentID"], "DocumentNumber", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["UserId"], "CurrentUserId", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["DisplayName"], "CurrentUserName", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["EMail"], "CurrentUserEMail", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["LineManagerName"], "LineManagerName", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["LineManagerEmail"], "LineManagerEmail", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["StepNumber"], "StepNumber", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["Action"], "FinalStatus", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["ApprovalPass"], "ApprovalPass", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["RejectPass"], "RejectPass", null, null);

                if (Convert.ToDouble(dt.Tables[0].Rows[0]["ApprovalPass"]) == _Password)
                {
                    MRInfo.Add("Approved using Email", "Comments", null, null);
                }
                else if (Convert.ToDouble(dt.Tables[0].Rows[0]["RejectPass"]) == _Password)
                {
                    MRInfo.Add("Rejected using Email", "Comments", null, null);
                }
                else
                {
                    MRInfo.Add("---", "Comments", null, null);
                }

                dt = null;
                sqlAdpt = null;
            }
            CloseConnection();
            return functionReturnValue;
        }



    }

    public class VehicleMaintenanceRequest_DAL
    {
        private string eServiceId = "AD07VehicleMaintenance";
        private string WorkflowID = "VT0701";
        private SqlConnection sqlConn;
        private string SQL;
        private string Provider;
        private SqlDataAdapter sqlAdpt;
        private SqlDataReader dr;
        private SqlCommand sqlComm;

        private DataSet dt;
        private Collection m_EmployeeInfo = new Collection();
        private Collection m_MRInfo = new Collection();
        private bool issqlDrOpen = false;

        public string ERROR_MESSAGE = "";
        public Collection EmployeeInfo
        {
            get { return m_EmployeeInfo; }
            set { m_EmployeeInfo = value; }
        }

        public Collection MRInfo
        {
            get { return m_MRInfo; }
            set { m_MRInfo = value; }
        }

        public string GetRecordUser(string p_curruser)
        {
            string functionReturnValue = "";
            bool isdrOpen = false;

            if (OpenConnection())
            {

                if (string.IsNullOrEmpty(p_curruser.Trim()))
                {
                    //functionReturnValue = null;
                    functionReturnValue = "";
                    return functionReturnValue;
                }

                //GET EMPLOYEE INFORMATION FROM EMPLOYEE MASTER USING EMAIL ADDRESS OF EMPLOYEE.
                SQL = "select Userid from GCAAD0710100 WHERE documentid = '" + p_curruser.ToString().Trim() + "'  ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0].Rows[0][0].ToString();
                //functionReturnValue = "True";
            }
            CloseConnection();
            return functionReturnValue;

        }
        private bool CloseConnection()
        {
            bool functionReturnValue = false;
            try
            {
                if (sqlConn == null)
                {
                    functionReturnValue = true;
                    return functionReturnValue;
                }

                if (sqlConn.State == ConnectionState.Open)
                {
                    sqlConn.Close();
                    sqlConn.Dispose();
                    functionReturnValue = true;
                }
            }
            catch (Exception ex)
            {
                functionReturnValue = false;
            }
            return functionReturnValue;
        }

        private bool OpenConnection()
        {
            bool functionReturnValue = false;
            functionReturnValue = false;
            sqlConn = new SqlConnection();

            //Provider = "Data Source=AUHMDGPDBP01\\AUHMDGPDBP01;Initial Catalog=gcaaapps;User Id=;Password=;";
            Provider = ConfigurationManager.ConnectionStrings["FMSConnString"].ConnectionString;
            sqlConn.ConnectionString = Provider;
            sqlConn.Open();
            functionReturnValue = true;
            return functionReturnValue;

        }

        public bool GetEmployeeInformation(string p_Email)
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            bool isdrOpen = false;

            if (OpenConnection())
            {

                if (string.IsNullOrEmpty(p_Email.Trim()) | !p_Email.Contains("@"))
                {
                    //functionReturnValue = null;
                    functionReturnValue = false;
                    return functionReturnValue;
                }

                //GET EMPLOYEE INFORMATION FROM EMPLOYEE MASTER USING EMAIL ADDRESS OF EMPLOYEE.
                SQL = "SELECT * FROM GCAA_COMBINE_API_UPR00100  LEFT OUTER JOIN GCAA_USER_INFO ON GCAA_USER_INFO.EmployID = GCAA_COMBINE_API_UPR00100.Employid WHERE GCAA_COMBINE_API_UPR00100.EMAIL = '" + p_Email.ToString().Trim() + "'";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        isdrOpen = true;
                        if (string.IsNullOrEmpty(dr["EMPLOYID"].ToString().Trim()))
                        {
                            ERROR_MESSAGE = "Message: Employee id is not found for specified email address [" + p_Email.ToString().Trim() + "]";
                            return functionReturnValue;
                        }
                        //DIVLONGDESC_EN	DIVSHRTDESC_EN	DIVLONGDESC_AR	DEPLONGDESC_ENG	DEPLONGDESC_AR	DEPSHRTDESC_EN
                        //EMPLOYID	EMPLCLAS	INACTIVE	LASTNAME	FRSTNAME	MIDLNAME	ADRSCODE	SOCSCNUM	BRTHDATE	GENDER	ETHNORGN	Calc_Min_Wage_Bal	DIVISIONCODE_I	DEPRTMNT	JOBTITLE	SUPERVISORCODE_I	LOCATNID	WCACFPAY	ACTINDX	WKHRPRYR	STRTDATE	DEMPINAC	RSNEMPIN	MINETPAY	SUTASTAT	WRKRCOMP	ATACRVAC	VACCRAMT	VACCRMTH	VACAPRYR	VACAVLBL	WRNVCNFLSBLWZR	ATACRSTM	STMACMTH	SKTMACAM	SIKTIMAV	SKTMHPYR	WRNSTFLSBLWZR	USERDEF1	USERDEF2	EMPLOYMENTTYPE	MARITALSTATUS	BENADJDATE	LASTDAYWORKED_I	BIRTHDAY	BIRTHMONTH	SPOUSE	SPOUSESSN	NICKNAME	ALTERNATENAME	HRSTATUS	DATEOFLASTREVIEW_I	DATEOFNEXTREVIEW_I	BENEFITEXPIRE_I	HANDICAPPED	VETERAN	VIETNAMVETERAN	DISABLEDVETERAN	UNIONEMPLOYEE	SMOKER_I	CITIZEN	VERIFIED	I9RENEW	Primary_Pay_Record	CHANGEBY_I	CHANGEDATE_I	NOTEINDX	NOTEINDX2	UNIONCD	RATECLSS	FEDCLSSCD	OTHERVET	Military_Discharge_Date	EMPLSUFF	STATUSCD	Workflow_Approval_Status	Workflow_Priority	AFSMVET	RECSEPVET	DEX_ROW_TS	DEX_ROW_ID	EMAIL	DIVCODE	DEPCODE
                        string ab;
                        EmployeeInfo.Clear();
                        EmployeeInfo.Add(dr["EMPLOYID"], "EMPLOYEE ID", null, null);
                        EmployeeInfo.Add(dr["DIVCODE"], "DIVCODE", null, null);
                        EmployeeInfo.Add(dr["DEPCODE"].ToString(), "DEPCODE", null, null);

                        EmployeeInfo.Add(dr["DIVLONGDESC_EN"].ToString(), "DIVLONGDESC_EN", null, null);
                        EmployeeInfo.Add(dr["DEPLONGDESC_ENG"].ToString(), "DEPLONGDESC_ENG", null, null);
                        EmployeeInfo.Add(dr["MobilePhone"].ToString(), "MobilePhone", null, null);
                        functionReturnValue = true;
                        dr.Close();
                        isdrOpen = false;
                    }
                }
                else
                {
                    ERROR_MESSAGE = "Message: Your information is not updated in the system.<br/>";
                    ERROR_MESSAGE += "Kindly contact IT Helpdesk to update your email information [" + p_Email.ToString().Trim() + "].";
                    return functionReturnValue;
                }
                functionReturnValue = true;
            }
            CloseConnection();
            return functionReturnValue;

        }

        public string GetAdminUser(string p_curruser)
        {
            string functionReturnValue = "False";
            bool isdrOpen = false;

            if (OpenConnection())
            {

                if (string.IsNullOrEmpty(p_curruser.Trim()))
                {
                    //functionReturnValue = null;
                    functionReturnValue = "False";
                    return functionReturnValue;
                }

                //GET EMPLOYEE INFORMATION FROM EMPLOYEE MASTER USING EMAIL ADDRESS OF EMPLOYEE.
                SQL = "select * from GCAWF0010110 WHERE UserID = '" + p_curruser.ToString().Trim() + "' and ROLEID = 'VT01' ";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {

                    functionReturnValue = "True";
                    dr.Close();
                    isdrOpen = false;
                }
                else
                {
                    ERROR_MESSAGE = "Message: Your information is not updated in the system.<br/>";
                    ERROR_MESSAGE += "Kindly contact IT Helpdesk to update the information [" + p_curruser.ToString().Trim() + "].";
                    return functionReturnValue;
                }
                //functionReturnValue = "True";
            }
            CloseConnection();
            return functionReturnValue;

        }

        public DataTable ReturnVehicle()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = " SELECT * FROM GCAAD0210100 ";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }

            CloseConnection();
            return functionReturnValue;
        }

        public string ReturnModel(string docid)
        {
            string ret = "";
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = " SELECT Model FROM GCAAD0210100 where documentID = '" + docid + "'  ";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);
                if (dt.Tables[0].Rows.Count > 0)
                { ret = dt.Tables[0].Rows[0][0].ToString(); }
                else { ret = ""; }

                return ret;
            }

            CloseConnection();
            return ret;
        }
        public DataTable ReturnService()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = " SELECT * FROM GCAAD0700100 ";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }

            CloseConnection();
            return functionReturnValue;
        }
        public DataTable ReturnDivDep()
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                SQL = "SELECT distinct divcode+'-'+depcode AS CODE, rtrim(DIVSHRTDESC_EN)+'-'+DEPSHRTDESC_EN as NAME FROM GCAA_COMBINE_API_UPR00100 where DIVSHRTDESC_EN IS NOT NULL or DEPSHRTDESC_EN IS NOT NULL";

                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }

            CloseConnection();
            return functionReturnValue;
        }




        public string ReturnToEmailAddressADG(string _RoleID)
        {
            string functionReturnValue = null;
            functionReturnValue = "";


            if (OpenConnection())
            {


                SQL = "SELECT AD.EmailAddress";
                SQL += " FROM GCAWF0010110 WF";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON WF.UserID = AD.LoginName";
                SQL += " WHERE RoleID = '" + _RoleID + "'  ";

                sqlComm = null;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                dr = sqlComm.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        functionReturnValue += dr[0].ToString() + ",";
                    }
                }
                dr.Close();
                if (!string.IsNullOrEmpty(functionReturnValue))
                {
                    functionReturnValue = Strings.Left(functionReturnValue, Strings.Len(functionReturnValue) - 1);
                }
            }
            CloseConnection();
            return functionReturnValue;

        }
        public bool SaveUserRecord()
        {
            bool functionReturnValue = false;

            string DocumentId = "";
            double ApprovalPass = 0;
            double RejectPass = 0;
            Random rdmNumber = new Random();

            ApprovalPass = rdmNumber.NextDouble();
            RejectPass = rdmNumber.NextDouble();
            do
            {
                if (RejectPass == ApprovalPass)
                {
                    RejectPass = rdmNumber.NextDouble();
                }
                if (ApprovalPass != RejectPass)
                {
                    break; // TODO: might not be correct. Was : Exit Do
                }
            } while (true);

            functionReturnValue = false;

            if (OpenConnection())
            {

                if (MRInfo["DocumentId"].ToString().Contains("New"))
                {
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.Text;
                    SQL = "SELECT MAX(DocumentID) FROM GCAAD0710100 WHERE RIGHT(LEFT(documentID, 7), 4) = '" + DateTime.Now.Year + "'";
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    if (dt.Tables.Count > 0)
                    {
                        if (dt.Tables[0].Rows.Count > 0)
                        {
                            DocumentId = dt.Tables[0].Rows[0][0].ToString();
                        }
                    }


                    if (string.IsNullOrEmpty(DocumentId))
                    {
                        DocumentId = "VT-" + DateTime.Now.Year + "-0000001";
                    }
                    else
                    {
                        DocumentId = "VT-" + DateTime.Now.Year + "-" + Strings.Format(Conversion.Val(Strings.Right(DocumentId, 7)) + 1, "0000000");
                    }

                    //[GCAA_MR_SAVEMASTERRECORD]

                    SQL = "GCAA_VT_SAVEMASTERRECORD";
                    sqlComm = new SqlCommand();
                    sqlComm.Connection = sqlConn;
                    sqlComm.CommandType = CommandType.StoredProcedure;
                    sqlComm.CommandText = SQL;

                    sqlComm.Parameters.Clear();

                    sqlComm.Parameters.Add("@UserId", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DocumentID", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Date", SqlDbType.Date);
                    sqlComm.Parameters.Add("@EmployID", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DisplayName", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@Email", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@DivisionCode", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@DepartmentCode", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@MobilePhone", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@SLA_In_Days", SqlDbType.Int);
                    sqlComm.Parameters.Add("@Location", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@Remarks", SqlDbType.VarChar, 150);
                    sqlComm.Parameters.Add("@ServiceDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@CreatedBy", SqlDbType.VarChar, 75);
                    sqlComm.Parameters.Add("@CreatedDate", SqlDbType.Date);
                    sqlComm.Parameters.Add("@LineManagerEmail", SqlDbType.VarChar, 100);
                    sqlComm.Parameters.Add("@ApprovalPass", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@RejectPass", SqlDbType.VarChar, 50);
                    sqlComm.Parameters.Add("@LineManagerName", SqlDbType.VarChar, 100);

                    sqlComm.Parameters["@UserId"].Value = MRInfo["UserId"];
                    sqlComm.Parameters["@DocumentID"].Value = DocumentId;
                    //sqlComm.Parameters["@Date"].Value = DateTime.Parse(MRInfo["Date"].ToString(), new CultureInfo("en-GB")).ToShortDateString();
                    sqlComm.Parameters["@Date"].Value = DateTime.Parse(MRInfo["Date"].ToString(), new CultureInfo("en-US")).ToShortDateString();
                    sqlComm.Parameters["@EmployID"].Value = MRInfo["UserEmployeeID"];
                    sqlComm.Parameters["@DisplayName"].Value = MRInfo["UserName"];
                    sqlComm.Parameters["@Email"].Value = MRInfo["UserEmail"];
                    sqlComm.Parameters["@DivisionCode"].Value = MRInfo["DivisionCode"];
                    sqlComm.Parameters["@DepartmentCode"].Value = MRInfo["DepartmentCode"];
                    sqlComm.Parameters["@MobilePhone"].Value = MRInfo["MobilePhone"];
                    sqlComm.Parameters["@SLA_In_Days"].Value = 0;
                    sqlComm.Parameters["@Location"].Value = MRInfo["Location"];
                    sqlComm.Parameters["@Remarks"].Value = MRInfo["Remarks"];
                    sqlComm.Parameters["@ServiceDate"].Value = DateTime.Parse(MRInfo["ServiceDate"].ToString(), new CultureInfo("en-GB")).ToShortDateString();
                    sqlComm.Parameters["@CreatedBy"].Value = MRInfo["CreatedBy"];
                    sqlComm.Parameters["@CreatedDate"].Value = Convert.ToDateTime(MRInfo["CreatedDate"]).ToShortDateString();
                    sqlComm.Parameters["@LineManagerEmail"].Value = MRInfo["LineManagerEmail"];
                    sqlComm.Parameters["@ApprovalPass"].Value = ApprovalPass;
                    sqlComm.Parameters["@RejectPass"].Value = RejectPass;
                    sqlComm.Parameters["@LineManagerName"].Value = MRInfo["LineManagerName"];



                    sqlComm.ExecuteNonQuery();
                    if (MRInfo.Contains("DocumentId"))
                    {
                        MRInfo.Remove("DocumentId");
                    }
                    MRInfo.Add(DocumentId, "DocumentId", null, null);

                }
                else
                {
                    DocumentId = MRInfo["DocumentId"].ToString();
                }

                SQL = "GCAA_VT_SAVEUSERRECORDS";
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.StoredProcedure;
                sqlComm.CommandText = SQL;

                sqlComm.Parameters.Clear();
                sqlComm.Parameters.Add("@DocumentId", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@UserId", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@DivisionCode", SqlDbType.VarChar, 2);
                sqlComm.Parameters.Add("@DepartmentCode", SqlDbType.VarChar, 2);
                sqlComm.Parameters.Add("@VehicleID", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@RegistrationNumber", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@ServiceSerialNo", SqlDbType.Int);
                sqlComm.Parameters.Add("@ServiceType", SqlDbType.VarChar, 100);
                sqlComm.Parameters.Add("@Model", SqlDbType.VarChar, 50);
                sqlComm.Parameters.Add("@Amount", SqlDbType.Decimal);
                sqlComm.Parameters.Add("@KM", SqlDbType.Decimal);


                sqlComm.Parameters["@DocumentId"].Value = DocumentId;
                sqlComm.Parameters["@UserId"].Value = MRInfo["UserId"];
                sqlComm.Parameters["@DivisionCode"].Value = MRInfo["DivisionCode"];
                sqlComm.Parameters["@DepartmentCode"].Value = MRInfo["DepartmentCode"];
                sqlComm.Parameters["@VehicleID"].Value = MRInfo["VehicleID"];
                sqlComm.Parameters["@RegistrationNumber"].Value = MRInfo["RegistrationNumber"];
                sqlComm.Parameters["@ServiceSerialNo"].Value = MRInfo["ServiceSerialNo"];
                sqlComm.Parameters["@ServiceType"].Value = MRInfo["ServiceType"];
                sqlComm.Parameters["@Model"].Value = MRInfo["Model"];
                sqlComm.Parameters["@Amount"].Value = MRInfo["Amount"];
                sqlComm.Parameters["@KM"].Value = MRInfo["KM"];

                sqlComm.ExecuteNonQuery();

               

                functionReturnValue = true;

            }
            CloseConnection();
            return functionReturnValue;


        }



        public DataTable ReturnMySavedItemsList(string p_DocId)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                if (!p_DocId.Contains("**New"))
                {
                    SQL = "SELECT * FROM GCAAD0710100 WHERE DocumentID = '" + p_DocId + "'";
                    //--SerialNo	DocumentID	DocumentDate	RequestType	BudgetCodeType	RequestedItemType	CreateUser	CreateDate	CreateUserEmail	ApprovalUser	ApprovalDate	ApprovalUserEmail	ApprovalPass	RejectPass	LineManagerApproval	IntergratedToGP	FinalStatus	CreateUserDisplayName	ApprovalUserDisplayName
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    MRInfo.Clear();
                    MRInfo.Add(dt.Tables[0].Rows[0]["Location"], "Location", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["ServiceDate"], "ServiceDate", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["Remarks"], "Remarks", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["Date"], "Date", null, null);

                    dt = null;
                    sqlAdpt = null;
                }

                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY MR.DocumentID) As RecCounter, MR.SerialNo,[ServiceSerialNo],[ServiceType],[VehicleID],MR.RegistrationNumber,MR.Model,[Amount],Department_Code, ";
                SQL += " COUNT(MRA.REQUESTID) AS Attachments,ODOMETER,CONVERT(VARCHAR(10), LastServiceDate, 103) AS LastServiceDate,CONVERT(VARCHAR(10), OilChangeDate, 103) AS OilChangeDate,CONVERT(VARCHAR(10), RegistrationExpiryDate, 103) AS RegistrationExpiryDate,KM FROM GCAAD0710110 MR LEFT OUTER JOIN GCAA_ESS_Leave_Attachments_VehicleMaintenance MRA ON CAST(MR.SerialNo AS VARCHAR(10)) = MRA.REQUESTID  ";
                SQL += "  LEFT OUTER JOIN [GCAAD0210100] ON MR.VehicleID = [GCAAD0210100].DocumentID  Where MR.DocumentID= '" + p_DocId + "' GROUP BY MR.DocumentID,MR.SerialNo,[ServiceSerialNo],[ServiceType],[VehicleID],MR.RegistrationNumber,MR.Model,[Amount],Department_Code,RegistrationExpiryDate,OilChangeDate,lastserviceDate,ODOMeter,KM ";

              
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }

        public DataTable ReturnMySavedItemsListNew(string p_DocId)
        {
            DataTable functionReturnValue = default(DataTable);
            functionReturnValue = null;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                if (!p_DocId.Contains("**New"))
                {
                    SQL = "SELECT * FROM GCAPC0110100 WHERE VoucherNo = '" + p_DocId + "'";
                    //--SerialNo	DocumentID	DocumentDate	RequestType	BudgetCodeType	RequestedItemType	CreateUser	CreateDate	CreateUserEmail	ApprovalUser	ApprovalDate	ApprovalUserEmail	ApprovalPass	RejectPass	LineManagerApproval	IntergratedToGP	FinalStatus	CreateUserDisplayName	ApprovalUserDisplayName
                    sqlComm.CommandText = SQL;

                    dt = null;
                    dt = new DataSet();
                    sqlAdpt = new SqlDataAdapter(sqlComm);
                    sqlAdpt.Fill(dt);

                    MRInfo.Clear();
                    MRInfo.Add(dt.Tables[0].Rows[0]["VoucherDate"], "VoucherDate", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["PreferredContact"], "PreferredContact", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["VoucherSubject"], "VoucherSubject", null, null);
                    MRInfo.Add(dt.Tables[0].Rows[0]["Location"], "Location", null, null);


                    dt = null;
                    sqlAdpt = null;
                }




                SQL = " SELECT ROW_NUMBER() OVER (ORDER BY SerialNo) As RecCounter, SerialNo,ServiceType,'false' as req, ";
                SQL += " COUNT(MRA.REQUESTID) AS Attachments FROM GCAAD0700100 MR LEFT OUTER JOIN GCAA_ESS_Leave_Attachments_VehicleMaintenance MRA ON CAST(MR.SerialNo AS VARCHAR(10)) = MRA.REQUESTID  ";
                SQL += " GROUP BY SerialNo,ServiceType ";

                
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;
        }


        public void DeleteMRLine(string p_ID)
        {

            if (OpenConnection())
            {
                SQL = "Delete From GCAAD0710110 Where SerialNo = " + p_ID;
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;
                sqlComm.ExecuteNonQuery();

            }
            CloseConnection();

        }

        public DataTable ReturnPettyCashRequests(int leaveStatus, string _EmployeeEmailAddress, string _CurrentUser)
        {
            DataTable functionReturnValue = default(DataTable);

            functionReturnValue = null;

            if (OpenConnection())
            {
                //cmbRequestTypes.Items.Add(" ") '0
                //cmbRequestTypes.Items.Add("All requests") '1
                //cmbRequestTypes.Items.Add("My inprocess requests") '2
                //cmbRequestTypes.Items.Add("My approved requests") '3
                //cmbRequestTypes.Items.Add("My rejected requests") '4
                //cmbRequestTypes.Items.Add("---------------------") '5
                //cmbRequestTypes.Items.Add("Waiting for My Approval") '6
                //cmbRequestTypes.Items.Add("Material Requests approved by me") '7

                SQL = "SELECT documentid,CONVERT(VARCHAR(10), date, 103) AS date,CONVERT(VARCHAR(10), ServiceDate, 103) AS ServiceDate,location,finalstatus,SerialNo,ApprovalPass,RejectPass ";
                SQL += " FROM GCAAD0710100 PC";
                SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON PC.UserID = AD.LoginName";
                SQL += " Where 1 = 1 ";



                //SQL = "SELECT SerialNo,VoucherNo,VoucherDate,EMPLOYID,DisplayName,EMail,Division_Code,Department_Code,LineManagerName,VoucherAmount,ApprovalPass,RejectPass,FinalStatus";
                //SQL += " FROM GCAPC0110100 PC";
                //SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON PC.CreatedBy = AD.LoginName";
                //SQL += " Where 1 = 1 ";
                switch (leaveStatus)
                {
                    case 0:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                    case 1:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "'";
                        break;
                    case 2:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Submited'";
                        break;
                    case 3:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And  FinalStatus IN ('Approval','Final Approval')";
                        break;
                    case 4:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Reject'";
                        break;
                    case 5:
                        SQL += " And EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                    case 6:
                        SQL += " And LineManagerEmail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Submited'";
                        // code changes from here
                        SQL += " UNION ALL";
                        //---CHECK LINE MANAGER IF HE IS MEMBER OF ANY ROLE.
                        SQL += " SELECT documentid,CONVERT(VARCHAR(10), date, 103) AS date,CONVERT(VARCHAR(10), ServiceDate, 103) AS ServiceDate,location,finalstatus,SerialNo,ApprovalPass,RejectPass ";
                        SQL += " FROM GCAAD0710100 PC";
                        SQL += " LEFT OUTER JOIN GCAA_ESS_ActiveDirectoryUsersList AD ON PC.UserId = AD.LoginName";
                        SQL += " Where 1 = 1 ";
                        SQL += " AND DocumentID IN ";
                        SQL += " (select DocumentNumber from GCAWF0010120 where eServiceID = 'AD07VehicleMaintenance' AND WorkflowID = 'VT0701' AND StepNumber IN (";
                        SQL += " select StepNumber - 1 from GCAWF0010111 WHERE eServiceID = 'AD07VehicleMaintenance' AND WorkflowID = 'VT0701' AND RoleID IN ";
                        SQL += " (select RoleID from GCAWF0010110 WHERE UserID = '" + _CurrentUser + "'))) And FinalStatus NOT IN ('Final Approval','Reject') ";

                        // code changes till here
                        break;
                    case 7:
                        //SQL += " And LineManagerEmail = '" + _EmployeeEmailAddress + "' And  FinalStatus IN ('Approval','Final Approval')";
                        SQL += " And DocumentID In (Select Distinct DocumentNumber From GCAWF0010120 where eServiceID = 'AD07VehicleMaintenance' AND WorkflowID in ('VT0701') And ActionBy = '" + _CurrentUser + "' And Action like '%Approval%')";
                        break;
                    case 8:
                        SQL += " And DocumentID In (Select Distinct DocumentNumber From GCAWF0010120 where eServiceID = 'AD07VehicleMaintenance' AND WorkflowID in ('VT0701') And ActionBy = '" + _CurrentUser + "' And Action like '%Reject%' )";
                        break;
                    default:
                        SQL += " AND EMail = '" + _EmployeeEmailAddress + "' And FinalStatus = 'Blank'";
                        break;
                }
                SQL += " ORDER BY DocumentID ";

                sqlComm = new SqlCommand();

                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;
                sqlComm.CommandText = SQL;

                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);

                sqlAdpt.Fill(dt);

                functionReturnValue = dt.Tables[0];
            }
            CloseConnection();
            return functionReturnValue;

        }



        public bool ReutrnMRRequestDetails(Int32 _SerialNo, double _Password)
        {
            bool functionReturnValue = false;
            functionReturnValue = false;

            if (OpenConnection())
            {
                sqlComm = new SqlCommand();
                sqlComm.Connection = sqlConn;
                sqlComm.CommandType = CommandType.Text;

                SQL = "SELECT TOP 1 A.*, B.Action, B.StepNumber";
                SQL += " FROM GCAAD0710100 A";
                SQL += " LEFT OUTER JOIN GCAWF0010120 B ON A.DocumentID = B.DocumentNumber";
                SQL += " WHERE A.SerialNo = " + _SerialNo + " ";
                SQL += " AND B.eServiceID = '" + eServiceId + "' AND B.WorkflowID = '" + WorkflowID + "'";
                SQL += " And (ApprovalPass = '" + _Password + "' Or RejectPass = '" + _Password + "')";
                SQL += " ORDER BY B.StepNumber DESC";


                sqlComm.CommandText = SQL;
                dt = null;
                dt = new DataSet();
                sqlAdpt = new SqlDataAdapter(sqlComm);
                sqlAdpt.Fill(dt);

                MRInfo.Clear();
                MRInfo.Add(eServiceId, "eServiceId", null, null);
                MRInfo.Add(WorkflowID, "WorkflowID", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["DocumentID"], "DocumentNumber", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["UserId"], "CurrentUserId", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["DisplayName"], "CurrentUserName", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["EMail"], "CurrentUserEMail", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["LineManagerName"], "LineManagerName", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["LineManagerEmail"], "LineManagerEmail", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["StepNumber"], "StepNumber", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["Action"], "FinalStatus", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["ApprovalPass"], "ApprovalPass", null, null);
                MRInfo.Add(dt.Tables[0].Rows[0]["RejectPass"], "RejectPass", null, null);

                if (Convert.ToDouble(dt.Tables[0].Rows[0]["ApprovalPass"]) == _Password)
                {
                    MRInfo.Add("Approved using Email", "Comments", null, null);
                }
                else if (Convert.ToDouble(dt.Tables[0].Rows[0]["RejectPass"]) == _Password)
                {
                    MRInfo.Add("Rejected using Email", "Comments", null, null);
                }
                else
                {
                    MRInfo.Add("---", "Comments", null, null);
                }

                dt = null;
                sqlAdpt = null;
            }
            CloseConnection();
            return functionReturnValue;
        }



    }

}
