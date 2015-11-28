<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterEvent.aspx.cs" Inherits="FutureAviator.RegisterEvent" %>
<%@ Register TagPrefix="FTB" Assembly="FreeTextBox" Namespace="FreeTextBoxControls" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="assets/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../assets/js/nicEdit.js"></script> 
    <script type="text/javascript" src="assets/js/scripts.js"></script>
<%--    <script type="text/javascript">
        //<![CDATA[
        bkLib.onDomLoaded(function () {
            //nicEditors.allTextAreas();
            new nicEditor({ maxHeight: 100 }).panelInstance('txtDesc');            
        });
        //]]>
  </script>--%>
</head>
<body>
    <form id="form1" runat="server">

    <asp:Label ID="lblHeaderDate" runat="server" Text="Events on "></asp:Label><br /><br />
        <asp:Repeater ID="rptEventDetails" runat="server" OnItemCommand="rptEventDetails_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:HiddenField ID="hfeventID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID") %>' /><br />
                <asp:Label ID="lblNameHeader" runat="server" Text="Event Name: "></asp:Label><asp:Label ID="lblEventName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EventName") %>'></asp:Label>
                <br />
                <asp:Label ID="lblDescHeader" runat="server" Text="Event Description: "></asp:Label><asp:Label ID="lblEventDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EventDesc") %>'></asp:Label>
                        <br />
                        <asp:HiddenField ID="hfEventIsPublic" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Public") %>' /><br />
                        <asp:HiddenField ID="hfEventUser" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "EventUser") %>' />
                        </td>
                    <td rowspan="5">
                        <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="Select" />
                    </td>
                    </tr>
            </ItemTemplate>
            <SeparatorTemplate>
                <hr />
            </SeparatorTemplate>
        </asp:Repeater>
        <br /><br />
        <asp:Panel ID="pnlAddEvent" runat="server" Visible="false">
            <asp:HiddenField ID="hfSelectedEventID" runat="server" />
            <asp:Label ID="lblEventDate" runat="server" Text="Event Date: "></asp:Label><asp:TextBox ID="txtDate" runat="server" type="date"></asp:TextBox><br />
            <asp:Label ID="lblEventName" runat="server" Text="Event Name: "></asp:Label><asp:TextBox ID="txtName" runat="server"></asp:TextBox><br />
            <asp:Label ID="lblEventDesc" runat="server" Text="Event Description: "></asp:Label>
            <%--<FTB:FreeTextBox id="txtDesc" runat="server" />--%>
            <textarea id="txtDesc" style="width:100%; height:100px" runat="server" class="nicinstance"></textarea>
            <br />
            <asp:Label ID="lblPublic" runat="server" Text="Public Event: "></asp:Label><asp:CheckBox ID="chkPublic" runat="server" /><br /><br />
            <asp:Button ID="btnAdd" runat="server" Text="Add New Event" OnClick="btnAdd_Click" /><asp:Button ID="btnEdit" runat="server" Text="Edit" Visible="false" OnClick="btnEdit_Click" /><asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="false" OnClick="btnDelete_Click" /><br /><br />
            <asp:Label ID="lblErrDesc" runat="server"/>

        </asp:Panel>
    </form>
</body>
</html>
