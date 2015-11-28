
Imports System.Net.Mail
Imports System.Data
Imports System.Data.SqlClient
'Imports GCAA.Web.EN_DE_Data
'Imports GCAA.Web.Mobile.LDAPAuth

Imports ERPEnhancementsC_DAL.TransportRequest_DAL
Imports ERPEnhancementsC_DAL.VehicleMaintenanceRequest_DAL
Partial Class ProcessRequests
    Inherits System.Web.UI.Page

    Const actCode_ApproveTransportRequest As Integer = 41001
    Const actCode_RejectTransportRequest As Integer = 42001

    Const actCode_ApproveVehicleMaintenance As Integer = 81001
    Const actCode_RejectVehicleMaintenance As Integer = 82001

    Dim m_ERROR_MESSAGE As String = ""

    Private objWF As New ERPEnhancementsC_DAL.ProcessWorkflow_DAL
    Private objTR As New ERPEnhancementsC_DAL.TransportRequest_DAL
    Private objVT As New ERPEnhancementsC_DAL.VehicleMaintenanceRequest_DAL

    Private eServiceId As String
    Private WorkflowID As String
    Private DocumentNumber As String
    Private CurrentUserId As String
    Private CurrentUserName As String
    Private CurrentUserEMail As String
    Private LineManagerName As String
    Private LineManagerEmail As String

    Private CurrentLoginUser As String = ""

    Public Property ERROR_MESSAGE() As String
        Get
            ERROR_MESSAGE = m_ERROR_MESSAGE
        End Get
        Set(ByVal value As String)
            m_ERROR_MESSAGE = value
        End Set
    End Property
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim ActionId As Int16 = 0, Method As Int16 = 0
        ' code changes from here following line added above commented
        Dim ActionId As Int32 = 0, Method As Int32 = 0
        Dim RequestSerial As String = "", ApprovalPass As String = "", RejectPass As String = ""
        Dim ActionBy As String = ""
        'INFO = Request.QueryString("INFO")
        'Read the User Name from Query String
        'Dim _Ladp As New LdapAuthentication()
        'Dim objEncryption = New GCAA.Web.EN_DE_Data.Algorithams()
        'Dim _Identity As String = ""
        'Dim _Password As String = ""
        'If INFO <> "" Then
        '    INFO = objEncryption.Decrypt(INFO.Replace(" ", "+"))

        '    Dim _Split() As String = INFO.Split("&")
        '    _Identity = _Split(0).Substring(_Split(0).IndexOf("=") + 1)
        'End If
        CurrentLoginUser = HttpContext.Current.User.Identity.Name.ToString.Replace("GCA\", "") '"test1" '
        'CurrentLoginUser = _Identity.ToString.Replace("gca\", "").Replace("GCA\", "")
        ActionId = Request.QueryString("ActionId")
        RequestSerial = Request.QueryString("ID")
        ApprovalPass = Request.QueryString("ApprovalPass")
        RejectPass = Request.QueryString("RejectPass")
        Method = Request.QueryString("Method")
        ActionBy = IIf(Request.QueryString("ActionBy") Is Nothing, "LineManager", Request.QueryString("ActionBy"))
        'CurrentLoginUser = "khalid.al-romaithi"
        'CurrentLoginUser = "mulkarim"
        'ActionId = actCode_ApproveHotelRequest
        'RequestSerial = 172
        'ApprovalPass = "0.569018794488636"
        'RejectPass = "0.198288789576985"
        'Method = 99
        'ActionBy = "khalid.al-romaithi"
        'http://auhmdgp02:999/anonymous/ProcessRequests.aspx?ActionId=31001&ID=29&ApprovalPass=0.866144091294214&Method=99
        Try
            
            If ActionId = actCode_ApproveTransportRequest Or ActionId = actCode_RejectTransportRequest Then
                If ActionId = actCode_ApproveTransportRequest Then
                    objTR.ReutrnMRRequestDetails(RequestSerial, ApprovalPass)
                    If objTR.MRInfo.Contains("CurrentUserId") Then
                        objTR.MRInfo.Remove("CurrentUserId") '--- New Code
                    End If
                    objTR.MRInfo.Add(CurrentLoginUser, "CurrentUserId") '--- New Code
                    objWF.eServiceWorkflowInfo = objTR.MRInfo
                    objWF.ServerMapPath = Server.MapPath("..\TransportRequest")

                    If objWF.wfApproveWorkflow() Then
                        Response.Write("Your request has been approved.")
                    End If
                End If

                If ActionId = actCode_RejectTransportRequest Then
                    objTR.ReutrnMRRequestDetails(RequestSerial, RejectPass)
                    If objTR.MRInfo.Contains("CurrentUserId") Then
                        objTR.MRInfo.Remove("CurrentUserId") '--- New Code
                    End If
                    objTR.MRInfo.Add(CurrentLoginUser, "CurrentUserId") '--- New Code
                    objWF.eServiceWorkflowInfo = objTR.MRInfo
                    objWF.ServerMapPath = Server.MapPath("..\TransportRequest")

                    If objWF.wfRejectWorkflow() Then
                        Response.Write("Your request has been rejected.")
                    End If
                End If
           
            ElseIf ActionId = actCode_ApproveVehicleMaintenance Or ActionId = actCode_RejectVehicleMaintenance Then
                If ActionId = actCode_ApproveVehicleMaintenance Then
                    objVT.ReutrnMRRequestDetails(RequestSerial, ApprovalPass)
                    If objVT.MRInfo.Contains("CurrentUserId") Then
                        objVT.MRInfo.Remove("CurrentUserId") '--- New Code
                    End If
                    objVT.MRInfo.Add(CurrentLoginUser, "CurrentUserId") '--- New Code
                    objWF.eServiceWorkflowInfo = objVT.MRInfo
                    objWF.ServerMapPath = Server.MapPath("..\VehicleMaintenance")

                    If objWF.wfApproveWorkflow() Then
                        Response.Write("Your request has been approved.")
                    End If
                End If

                If ActionId = actCode_RejectVehicleMaintenance Then
                    objVT.ReutrnMRRequestDetails(RequestSerial, RejectPass)
                    If objVT.MRInfo.Contains("CurrentUserId") Then
                        objVT.MRInfo.Remove("CurrentUserId") '--- New Code
                    End If
                    objVT.MRInfo.Add(CurrentLoginUser, "CurrentUserId") '--- New Code
                    objWF.eServiceWorkflowInfo = objVT.MRInfo
                    objWF.ServerMapPath = Server.MapPath("..\VehicleMaintenance")

                    If objWF.wfRejectWorkflow() Then
                        Response.Write("Your request has been rejected.")
                    End If
                End If



            End If
        Catch ex As Exception
            'lblMessage.Text = "Message: " & ex.Message
            Response.Write("Message: " & ex.Message)
        End Try
    End Sub
End Class
