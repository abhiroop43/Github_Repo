<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PressReleaseDetails.aspx.cs" Inherits="FutureAviator.PressReleaseDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Press Release Details</title>
        <link rel="stylesheet" href="userassets/css/bootstrap.min.css" />
    <%--<link rel="stylesheet" href="//cdn.rawgit.com/morteza/bootstrap-rtl/master/dist/css/bootstrap-rtl.min.css" />--%>
</head>
<body id="body" runat="server">
    <form id="form1" runat="server">
    <div>
        <asp:HiddenField ID="hfPressRlsID" runat="server" />
        <asp:Label ID="lblRlsHeader" runat="server"></asp:Label><br />
        <asp:Label ID="lblRlsDate" runat="server"></asp:Label><br />
        <asp:Image ID="imgPress" Style="padding-bottom: 10px; padding-right: 10px; float: left;" runat="server" />
        <asp:Label ID="lblRlsContent" runat="server"></asp:Label>
    </div>
    </form>
</body>
</html>
