<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Master.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="WebContentRepo.Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav id="nav">
        <ul>
            <li><a href="../Search.aspx" class="active">Search</a></li>
            <li><a href="../KeywordMaintenance.aspx">Keyword Maintenance</a></li>
            <li><a href="../RepoMaintenance.aspx">Repository Maintenance</a></li>
        </ul>
    </nav>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cpBody" runat="server">
    <input id="txtSearch" runat="server" placeholder="Enter Keyword" required="required" type="text" style="width: 60%" title="Keyword" />
    <br />
    <input id="txtNoOfLinks" runat="server" placeholder="Select no. of links" required="required" type="text" style="width: 12%" pattern="^\d+$" title="No. of links" />
    <br />
    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

</asp:Content>
