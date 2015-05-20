<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpages/Site.Master" AutoEventWireup="true" CodeBehind="Decryption.aspx.cs" Inherits="Steganography.Decryption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav id="nav">
        <ul>
            <li><a href="../Encryption.aspx">Encrypt Text</a></li>
            <li><a href="../Decryption.aspx"  class="active">Decrypt Image</a></li>
        </ul>
    </nav>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpBody" runat="server">
    Please select the image to be decrypted: <asp:FileUpload ID="fpInputImage" runat="server" />
    <br /><br />
    <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
    <br />
    <asp:Label ID="lblError" runat="server" style="color:red;"></asp:Label>
</asp:Content>
