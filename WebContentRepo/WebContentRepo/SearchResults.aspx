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
    <asp:Repeater ID="rptFiles" runat="server">
        <HeaderTemplate>
            <table style="width:74%">
                <tr>
                    <th>Keyword</th>
                    <th>File name</th>
                    <th>File type</th>
                    <th>Added on</th>
                </tr>
        </HeaderTemplate>

        <ItemTemplate>
            <tr>
                <td style="background: #CCFFCC">
                    <asp:Label runat="server" ID="Label1"
                        Text='<%# Eval("KeywordDesc") %>' />
                </td>
                <td style="background: #CCFFCC">
                    <asp:Label runat="server" ID="Label2"
                        Text='<%# Eval("Filename") %>' />
                </td>
                                <td style="background: #CCFFCC">
                    <asp:Label runat="server" ID="Label3"
                        Text='<%# Eval("FileType") %>' />
                </td>
                <td style="background: #CCFFCC">
                    <asp:Label runat="server" ID="Label4"
                        Text='<%# Eval("AddedOn") %>' />
                </td>
            </tr>
        </ItemTemplate>

        <AlternatingItemTemplate>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblKwd"
                        Text='<%# Eval("KeywordDesc") %>' />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblFilename"
                        Text='<%# Eval("Filename") %>' />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblFiletype"
                        Text='<%# Eval("FileType") %>' />
                </td>
                <td>
                    <asp:Label runat="server" ID="lblAddedOn"
                        Text='<%# Eval("AddedOn") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>

        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Button ID="btnDownload" runat="server" Text="Download All Files" OnClick="btnDownload_Click" />
</asp:Content>
