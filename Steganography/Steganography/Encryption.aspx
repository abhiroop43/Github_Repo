<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpages/Site.Master" AutoEventWireup="true" CodeBehind="Encryption.aspx.cs" Inherits="Steganography.Encryption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav id="nav">
        <ul>
            <li><a href="../Encryption.aspx" class="active">Encrypt Text</a></li>
            <li><a href="../Decryption.aspx">Decrypt Image</a></li>
        </ul>
    </nav>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpBody" runat="server">
    Please select the text file (.txt) to be encrypted: <asp:FileUpload ID="fpInputText" runat="server" />
    <br />
    Please select the image (.jpg) to be used for encryption: <asp:FileUpload ID="fpInputImage" runat="server" />
    <br /><br />
    <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
    <br />
    <asp:Image ID="imgSteganoImage" runat="server" Visible="false"/><br />
    <asp:Label ID="lblSuccessMessage" runat="server" Text="Please save the image (Right-Click -> Save as......)" Visible="false"></asp:Label>
    <br />
    <asp:Label ID="lblError" runat="server" style="color:red;"></asp:Label>
</asp:Content>
