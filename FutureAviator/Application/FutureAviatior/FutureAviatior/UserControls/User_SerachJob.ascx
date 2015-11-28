<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="User_SerachJob.ascx.cs" Inherits="FutureAviator.UserControls.User_SerachJob" %>
Select Industry<br />
<asp:DropDownList ID="ddlIndustry" runat="server"></asp:DropDownList><br />
<br />
Select Location<br />
<asp:DropDownList ID="ddlLocation" runat="server"></asp:DropDownList><br />
<br />
Keywords (comma separated)<br />
<asp:TextBox ID="txtKeywords" runat="server"></asp:TextBox><br />
<br />
<asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search Job" />

<br />
<br />
<br />
<asp:DataList ID="dlJobSearch" OnItemCommand="dlJobSearch_ItemCommand" runat="server">
    <ItemTemplate>
        <div style="font-size: 16px; float: left;"><%# Eval("JobTitle") %></div>
        <div style="float: right;">Posted Date : <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %><br /> 
            Expiry Date : <%# Convert.ToDateTime(Eval("ExpiryDate")).ToShortDateString() %><br />
        </div>
        <br />
        <br />
        <%# Eval("JobDescription").ToString() %><br />
        <br />
        <br />
        <asp:Button ID="btnApply" Enabled='<%# Convert.ToBoolean(Eval("IsAlreadyApplied")) == true ? false : true %>' CommandName="apply" CommandArgument='<%# Eval("JobID") + "~" + Eval("JobTitle") %>' Text="Apply" runat="server" />
        <br />
        <asp:Label ID="lblMessage" Text='<%# Convert.ToBoolean(Eval("IsAlreadyApplied")) == true ? "Already Applied" : "" %>' runat="server"></asp:Label>
        <hr />
    </ItemTemplate>
</asp:DataList>
<asp:Label ID="lblEmptySearch" runat="server"></asp:Label>
