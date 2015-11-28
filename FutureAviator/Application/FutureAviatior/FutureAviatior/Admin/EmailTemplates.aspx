<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="EmailTemplates.aspx.cs" Inherits="FutureAviator.Admin.EmailTemplates" %>

<%@ Register Src="~/UserControls/Admin_EmailTemplates.ascx" TagPrefix="uc1" TagName="Admin_EmailTemplates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_EmailTemplates runat="server" id="Admin_EmailTemplates" />
</asp:Content>
