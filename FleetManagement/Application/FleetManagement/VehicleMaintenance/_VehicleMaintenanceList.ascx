<%@ Control Language="C#" AutoEventWireup="false" CodeFile="_VehicleMaintenanceList.ascx.cs" Inherits="_VehicleMaintenanceList" %>
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
         <%--<div style="font-family: Calibri; font-size: 14px; font-weight: normal">--%><center>
         <asp:TextBox ID="txtEmployeeID" runat="server" Enabled="False" Visible="False">000313</asp:TextBox>
        <asp:Label ID="lblErrorMessage" runat="server" ForeColor="#CC3300" Text="Label" 
            Visible="False"></asp:Label>
        <br />
             <label class="control-label">View List</label>
<asp:DropDownList ID="cmbRequestTypes" runat="server" AutoPostBack="True" 
            OnSelectedIndexChanged="cmbRequestTypes_SelectedIndexChanged" CssClass="dropdown"></asp:DropDownList>
  


        
        <br />
             <div class="panel-body">
        <asp:GridView ID="PettyCashList" runat="server" AutoGenerateColumns ="False" EnableTheming="True" 
            OnRowDataBound="PettyCashList_RowDataBound" EnableModelValidation="True" CssClass="table table-primary table-hover table-striped table-condensed" OnPreRender="PettyCashList_PreRender">
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
            
            <asp:TemplateField HeaderText="Service Date">
                <ItemTemplate>
                    <asp:Label ID="lblServiceDate" runat="server" Text='<%# Eval("ServiceDate").ToString() %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

    

                <asp:TemplateField HeaderText="Location">
                <ItemTemplate>
                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location").ToString() %>'></asp:Label>
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

