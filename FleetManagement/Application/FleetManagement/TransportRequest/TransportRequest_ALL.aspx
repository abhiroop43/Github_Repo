<%@ Page Language="C#" AutoEventWireup="false" CodeFile="TransportRequest_ALL.aspx.cs" Inherits="TransportRequest_TransportRequest_ALL" MasterPageFile="~/MasterPages/Site.master" %>

<%@ Register Src="../Workflow/WorkflowDetails.ascx" TagName="WorkflowDetails" TagPrefix="uc1" %>
<%@ Register Src="_TransportList.ascx" TagName="_TransportList" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <title>Transport Request</title>
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .EmployeeInfo {
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
        }

        .EmployeeInfoBold {
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
        }

        .EmployeeInfoHead {
            background-image: url('images/searchbg.jpg');
            /*font: calibri;*/
            font-family: calibri;
            font-size: 18px;
            font-weight: bold;
            color: #808080;
        }

        .style2 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
        }

        .style_textbox {
            border: solid 1px gray;
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
        }

        .auto-style1 {
            font-family: calibri;
            font-size: 13px;
            width: 191px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    
<%-- ReSharper disable once AssignedValueIsNeverUsed --%>
    <script type="text/javascript">
        function HandleAttachments(inpProcessId, otherKey) {
            //alert("test");
            var attachmentUrl = "";
            attachmentUrl = "Attachments1.aspx?ID=" + inpProcessId + "&list=" + otherKey + "&Title=Petty Cash Attachments";
            var left = Math.floor((screen.width - 900) / 2);
            var top = Math.floor((screen.height - 350) / 2);
            window.open(attachmentUrl, null, "height=350,width=800,left=" + left + ",top=" + top + ",titlebar=no,location=no,directories=no,menubar=no,toolbar=no,scroll=yes,status=no");

        }
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="updateMaster" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlLeaveRequestDetails" runat="server" CssClass="panel form-horizontal">
                <div class="panel-heading">
                    <span class="panel-title">Employee Information</span>
                </div>

                <div class="panel-body">
                    <div class="form-group">
                                <label class="col-sm-2 control-label">Employee ID</label>
                                <div class="col-sm-3">
                                     <label class="control-label"><asp:Label ID="lblEmployeeID" runat="server" Text="N/A"  Font-Bold="False"></asp:Label></label>
                        <asp:Label ID="lblUserID" runat="server" Text="N/A" Visible="False"></asp:Label>
                                </div>
                        <label class="col-sm-2 control-label">Employee Name</label>
                                <div class="col-sm-3">
                                     <label class="control-label"><asp:Label ID="lblEmployeeName" runat="server" Text="N/A"  Font-Bold="False"></asp:Label></label>
                                </div>
                            </div>
                            <!-- / .form-group -->

                    <div class="form-group">
                                <label class="col-sm-2 control-label">Employee Division</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblDivision" runat="server" Text="N/A - "  Font-Bold="False"></asp:Label></label>
                        <asp:Label ID="lblDivCode" runat="server" Text="00" Visible="False"></asp:Label>
                                </div>
                        <label class="col-sm-2 control-label">Employee Department</label>
                                <div class="col-sm-3">
                                     <label class="control-label"><asp:Label ID="lblDepartment" runat="server" Text="N/A - "  Font-Bold="False"></asp:Label></label>
                        <asp:Label ID="lblDepCode" runat="server" Text="00" Visible="False"></asp:Label>
                                </div>
                            </div>
                            <!-- / .form-group -->

                    <div class="form-group">
                                <label class="col-sm-2 control-label">Employee Phone</label>
                                <div class="col-sm-3">
                                     <label class="control-label"><asp:Label ID="lblMobileNumber" runat="server" Text="---" Font-Bold="False"></asp:Label></label>
                                </div>
                                                        <label class="col-sm-2 control-label">Employee Email</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblEmail" runat="server" Text="N/A" Font-Bold="False"></asp:Label></label>
                                </div>
                            </div>
                            <!-- / .form-group -->

                    <div class="form-group">
                                <label class="col-sm-2 control-label">Line Manager Name</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblLMName" runat="server" Text="N/A" Font-Bold="False"></asp:Label></label>
                                </div>
                         <label class="col-sm-2 control-label">Line Manager Email</label>
                                <div class="col-sm-3">
                                     <label class="control-label"><asp:Label ID="lblLMEmail" runat="server" Text="N/A" Font-Bold="False"></asp:Label></label>
                                </div>
                            </div>
                            <!-- / .form-group -->

                    <asp:Label ID="lblADGEmail" runat="server" Text="N/A" Visible="False"></asp:Label>
                        <asp:Label ID="lblLMUserID" runat="server" Text="N/A" Visible="False"></asp:Label>
                        <asp:Label ID="lblErrorMessage" runat="server" Text="Error:" Visible="False" 
                            Font-Bold="True" ForeColor="Red"></asp:Label>
                            <!-- / .form-group -->
                </div>

                <div class="panel-heading">
                    <span class="panel-title">Requests</span>
                </div>

                <div class="panel-body">
                    <ul id="transport-requests" class="nav nav-tabs">
                        <li class="active">
                            <a href="#transport-requests-new" data-toggle="tab">New Request</a>
                        </li>
                        <li class="">
                            <a href="#transport-requests-history" data-toggle="tab">Available Vehicles <span class="badge badge-primary"><%= MaterialRequestList.Rows.Count %></span></a>
                        </li>
                    </ul>

                    <div class="tab-content tab-content-bordered">
                        <div class="tab-pane fade active in" id="transport-requests-new">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Reference Number</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblDocumentID" runat="server" Font-Bold="True" Text="**New Request"></asp:Label></label>
                                </div>
                                <label class="col-sm-2 control-label">Date</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblDocumentDate" runat="server" Font-Bold="False"></asp:Label></label>
                                </div>
                            </div>
                            <!-- / .form-group -->

                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="<%= txtFrom.ClientID %>">Going From</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" MaxLength="48" required="true"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 control-label" for="<%= txtTo.ClientID %>">Going To</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtTo" runat="server" MaxLength="48" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            
                            <div class="form-group row">
                                <label class="col-sm-2 control-label">Departure Date</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtDepartureDate" runat="server" MaxLength="48" CssClass="form-control" TextMode="DateTimeLocal" required="true"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 control-label">Return Date</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtReturnDate" runat="server" MaxLength="48" CssClass="form-control" TextMode="DateTimeLocal" required="true"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="<%= rbTripType.ClientID %>">Trip Type</label>
                                <div class="col-sm-3 radio-inline">
                                    <asp:RadioButtonList ID="rbTripType" runat="server" RepeatDirection="Vertical" required="true">
                            <asp:ListItem Value="oneway">One Way</asp:ListItem>
                            <asp:ListItem Value="roundtrip">Round Trip</asp:ListItem>
                        </asp:RadioButtonList>
                                </div>
                                <label class="col-sm-2 control-label" for="<%= rbDriver.ClientID %>">Driver</label>
                                <div class="col-sm-3 radio-inline">
                                   <asp:RadioButtonList ID="rbDriver" runat="server"  RepeatDirection="Vertical" required="true">
                            <asp:ListItem Value="yes">Yes</asp:ListItem>
                            <asp:ListItem Value="no">No</asp:ListItem>
                        </asp:RadioButtonList>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="<%= txtComments.ClientID %>">Comments</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" MaxLength="120" required="true"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 control-label" for="<%= cmbLocation.ClientID %>">Pickup Location</label>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="cmbLocation" runat="server" CssClass="form-control" Enabled="True" AutoPostBack="True" OnSelectedIndexChanged="cmbLocation_SelectedIndexChanged" required="true">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                            <asp:ListItem>Abu Dhabi</asp:ListItem>
                            <asp:ListItem>Dubai</asp:ListItem>
                            <asp:ListItem>SZC</asp:ListItem>
                        </asp:DropDownList>
                                </div>
                            </div>
                            <!-- / .form-group -->


                            <div class="form-group">
                                <div class="col-sm-5">&nbsp;</div>
                                <div class="col-sm-2">
                                    <asp:Button ID="cmdSave" runat="server" OnClick="cmdSave_Click" Text="Save" CssClass="btn btn-primary" />
                                    <asp:Button ID="cmdCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="cmdCancel_Click" formnovalidate="formnovalidate"/>
                                </div>
                                <div class="col-sm-5">&nbsp;</div>
                            </div>
                            <!-- / .form-group -->
                        </div>
                        <!-- / .tab-pane -->
                        

                        <div class="tab-pane fade" id="transport-requests-history">
                            <asp:GridView ID="MaterialRequestList" runat="server" AutoGenerateColumns="False" DataKeyNames="DocumentID" EnableModelValidation="True" CssClass="table table-primary table-hover table-condensed" OnPreRender="MaterialRequestList_OnPreRender">
                                <SelectedRowStyle BackColor="#2175ac" ForeColor="White" Font-Bold="true" />
                            <Columns>
                                <asp:TemplateField HeaderText="SerialNo" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText=" ">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRecCounter" runat="server" Text='<%# Eval("RecCounter").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false" HeaderStyle-HorizontalAlign="Left" HeaderText="Document ID" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentID" runat="server" Text='<%# Eval("DocumentID").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Reg. Number" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRegistrationNumber" runat="server" Text='<%# Eval("RegistrationNumber").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

    <asp:TemplateField  HeaderStyle-HorizontalAlign="Left" HeaderText="Name-Make" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNAMEMAKE" runat="server" Text='<%# Eval("NAMEMAKE").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

    <asp:TemplateField  HeaderStyle-HorizontalAlign="Left" HeaderText="Model" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                    <%--<asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Color" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle CssClass="" />
                                    <ItemStyle CssClass="" />
                                    <ControlStyle CssClass="" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblColor" runat="server" BackColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("Color").ToString()) %>'></asp:Label>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>--%>

                                <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Service Date" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLastServiceDate" runat="server" Text='<%# Eval("LastServiceDate").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Oil Change Date" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOilChangeDate" runat="server" Text='<%# Eval("OilChangeDate").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Registration Expiry Date" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRegistrationExpiryDate" runat="server" Text='<%# Eval("RegistrationExpiryDate").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:CommandField ButtonType="Button" ShowSelectButton="True" ControlStyle-CssClass="btn" />
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn" OnClick="btnCancelGrid_Click" formnovalidate="formnovalidate"  />--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        </div>
                        <!-- / .tab-pane -->
                    </div>
                    <!-- / .tab-content -->
                </div>

            </asp:Panel>
            

                   <uc4:_TransportList ID="mrList" runat="server" />

            

            
            <uc1:WorkflowDetails ID="wf" runat="server" /> 
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
