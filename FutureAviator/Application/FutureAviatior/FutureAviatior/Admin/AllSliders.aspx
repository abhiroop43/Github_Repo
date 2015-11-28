<%@ Page Title="Admin : All Slides" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllSliders.aspx.cs" Inherits="FutureAviator.Admin.AllSliders" %>

<%@ Register Src="~/UserControls/Admin_AllSlides.ascx" TagPrefix="uc1" TagName="Admin_AllSlides" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AllSlides runat="server" id="Admin_AllSlides" />
</asp:Content>
