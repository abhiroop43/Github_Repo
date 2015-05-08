<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpages/Site.Master" AutoEventWireup="true" CodeBehind="UploadDocs.aspx.cs" Inherits="DDSInvertedIndex.UploadDocs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <nav id="nav">
        <ul>
            <li><a href="../Home.aspx">Home</a></li>
            <li><a href="../UploadDocs.aspx"  class="active">Upload Documents</a></li>
        </ul>
    </nav>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpBody" runat="server">
    <asp:FileUpload ID="fuUploadDocs" runat="server" AllowMultiple="True" /><asp:Button ID="btnSubmit" runat="server" Text="Upload" OnClick="btnSubmit_Click" />
    <br />
    <asp:Label ID="lblError" runat="server" style="color:red;"></asp:Label>
</asp:Content>
