<%@ Control Language="VB" AutoEventWireup="false" CodeFile="WorkflowDetails.ascx.vb" Inherits="Workflow_WorkflowDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<script type="text/javascript" src="../assets/javascripts/jquery.min.js"></script>

<script type="text/javascript">
    function HandleWorkflow() {
        if ($("#MainTable").css('display').toString() != 'none') {

            $("#MainTable").hide();
            $("#FullWorkflowDetails").show();
        }
        else {
            $("#MainTable").show();
            $("#FullWorkflowDetails").hide();
        }

    }
</script>

<style type="text/css">
    .BG {
        background-image: url('images/searchbg.jpg');
    }
</style>
<%-- <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>

<div style="align-items: center;">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlWorkflowTransactions" runat="server">
                <div class="panel" id="FullWorkflowDetails" style="display: none; vertical-align: bottom; align-items: center; text-align: center;">
                    <div class="panel-heading">
                        <span class="panel-title">Full Workflow Details</span>
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                    </div>

                    <asp:Label ID="lblMessageFull" runat="server" Text="Select any document first to see the Workflow Details."></asp:Label>

                    <asp:GridView ID="grdFullDetails" runat="server"
                        AutoGenerateColumns="False" EnableTheming="True" CssClass="table table-hover table-condensed">
                        <SelectedRowStyle BackColor="#2175ac" ForeColor="White" Font-Bold="true" />
                        <Columns>
                            <asp:TemplateField HeaderText="SerialNo" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerialNo" runat="server"
                                        Text='<%# Eval("SerialNo").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Attachments" Visible="false">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblAttachments" runat="server"
                                        Text='<%# Eval("Attachments").ToString() %>'></asp:Label>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblRecCounter" runat="server"
                                        Text='<%# Eval("RecCounter").ToString() %>'></asp:Label>
                                    &nbsp;&nbsp;--%>
                                    <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Eval("RecCounter").ToString() %>' Enabled="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Workflow steps">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserId" runat="server" Text='<%# Eval("UserId").ToString() %>' Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lblAction" runat="server" Text='<%# Eval("Action").ToString() %>' Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lblComments" runat="server" Text='<%# Eval("Comments").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="panel" id="MainTable" style="vertical-align: bottom; align-items: center; text-align: center;" visible="true">
                    <div class="panel-heading">
                        <span class="panel-title" style="align-items: center">Workflow Details<br />
                            <asp:Label ID="lblCurrentLoginUser" runat="server" Text=""></asp:Label></span>
                    </div>

                    <asp:GridView ID="grdDetails" runat="server"
                        AutoGenerateColumns="False" EnableTheming="True" CssClass="table table-hover table-condensed">
                        <SelectedRowStyle BackColor="#2175ac" ForeColor="White" Font-Bold="true" />
                        <Columns>
                            <asp:TemplateField HeaderText="SerialNo" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerialNo" runat="server"
                                        Text='<%# Eval("SerialNo").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Attachments" Visible="false">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblAttachments" runat="server"
                                        Text='<%# Eval("Attachments").ToString() %>'></asp:Label>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblRecCounter" runat="server"
                                        Text='<%# Eval("RecCounter").ToString() %>'></asp:Label>
                                    &nbsp;&nbsp;--%>
                                    <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Eval("RecCounter").ToString() %>' Enabled="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Workflow State Details">
                                <ItemTemplate>
                                    <asp:Label ID="lblUserId" runat="server" Text='<%# Eval("UserId").ToString() %>' Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lblAction" runat="server" Text='<%# Eval("Action").ToString() %>' Font-Bold="True"></asp:Label>
                                    <asp:Label ID="lblComments" runat="server" Text='<%# Eval("Comments").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit for Approval" CausesValidation="false"
                        OnClientClick="if (! confirm('Are you sure to submit this document for approval ?')) return false;" formnovalidate="formnovalidate" /><br />

                    <asp:Label ID="lblErrorMessage" runat="server" Font-Bold="True"
                        Text="Error: " Visible="False"></asp:Label><br />
                    <asp:Label ID="lblInfo" runat="server" Font-Bold="True"
                        Text="Error: " Visible="False" ForeColor="Black"></asp:Label><br />

                    <asp:Label ID="lblComments" runat="server" Font-Bold="True"
                        Text="Comments: "></asp:Label><br />

                    <asp:TextBox ID="txtComments" runat="server" MaxLength="500" Width="20%" Height="150px"
                        TextMode="MultiLine"></asp:TextBox><br />

                    <div class="form-group"  style="vertical-align: bottom; align-items: center; text-align: center;">
                        <center>
                        <asp:Button ID="cmdApprove" runat="server" Text="Approve" CausesValidation="false" formnovalidate="formnovalidate" OnClientClick="if (! confirm('Are you sure to approve this document ?')) return false;" CssClass="btn btn-primary" />

                        <asp:Button ID="cmdReject" runat="server" Text="Reject" CausesValidation="false" formnovalidate="formnovalidate" OnClientClick="if (! confirm('Are you sure to reject this document ?')) return false;" CssClass="btn btn-primary" />
                            </center>
                    </div>

                </div>
                <div class="panel" style="vertical-align: bottom; align-items: center; text-align: center;">
                    
                            <%--<asp:Button ID="cmdShowCurrent" runat="server" Text="Show Complete Workflow Steps" Visible="True" Width="275" Font-Names="Calibri" Font-Size="14px" />--%>
                            <a id="aTagURL_Att" href="javascript:HandleWorkflow()" runat="server" style="border-width: 0px">
                                <img src="../Images/new.jpg" alt="New functionality ..." style="border: none; height: 16px; width: 16px;" />
                                Show / Hide Complete Workflow Steps...
                            </a>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
