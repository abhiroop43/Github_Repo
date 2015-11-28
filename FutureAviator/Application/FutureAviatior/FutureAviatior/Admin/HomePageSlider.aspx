<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="HomePageSlider.aspx.cs" Inherits="FutureAviator.Admin.HomePageSlider" %>

<%@ Register Src="~/UserControls/Admin_HomeSlider.ascx" TagPrefix="uc1" TagName="Admin_HomeSlider" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_HomeSlider runat="server" ID="Admin_HomeSlider" />
</asp:Content>
