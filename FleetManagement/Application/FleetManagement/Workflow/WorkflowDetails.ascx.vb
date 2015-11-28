Imports System.Data

Partial Class Workflow_WorkflowDetails
    Inherits System.Web.UI.UserControl
    Private objWF As New ERPEnhancementsC_DAL.ProcessWorkflow_DAL
    Private m_eServiceId As String
    Private m_WorkflowID As String
    Private m_DocumentNumber As String

    Private m_CurrentUserId As String
    Private m_CurrentUserName As String
    Private m_CurrentUserEMail As String
    Private m_LineManagerName As String
    Private m_LineManagerEmail As String
    Private m_ADGEmail As String

    Private Shared CurrentWorkflowStep As Int16 = 0
    Private CurrentWorkflowStepStatus As String = ""

    Private dt As New DataSet
    Private up As New UpdatePanel

    Public Property eServiceId() As String
        Get
            eServiceId = m_eServiceId
        End Get
        Set(ByVal value As String)
            m_eServiceId = value
        End Set
    End Property

    Public Property WorkflowID() As String
        Get
            WorkflowID = m_WorkflowID
        End Get
        Set(ByVal value As String)
            m_WorkflowID = value
        End Set
    End Property

    Public Property DocumentNumber() As String
        Get
            DocumentNumber = m_DocumentNumber
        End Get
        Set(ByVal value As String)
            m_DocumentNumber = value
        End Set
    End Property

    Public Property CurrentUserId() As String
        Get
            CurrentUserId = m_CurrentUserId
        End Get
        Set(ByVal value As String)
            m_CurrentUserId = value
        End Set
    End Property

    Public Property CurrentUserName() As String
        Get
            CurrentUserName = m_CurrentUserName
        End Get
        Set(ByVal value As String)
            m_CurrentUserName = value
        End Set
    End Property

    Public Property CurrentUserEMail() As String
        Get
            CurrentUserEMail = m_CurrentUserEMail
        End Get
        Set(ByVal value As String)
            m_CurrentUserEMail = value
        End Set
    End Property

    Public Property LineManagerName() As String
        Get
            LineManagerName = m_LineManagerName
        End Get
        Set(ByVal value As String)
            m_LineManagerName = value
        End Set
    End Property

    Public Property LineManagerEmail() As String
        Get
            LineManagerEmail = m_LineManagerEmail
        End Get
        Set(ByVal value As String)
            m_LineManagerEmail = value
        End Set
    End Property

    Public Property ADGEmail() As String
        Get
            ADGEmail = m_ADGEmail
        End Get
        Set(ByVal value As String)
            m_ADGEmail = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            lblCurrentLoginUser.Text = "Current User: " & CurrentUserName & " - " & CurrentUserId '& "<BR/>Document ID: " & DocumentNumber

            If validateControlDefaultProperties() Then
                FillCollectionValues()
                lblCurrentLoginUser.Text = "Current User: " & CurrentUserName & " - " & CurrentUserId '& "<BR/>Document ID: " & DocumentNumber


                If objWF.isUserAllowedToUseWorkflow Then
                    RefreshGridDataAndControls()

                Else
                    'User is not allowed to use workflow as per steps defined in workflow steps setup
                    cmdApprove.Visible = False
                    cmdReject.Visible = False
                    txtComments.Visible = False
                    cmdSubmit.Visible = False
                    grdDetails.Visible = False
                    lblComments.Text = "You are not autorized user to submit or process this workflow.<br/><br/>For further details kindly contact IT Helpdesk."
                    lblComments.Font.Bold = False
                    'Logger.ShowNotification("You are not autorized user to submit or process this workflow.<br/><br/>For further details kindly contact IT Helpdesk.", Logger.UiNotificationType.Notify)
                End If
            End If
        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Public Sub ReValidateWorkflowProperties()
        Try
            grdDetails.DataSource = Nothing
            grdDetails.DataBind()
            lblInfo.Visible = False
            lblComments.Text = ""
            lblComments.Visible = False

            If validateControlDefaultProperties() Then

                FillCollectionValues()
                lblCurrentLoginUser.Text = "Current User: " & CurrentUserName & " - " & CurrentUserId

                If objWF.isUserAllowedToUseWorkflow Then
                    RefreshGridDataAndControls()

                Else
                    'User is not allowed to use workflow as per steps defined in workflow steps setup
                    cmdApprove.Visible = False
                    cmdReject.Visible = False
                    txtComments.Visible = False
                    cmdSubmit.Visible = False
                    grdDetails.Visible = False
                    lblComments.Text = "You are not autorized user to submit or process this workflow.<br/><br/>For further details kindly contact IT Helpdesk."
                    lblComments.Font.Bold = False
                    'Logger.ShowNotification("You are not autorized user to submit or process this workflow.<br/><br/>For further details kindly contact IT Helpdesk.", Logger.UiNotificationType.Notify)
                End If
            End If
        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Private Sub RefreshGridDataAndControls()

        dt = Nothing
        dt = New DataSet
        dt = objWF.ReturnWorkflowDetailsComplete
        grdFullDetails.DataSource = dt.Tables(0)
        grdFullDetails.DataBind()
        If grdFullDetails.DataSource Is Nothing Then
            lblMessageFull.Text = "Select any document first to see the Workflow Details."
            lblMessageFull.Visible = True
        Else
            lblMessageFull.Text = ""
            lblMessageFull.Visible = True
        End If

        dt = Nothing
        dt = New DataSet

        dt = objWF.ReturnWorkflowDetails
        If dt.Tables.Count > 0 Then
            grdDetails.DataSource = dt.Tables(0)
            grdDetails.DataBind()
            If dt.Tables(0).Rows.Count - 1 >= 0 Then
                CurrentWorkflowStep = CType(dt.Tables(0).Rows(dt.Tables(0).Rows.Count - 1).Item("StepNumber"), Short)
                CurrentWorkflowStepStatus = CType(dt.Tables(0).Rows(dt.Tables(0).Rows.Count - 1).Item("Action"), String)
            Else
                CurrentWorkflowStep = 1
                CurrentWorkflowStepStatus = "Submit"
            End If
        End If

        cmdApprove.Visible = True
        cmdReject.Visible = True
        txtComments.Visible = True
        cmdSubmit.Visible = True
        lblComments.Visible = True

        If dt.Tables(0).Rows.Count <= 0 Then

            cmdApprove.Visible = False
            cmdReject.Visible = False
            txtComments.Visible = True
            cmdSubmit.Visible = True
            lblComments.Visible = True

        ElseIf Left(CurrentWorkflowStepStatus, 6) = "Reject" Then

            cmdApprove.Visible = False
            cmdReject.Visible = False
            If Not objWF.isUserAllowedToSubmit Then
                If objWF.eServiceWorkflowInfo.Item("eServiceId").ToString.Trim <> "HC05PARequest" Then
                    cmdSubmit.Visible = False
                    lblComments.Text = "Workflow is inprocess..."
                    txtComments.Visible = False
                End If
            End If
            Else
                cmdSubmit.Visible = False
                If objWF.isWorkflowCompleted Then
                    cmdApprove.Visible = False
                    cmdReject.Visible = False
                    lblComments.Text = "Workflow is completed..."
                    txtComments.Visible = False
                Else
                    If Not objWF.isUserAllowedToApproveReject Then
                        cmdApprove.Visible = False
                        cmdReject.Visible = False
                        lblComments.Text = "Workflow is inprocess..."
                        txtComments.Visible = False
                    End If
                End If
            End If

    End Sub

    Private Sub FillCollectionValues()
        Try
            If DocumentNumber Is Nothing Then
                objWF.eServiceWorkflowInfo.Clear()
                objWF.eServiceWorkflowInfo.Add(Session("eServiceId"), "eServiceId")
                objWF.eServiceWorkflowInfo.Add(Session("WorkflowID"), "WorkflowID")
                objWF.eServiceWorkflowInfo.Add(Session("DocumentNumber"), "DocumentNumber")
                objWF.eServiceWorkflowInfo.Add(Session("CurrentUserId"), "CurrentUserId")
                objWF.eServiceWorkflowInfo.Add(Session("CurrentUserName"), "CurrentUserName")
                objWF.eServiceWorkflowInfo.Add(Session("CurrentUserEMail"), "CurrentUserEMail")
                objWF.eServiceWorkflowInfo.Add(Session("LineManagerName"), "LineManagerName")
                objWF.eServiceWorkflowInfo.Add(Session("LineManagerEmail"), "LineManagerEmail")
                objWF.eServiceWorkflowInfo.Add(Session("ADGEmail"), "ADGEmail")
                RefreshGridDataAndControls()
            Else
                objWF.eServiceWorkflowInfo.Clear()
                objWF.eServiceWorkflowInfo.Add(eServiceId, "eServiceId")
                objWF.eServiceWorkflowInfo.Add(WorkflowID, "WorkflowID")
                objWF.eServiceWorkflowInfo.Add(DocumentNumber, "DocumentNumber")
                objWF.eServiceWorkflowInfo.Add(CurrentUserId, "CurrentUserId")
                objWF.eServiceWorkflowInfo.Add(CurrentUserName, "CurrentUserName")
                objWF.eServiceWorkflowInfo.Add(CurrentUserEMail, "CurrentUserEMail")
                objWF.eServiceWorkflowInfo.Add(LineManagerName, "LineManagerName")
                objWF.eServiceWorkflowInfo.Add(LineManagerEmail, "LineManagerEmail")
                objWF.eServiceWorkflowInfo.Add(ADGEmail, "ADGEmail")
                'objWF.eServiceWorkflowInfo.Add(Session("eServiceId"), "eServiceId")
                'objWF.eServiceWorkflowInfo.Add(Session("WorkflowID"), "WorkflowID")
                'objWF.eServiceWorkflowInfo.Add(Session("DocumentNumber"), "DocumentNumber")
                'objWF.eServiceWorkflowInfo.Add(Session("CurrentUserId"), "CurrentUserId")
                'objWF.eServiceWorkflowInfo.Add(Session("CurrentUserName"), "CurrentUserName")
                'objWF.eServiceWorkflowInfo.Add(Session("CurrentUserEMail"), "CurrentUserEMail")
                'objWF.eServiceWorkflowInfo.Add(Session("LineManagerName"), "LineManagerName")
                'objWF.eServiceWorkflowInfo.Add(Session("LineManagerEmail"), "LineManagerEmail")
                'objWF.eServiceWorkflowInfo.Add(Session("ADGEmail"), "ADGEmail")
            End If
            objWF.ServerMapPath = Server.MapPath("")

        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Protected Sub grdDetails_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles grdDetails.RowDataBound
        Try
            e.Row.HorizontalAlign = HorizontalAlign.Left
            e.Row.VerticalAlign = VerticalAlign.Middle

        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try

    End Sub

    Protected Sub cmdSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles cmdSubmit.Click

        Try
            lblErrorMessage.Visible = False
            FillCollectionValues()
            objWF.eServiceWorkflowInfo.Add(txtComments.Text, "Comments")

            If objWF.SubmitDocumentWorkflow Then
                'objWF.SendEMail(eServiceId & "_" & WorkflowID & "_" & "Submit")
                objWF.SendEMail_Pettycash(eServiceId & "_" & WorkflowID & "_" & "Submit")
                txtComments.Text = ""
                lblInfo.Text = "<br />Workflow is sucessfully submitted..."
                lblInfo.Visible = True
                Call RefreshGridDataAndControls()
            End If
            up = Me.Page.FindControl("updateMaster")
            up.Update()

        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Protected Sub cmdReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdReject.Click
        Try
            FillCollectionValues()
            objWF.eServiceWorkflowInfo.Add(txtComments.Text, "Comments")
            objWF.eServiceWorkflowInfo.Add(CurrentWorkflowStep, "StepNumber")

            If objWF.RejectDocumentWorkflow Then
                'objWF.SendEMail(eServiceId & "_" & WorkflowID & "_" & "Reject")
                objWF.SendEMail_Pettycash(eServiceId & "_" & WorkflowID & "_" & "Reject")
                txtComments.Text = ""
                lblInfo.Text = "Workflow is sucessfully rejected..."
                lblInfo.Visible = True
                Call RefreshGridDataAndControls()
            End If
            up = Me.Page.FindControl("updateMaster")
            up.Update()

        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Protected Sub cmdApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdApprove.Click
        Try
            FillCollectionValues()
            objWF.eServiceWorkflowInfo.Add(txtComments.Text, "Comments")
            objWF.eServiceWorkflowInfo.Add(CurrentWorkflowStep, "StepNumber")

            If objWF.ApproveDocumentWorkflow Then
                'objWF.SendEMail(eServiceId & "_" & WorkflowID & "_" & "Approve")
                objWF.SendEMail_Pettycash(eServiceId & "_" & WorkflowID & "_" & "Approve")
                txtComments.Text = ""
                lblInfo.Text = "Workflow is sucessfully approved..."
                lblInfo.Visible = True
                Call RefreshGridDataAndControls()
            End If
            'up = Me.Page.FindControl("updateMaster")
            'up.Update()

        Catch ex As Exception
            Logger.ShowNotification("Error occurred. Kindly contact the administrator.", Logger.UiNotificationType.Error)
            Logger.WriteErrorLog(ex)
        End Try
    End Sub

    Private Function validateControlDefaultProperties() As Boolean
        validateControlDefaultProperties = False
        If eServiceId = "" Then
            lblErrorMessage.Text = "Workflow property [ eServiceId ] is not provided."
        ElseIf WorkflowID = "" Then
            lblErrorMessage.Text = "Workflow property [ WorkflowID ] is not provided."
        ElseIf DocumentNumber = "" Then
            lblErrorMessage.Text = "You are required to save the document first to start the workflow."
        ElseIf CurrentUserId = "" Then
            lblErrorMessage.Text = "Workflow property [ CurrentUserId ] is not provided."
        ElseIf CurrentUserName = "" Then
            lblErrorMessage.Text = "Workflow property [ CurrentUserName ] is not provided."
        ElseIf CurrentUserEMail = "" Then
            lblErrorMessage.Text = "Workflow property [ CurrentUserEMail ] is not provided."
        ElseIf LineManagerName = "" Then
            lblErrorMessage.Text = "Workflow property [ LineManagerName ] is not provided."
        ElseIf LineManagerEmail = "" Then
            lblErrorMessage.Text = "Workflow property [ LineManagerEmail ] is not provided."
        ElseIf ADGEmail = "" Then
            lblErrorMessage.Text = "Workflow property [ ADGEmail ] is not provided."
        Else
            lblErrorMessage.Text = ""
        End If

        If lblErrorMessage.Text = "" Then
            validateControlDefaultProperties = True
        Else
            validateControlDefaultProperties = False
            cmdApprove.Visible = False
            cmdReject.Visible = False
            cmdSubmit.Visible = False
            txtComments.Visible = False
            lblComments.Visible = False
            lblErrorMessage.Visible = True
        End If



    End Function

End Class
