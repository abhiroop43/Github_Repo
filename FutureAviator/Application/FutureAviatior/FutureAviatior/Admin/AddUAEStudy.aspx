﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AddUAEStudy.aspx.cs" Inherits="FutureAviator.Admin.AddUAEStudy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Src="~/UserControls/Admin_AddImageContentBox.ascx" TagPrefix="uc1" TagName="Admin_AddImageContentBox" %>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
     <uc1:Admin_AddImageContentBox runat="server" id="ctrlUAEStudy" />
</asp:Content>
