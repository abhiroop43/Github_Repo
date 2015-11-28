<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddInternationalStudy.aspx.cs" Inherits="FutureAviator.Admin.AddInternationalStudy" %>
 <%@ Register Src="~/UserControls/Admin_AddImageContentBox.ascx" TagPrefix="uc1" TagName="Admin_AddImageContentBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AddImageContentBox runat="server" id="ctrlInternationalStudy" />
</asp:Content>
