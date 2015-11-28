<%@ Page Title="Add Career Box" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddCareerBox.aspx.cs" Inherits="FutureAviator.Admin.AddCareerBox" %>

<%@ Register Src="~/UserControls/Admin_AddImageContentBox.ascx" TagPrefix="uc1" TagName="Admin_AddImageContentBox" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AddImageContentBox runat="server" id="ctrlCareerBox" />
</asp:Content>
