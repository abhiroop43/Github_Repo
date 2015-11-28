<%@ Control Language="C#" AutoEventWireup="false" CodeFile="_TransportList.ascx.cs" Inherits="_TransportRequestList" %>
<link href="../assets/stylesheets/bootstrap.min.css" rel="stylesheet" type="text/css" />
<style type="text/css">

        .style1
        {
            width: 600px;
        }
        .style3
        {
            font-weight: bold;
        }
        .style2
        {
            width: 158px;
        }
          .style_textbox
        {
            border: solid 1px gray;
            font: calibri;
            font-family: calibri;
            font-size: 13px;
        }
        </style>
         <%--<div style="font-family: Calibri; font-size: 14px; font-weight: normal" align="center">--%><center>
         <asp:TextBox ID="txtEmployeeID" runat="server" Enabled="False" Visible="False">000313</asp:TextBox>
        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="#CC3300" Text="Label" 
            Visible="False"></asp:Label>
        <br />

         <label class="control-label">View List</label>
        <asp:DropDownList ID="cmbRequestTypes" runat="server" AutoPostBack="True" CssClass="dropdown" OnSelectedIndexChanged="cmbRequestTypes_SelectedIndexChanged">
        </asp:DropDownList>

        
        <br />
             <div class="panel-body">
        <asp:GridView ID="TransportList" runat="server" AutoGenerateColumns ="False" EnableTheming="True" OnRowDataBound="TransportList_RowDataBound" EnableModelValidation="True" CssClass="table table-primary table-hover table-striped table-condensed" OnPreRender="TransportList_PreRender">
            <Columns>
                <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblSerialNo" runat="server" Text='<%# Eval("SerialNo").ToString() %>' ></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

          <asp:TemplateField HeaderText="Document ID">
                <ItemTemplate>
                <asp:Label ID="lblDocumentID" runat="server" Text='<%# Eval("DocumentID").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
           <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("Date").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            

                <asp:TemplateField HeaderText="Registration No.">
                <ItemTemplate>
                    <asp:Label ID="lblRegistrationNumber" runat="server" Text='<%# Eval("RegistrationNumber").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

                <asp:TemplateField HeaderText="Departure Date">
                <ItemTemplate>
                    <asp:Label ID="lblDepartureDate" runat="server" Text='<%# Eval("DepartureDate").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

                                <asp:TemplateField HeaderText="Return Date">
                <ItemTemplate>
                    <asp:Label ID="lblReturnDate" runat="server" Text='<%# Eval("ReturnDate").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("FinalStatus").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField> 

            <asp:TemplateField HeaderText="View">
                <ItemTemplate>
                    <a id="aTagURL" href='MaterialRequest.aspx?type=<%#DataBinder.Eval(Container.DataItem,"SerialNo").ToString()%>' runat="server">
                        <asp:Image ID="imgView" runat="server" ImageUrl="Images/View.jpg" Height="16" Width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>     

            <asp:TemplateField HeaderText="Approve">
                <ItemTemplate>
                    <a id="aTagURL_Approve" href='MaterialRequest.aspx?type=<%#DataBinder.Eval(Container.DataItem,"SerialNo").ToString()%>' runat="server">
                        <asp:Image ID="imgApprove" runat="server" ImageUrl="Images/Submit.jpg" Height="16" Width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>     
            <asp:TemplateField HeaderText="Reject">
                <ItemTemplate>
                    <a id="aTagURL_Reject" href='MaterialRequest.aspx?type=<%#DataBinder.Eval(Container.DataItem,"SerialNo").ToString()%>' runat="server">
                        <asp:Image ID="imgReject" runat="server" ImageUrl="Images/Delete.jpg" Height="16" Width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>     

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblApprovalPass" runat="server" Text='<%# Eval("ApprovalPass").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblRejectPass" runat="server" Text='<%# Eval("RejectPass").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        </asp:GridView>
                 </div>
<%--</div>--%></center>
<asp:HiddenField ID="hEmployeeEmail" runat="server" />
<asp:HiddenField ID="hLineManagerEMail" runat="server" />
<asp:HiddenField ID="hManagerName" runat="server" />
<asp:HiddenField ID="hGCAA_EmployeeId" runat="server" />
<asp:HiddenField ID="hShowApprovalList" runat="server" />
<asp:HiddenField ID="hcmbRequestTypes" runat="server" />
<asp:HiddenField ID="hCurrentUserId" runat="server" />

