<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpages/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DDSInvertedIndex.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <nav id="nav">
        <ul>
            <li><a href="../Home.aspx" class="active">Home</a></li>
            <li><a href="../UploadDocs.aspx">Upload Documents</a></li>
        </ul>
    </nav>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpBody" runat="server">
    <h3>
        Write a program to perform the following actions:
    </h3>
    <ul>
        <li>
            Create an inverted index for a given document collection: (assume that stemming/normalzation/stop word removal are not necessary)
        </li>
        <li>
            Lookup and display the contents of the complete inverted index, in the specified format 
        </li>
    </ul>
</asp:Content>
