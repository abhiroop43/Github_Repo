<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Master.Master" AutoEventWireup="true" CodeBehind="SearchResults.aspx.cs" Inherits="WebContentRepo.UI.SearchResults" %>
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
</asp:Content>
