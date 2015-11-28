<%@ Page Language="C#" AutoEventWireup="false" CodeFile="VehicleMaster.aspx.cs" Inherits="TransportRequest_VehicleMaster" MasterPageFile="~/MasterPages/Site.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
    <title>Vehicle Master</title>
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .EmployeeInfo {
            font-family: calibri;
            font-size: 13px;
            margin-left: 120px;
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
            width: 150px;
        }

        .style_textbox {
            border: solid 1px gray;
            /*font: calibri;*/
            font-family: calibri;
            font-size: 13px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
<%-- ReSharper disable once AssignedValueIsNeverUsed --%>
    <script type="text/javascript">
        function HandleAttachments(inpProcessId, otherKey) {
            //alert("test");
            var attachmentUrl = '';
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
                    <span class="panel-title">Register Vehicle Master</span>
                </div>
                <div class="panel-body">
                    <asp:Label ID="lblErrorMessage" CssClass="style2" runat="server" Text="" ForeColor="Red" Font-Size="12px"></asp:Label>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Reference Number</label>
                        <div class="col-sm-3">
                            <label class="control-label"><asp:Label ID="lblDocumentID" runat="server" Text="**New Request"
                                Font-Bold="True"></asp:Label></label>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Make</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtMake" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Model</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtModel" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Registration Number</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtRegistrationNumber" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Engine Number</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtEngineNumber" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Chassis Number</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtChasisNumber" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">ODO Meter</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtODOMeter" runat="server" CssClass="form-control" MaxLength="20" TextMode="Number" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Color</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" MaxLength="50" TextMode="Color" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->


                    <div class="form-group">
                        <label class="col-sm-2 control-label">Last Service Date</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtLastServiceDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Availability</label>
                        <div class="col-sm-3">
                            <asp:DropDownList ID="cmbAvailability" runat="server" CssClass="form-control" Enabled="False">
                                <asp:ListItem>Yes</asp:ListItem>
                                <asp:ListItem>No</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Last Oil Change Date</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtOilChangeDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Tyres Change Date</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtTyreChangeDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Insurance Policy Number</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtInsurancePolicyNumber" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Insurance Company</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtInsuranceCompany" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Registration Expiry Date</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtRegistrationExpiryDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Salik Account Number</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtSalikAccountNumber" runat="server" CssClass="form-control" MaxLength="50" required="true"></asp:TextBox>
                        </div>
                    </div>
                    <!-- / .form-group -->

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Insurance Expiry Date</label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtInsuranceExpiryDate" runat="server" CssClass="form-control" TextMode="Date" required="true"></asp:TextBox>
                        </div>
                        <label class="col-sm-2 control-label">Location ID</label>
                        <div class="col-sm-3">
                            <asp:DropDownList ID="cmbLocation" runat="server" CssClass="form-control" Enabled="True" required="true">
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
                            <asp:Button ID="cmdCancel" runat="server" Text="Cancel" OnClick="cmdCancel_Click" CssClass="btn btn-primary" formnovalidate="formnovalidate" />
                        </div>
                        <div class="col-sm-5">&nbsp;</div>
                    </div>
                    <!-- / .form-group -->


                    <asp:GridView ID="MaterialRequestList" runat="server" AutoGenerateColumns="False" EnableTheming="True" EnableModelValidation="True" DataKeyNames="DocumentID" OnSelectedIndexChanging="MaterialRequestList_SelectedIndexChanging" CssClass="table table-primary table-hover table-condensed" OnPreRender="MaterialRequestList_OnPreRender">
                        <SelectedRowStyle BackColor="#2175ac" ForeColor="White" Font-Bold="true" />
                        <Columns>

                            <asp:TemplateField Visible="false" HeaderText="SerialNo">
                                <ItemTemplate>
                                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <asp:Label ID="lblRecCounter" runat="server" Text='<%# Eval("RecCounter").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField Visible="True" HeaderText="Location" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblDocumentID" runat="server" Text='<%# Eval("Location").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Registration Number" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationNumber" runat="server" Text='<%# Eval("RegistrationNumber").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Meter" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblODOMeter" runat="server" Text='<%# Eval("ODOMeter").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Model" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblModel" runat="server" Text='<%# Eval("Model").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Oil Change Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblOilChangeDate" runat="server" Text='<%# Eval("OilChangeDate").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Last Service Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblLastServiceDate" runat="server" Text='<%# Eval("LastServiceDate").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Registration Expiry Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="lblRegistrationExpiryDate" runat="server" Text='<%# Eval("RegistrationExpiryDate").ToString() %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>



                            <%--                <asp:TemplateField HeaderText="Available" ControlStyle-Width="50px" ItemStyle-HorizontalAlign="Left" >
                <HeaderStyle CssClass=""/>
                <ItemStyle CssClass="" VerticalAlign="Middle" HorizontalAlign="Left" />
                <ControlStyle CssClass="" />
                <ItemTemplate>
                    <asp:Label ID="lblRegistrationNumber" runat="server" Text='<%# Eval("Availability").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Select" Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
