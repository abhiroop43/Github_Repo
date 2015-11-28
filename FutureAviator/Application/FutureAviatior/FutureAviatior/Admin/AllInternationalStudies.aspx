<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllInternationalStudies.aspx.cs" Inherits="FutureAviator.Admin.AllInternationalStudies" %>
<%@ Register Src="~/UserControls/Admin_AllImageContentBoxes.ascx" TagPrefix="uc1" TagName="Admin_AllImageContentBoxes" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
     <uc1:Admin_AllImageContentBoxes runat="server" id="ctrlAllInternationalStudies" />
</asp:Content>
