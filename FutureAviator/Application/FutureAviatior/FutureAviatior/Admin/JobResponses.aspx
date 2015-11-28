<%@ Page Title="Admin : Job Responses" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="JobResponses.aspx.cs" Inherits="FutureAviator.Admin.JobResponses" %>

<%@ Register Src="~/UserControls/Admin_JobResponses.ascx" TagPrefix="uc1" TagName="Admin_JobResponses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_JobResponses runat="server" id="Admin_JobResponses" />
</asp:Content>
