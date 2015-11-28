<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsDetails.aspx.cs" Inherits="FutureAviator.NewsDetails" %>

<%@ Register Src="~/UserControls/DisplayNewsDetails.ascx" TagPrefix="uc1" TagName="DisplayNewsDetails" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="../userassets/css/bootstrap.min.css" />
    <link href="assets/css/loader.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../userassets/css/bootstrap-flipped.css" />--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            setTimeout(function () {
                $("#loader-wrapper").fadeOut();
            }, 1000);

        });
    </script>
    <script src="../userassets/js/bootstrap.min.js"></script>

</head>
<body id="body" runat="server">
    <form id="form1" runat="server">
        <div id="loader-wrapper" style="display: block;">
            <div class="loader-text">
                <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "PleaseWait") :  GetGlobalResourceObject("Arabic", "PleaseWait") %>
            </div>
            <div id='<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? "loader" : "loaderAr" %>'></div>
        </div>
        <div>
            <uc1:DisplayNewsDetails runat="server" ID="DisplayNewsDetails" />
        </div>
    </form>
</body>
</html>
