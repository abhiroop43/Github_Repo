<%@ Page Title="Admin : Add Gallery Image" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddGalleryImage.aspx.cs" Inherits="FutureAviator.Admin.AddGalleryImage" %>

<%@ Register Src="~/UserControls/Admin_AddGalleryImage.ascx" TagPrefix="uc1" TagName="Admin_AddGalleryImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AddGalleryImage runat="server" ID="Admin_AddGalleryImage" />
</asp:Content>
