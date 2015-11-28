<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchJob.aspx.cs" Inherits="FutureAviator.SearchJob" %>

<%@ Register Src="~/UserControls/User_SerachJob.ascx" TagPrefix="uc1" TagName="User_SerachJob" %>
<%@ Register Src="~/UserControls/LanguageSwitch.ascx" TagPrefix="uc1" TagName="LanguageSwitch" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc1:LanguageSwitch runat="server" id="LanguageSwitch" />
        <uc1:User_SerachJob runat="server" ID="User_SerachJob" />
    </div>
    </form>
</body>
</html>
