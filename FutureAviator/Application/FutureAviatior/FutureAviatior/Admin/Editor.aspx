<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Editor.aspx.cs" Inherits="FutureAviator.Admin.Editor" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <CKEditor:CKEditorControl ID="txtNewsDetailsEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
	</CKEditor:CKEditorControl>
</asp:Content>
