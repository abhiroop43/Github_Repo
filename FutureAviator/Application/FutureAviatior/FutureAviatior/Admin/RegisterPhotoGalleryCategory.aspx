<%@ Page Title="Admin : Add Photo Gallery Category" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="RegisterPhotoGalleryCategory.aspx.cs" Inherits="FutureAviator.Admin.RegisterPhotoGalleryCategory" %>

<%@ Register Src="~/UserControls/Admin_RegisterPhotoGalleryCategory.ascx" TagPrefix="uc1" TagName="Admin_RegisterPhotoGalleryCategory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_RegisterPhotoGalleryCategory runat="server" ID="ctrl_Admin_RegisterPhotoGalleryCategory" />
</asp:Content>
