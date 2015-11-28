<%@ Page Title="Admin : Add News" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddNews.aspx.cs" Inherits="FutureAviator.Admin.AddNews" %>

<%@ Register Src="~/UserControls/Admin_AddNews.ascx" TagPrefix="uc1" TagName="Admin_AddNews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AddNews runat="server" ID="Admin_AddNews" />
</asp:Content>
