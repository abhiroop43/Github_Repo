<%@ Page Title="" Language="C#" MasterPageFile="~/Masterpages/Site.Master" AutoEventWireup="true" CodeBehind="DisplayIndex.aspx.cs" Inherits="DDSInvertedIndex.DisplayIndex" %>
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
    <asp:GridView ID="gvInvertedIndex" runat="server" AutoGenerateColumns="False" AllowPaging="false" EmptyDataText="No Records Found" OnPageIndexChanging="gvInvertedIndex_PageIndexChanging" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Word" HeaderText="Word" />
            <asp:BoundField DataField="DocFreq" HeaderText="Document Frequency" />
            <asp:BoundField DataField="Postings" HeaderText="Postings List" />
        </Columns>
        <EditRowStyle BackColor="#7C6F57" />
        <EmptyDataTemplate>
            No records found.
        </EmptyDataTemplate>
        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#4acaa8" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="#333333"/>
        <RowStyle BackColor="#E3EAEB" />
        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F8FAFA" />
        <SortedAscendingHeaderStyle BackColor="#246B61" />
        <SortedDescendingCellStyle BackColor="#D4DFE1" />
        <SortedDescendingHeaderStyle BackColor="#15524A" />
</asp:GridView>
        <br />
    <asp:Label ID="lblError" runat="server" style="color:red;"></asp:Label>
</asp:Content>
