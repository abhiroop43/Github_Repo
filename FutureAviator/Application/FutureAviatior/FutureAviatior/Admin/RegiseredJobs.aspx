<%@ Page Title="Admin : Regisered Jobs" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="RegiseredJobs.aspx.cs" Inherits="FutureAviator.Admin.RegiseredJobs" %>

<%@ Register Src="~/UserControls/Admin_RegiseredJobs.ascx" TagPrefix="uc1" TagName="Admin_RegiseredJobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_RegiseredJobs runat="server" id="Admin_RegiseredJobs" />
</asp:Content>
