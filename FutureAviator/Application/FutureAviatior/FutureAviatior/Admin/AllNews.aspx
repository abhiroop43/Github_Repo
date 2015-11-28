<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllNews.aspx.cs" Inherits="FutureAviator.Admin.AllNews" %>

<%@ Register Src="~/UserControls/Admin_AllNews.ascx" TagPrefix="uc1" TagName="Admin_AllNews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AllNews runat="server" id="Admin_AllNews" />
</asp:Content>
