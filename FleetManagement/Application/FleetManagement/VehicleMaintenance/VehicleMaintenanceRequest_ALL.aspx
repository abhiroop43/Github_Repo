<%@ Page Language="C#" AutoEventWireup="false" CodeFile="VehicleMaintenanceRequest_ALL.aspx.cs" Inherits="VehicleMaintenance_VehicleMaintenanceRequest_ALL" MasterPageFile="~/MasterPages/Site.master" %>
<%@ Register src="../Workflow/WorkflowDetails.ascx" tagname="WorkflowDetails" tagprefix="uc1" %>
<%@ Register src="_VehicleMaintenanceList.ascx" tagname="_VehicleMaintenanceList" tagprefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <title>Vehicle Maintenance</title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .EmployeeInfo
        {
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
            }
         .EmployeeInfoBold
        {
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
            font-weight:bold;
            }
         .EmployeeInfoHead
        {
            background-image:url('images/searchbg.jpg');
            /*font: calibri;*/
            font-family: calibri;
            font-size: 18px;
            font-weight: bold;            
            color: #808080;
            }

        .style2
        {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            }
         .style_textbox
        {
            border: solid 1px gray;
            font-family: calibri;
            font-size: 13px;
            margin-left: 0;
        }
        .auto-style1 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            width: 182px;
            height: 23px;
        }
        .auto-style2 {
            font-family: calibri;
            font-size: 13px;
            height: 23px;
        }
        .auto-style3 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            height: 19px;
        }
        .auto-style4 {
            font-family: calibri;
            font-size: 13px;
            height: 19px;
        }
        .auto-style7 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            width: 110px;
        }
        .auto-style15 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            width: 182px;
        }
        .auto-style22 {
            font-family: calibri;
            font-size: 13px;
            width: 156px;
        }
        .auto-style24 {
            font-family: calibri;
            font-size: 13px;
            width: 267px;
        }
        .auto-style25 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            width: 74px;
        }
        .auto-style26 {
            font-family: calibri;
            font-size: 13px;
            font-weight: bold;
            width: 108px;
        }
        </style>

    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <script>
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
    <ContentTemplate >
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
                            <a href="#transport-requests-history" data-toggle="tab">Upload Attachment <%--<span class="badge badge-primary"><%= MaterialRequestList.Rows.Count.ToString() == "0" ? "" : MaterialRequestList.Rows.Count.ToString() %></span>--%></a>
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
                                <label class="col-sm-2 control-label">Service Date</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtServiceDate" runat="server" TextMode="Date" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 control-label">Location</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtLocation" runat="server" MaxLength="48" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Remarks</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtRemarks" runat="server" MaxLength="100" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 control-label">Vehicle</label>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="cmbVehicle" runat="server" AutoPostBack="True" OnSelectedIndexChanged="cmbVehicle_SelectedIndexChanged" CssClass="form-control" required="true">
                        </asp:DropDownList>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Vehicle Model</label>
                                <div class="col-sm-3">
                                    <label class="control-label"><asp:Label ID="lblModel" runat="server"></asp:Label></label>
                                </div>
                                <label class="col-sm-2 control-label">KM</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtKM" runat="server" MaxLength="10" TextMode="Number" step="any" CssClass="form-control" required="true"></asp:TextBox>
                                </div>
                            </div>
                            <!-- / .form-group -->
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Service</label>
                                <div class="col-sm-3">
                                    <asp:DropDownList ID="cmbService" runat="server" CssClass="form-control" required="true">
                        </asp:DropDownList>
                                </div>
                                <label class="col-sm-2 control-label">Amount</label>
                                <div class="col-sm-3">
                                    <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" TextMode="Number" step="any" CssClass="form-control" required="true"></asp:TextBox>
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
                        <asp:GridView ID="MaterialRequestList" runat="server" AutoGenerateColumns="False" EnableModelValidation="True" EnableTheming="True" OnRowDataBound="MaterialRequestList_RowDataBound" OnSelectedIndexChanged="MaterialRequestList_SelectedIndexChanged" CssClass="table table-primary table-hover table-condensed" OnPreRender="MaterialRequestList_OnPreRender">
                            <SelectedRowStyle BackColor="#2175ac" ForeColor="White" Font-Bold="true" />                         
                        <Columns>
                            <asp:TemplateField HeaderText="SerialNo" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Attachments" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblAttachments" runat="server" Text='<%# Eval("Attachments").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <asp:Label ID="lblRecCounter" runat="server" Text='<%# Eval("RecCounter").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Service Type" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblServiceType" runat="server" Text='<%# Eval("ServiceType").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Registration Number" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationNumber" runat="server" Text='<%# Eval("RegistrationNumber").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Left" HeaderText="Model" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="KM" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblKM" runat="server" Text='<%# Eval("KM").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                        
                            
                            <%--<asp:TemplateField HeaderText="Delete">
                                <HeaderStyle CssClass="" />
                                <ItemStyle CssClass="" HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ControlStyle CssClass="" />
                                <ItemTemplate>
                                    <a id="aTagURL_Delete" runat="server" href='LeaveRequestView.aspx?type=<%#DataBinder.Eval(Container.DataItem,"SerialNo").ToString()%>' onclick="if (! confirm('Are you sure to delete the current line item ?')) return false;">
                                    <asp:Image ID="imgDelete" runat="server" Height="16" ImageUrl="Images/Delete.jpg" Width="16" />
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Attachment">
                                <ItemTemplate>
                                    <a id="aTagURL_Att" runat="server" href="#">
                                    <asp:Image ID="imgAttach" runat="server" Height="16" ImageUrl="Images/Attachments.png" Width="16" />
                                    <asp:Image ID="imgAttachp" runat="server" Height="16" ImageUrl="Images/Attachmentp.png" Width="16" />
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                        </div>
                    <!-- / .tab-pane -->
                    </div>
                </div>
            </asp:Panel>
        

                   <uc4:_VehicleMaintenanceList ID="mrList" runat="server" />

        
        <uc1:WorkflowDetails ID="wf" runat="server" />
        </ContentTemplate>
            </asp:UpdatePanel>
    </asp:Content>

