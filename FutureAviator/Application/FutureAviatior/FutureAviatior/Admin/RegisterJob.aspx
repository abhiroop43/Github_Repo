<%@ Page Title="Admin : Register job" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="RegisterJob.aspx.cs" Inherits="FutureAviator.Admin.RegisterJob" %>

<%@ Register Src="~/UserControls/Admin_RegisterJob.ascx" TagPrefix="uc1" TagName="Admin_RegisterJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_RegisterJob runat="server" ID="Admin_RegisterJob" />
</asp:Content>
