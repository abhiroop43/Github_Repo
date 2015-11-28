<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterNews.aspx.cs" Inherits="FutureAviator.RegisterNews" %>

<%@ Register Src="~/UserControls/Admin_AddNews.ascx" TagPrefix="uc1" TagName="Admin_AddNews" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc1:Admin_AddNews runat="server" ID="Admin_AddNews" />
    </div>
    </form>
</body>
</html>
