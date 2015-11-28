<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllUAEStudies.aspx.cs" Inherits="FutureAviator.Admin.AllUAEStudies" %>
<%@ Register Src="~/UserControls/Admin_AllImageContentBoxes.ascx" TagPrefix="uc1" TagName="Admin_AllImageContentBoxes" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <uc1:Admin_AllImageContentBoxes runat="server" id="ctrlAllUAEStudies" />
</asp:Content>
