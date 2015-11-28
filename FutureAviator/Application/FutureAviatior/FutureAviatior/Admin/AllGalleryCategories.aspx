<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllGalleryCategories.aspx.cs" Inherits="FutureAviator.Admin.AllGalleryCategories" %>

<%@ Register Src="~/UserControls/Admin_AllGalleryCategories.ascx" TagPrefix="uc1" TagName="Admin_AllGalleryCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AllGalleryCategories runat="server" id="Admin_AllGalleryCategories" />
</asp:Content>
