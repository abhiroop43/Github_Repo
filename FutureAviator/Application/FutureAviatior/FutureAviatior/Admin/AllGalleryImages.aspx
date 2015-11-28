<%@ Page Title="Admin : Gallery Images" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllGalleryImages.aspx.cs" Inherits="FutureAviator.Admin.AllGalleryImages" %>

<%@ Register Src="~/UserControls/Admin_AllGalleryImages.ascx" TagPrefix="uc1" TagName="Admin_AllGalleryImages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AllGalleryImages runat="server" id="Admin_AllGalleryImages" />
</asp:Content>
