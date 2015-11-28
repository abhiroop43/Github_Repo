<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FutureAviator.Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta charset="utf-8" />
    <title><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "LoginPageTitle") :  GetGlobalResourceObject("Arabic", "LoginPageTitle") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta content="" name="description" />
    <meta content="" name="author" />

    <link rel="icon" href="userassets/img/favicon.ico" />
    <!-- Favicon -->



    <!-- CORE CSS FRAMEWORK - START -->
    <link href="assets/plugins/pace/pace-theme-flash.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/fonts/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/animate.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/perfect-scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css" />
    <!-- CORE CSS FRAMEWORK - END -->

    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - START -->
    <link href="assets/plugins/icheck/skins/square/orange.css" rel="stylesheet" type="text/css" media="screen" />
    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - END -->


    <!-- CORE CSS TEMPLATE - START -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/responsive.css" rel="stylesheet" type="text/css" />
    <!-- CORE CSS TEMPLATE - END -->
    <style>
        .loginpage input[type=password] {
            font-size: 19px;
            width: 100%;
            padding: 9px;
            line-height: 25px;
            margin: 5px 0 15px 0;
            border: 1px solid transparent !important;
            background-color: rgba(255, 255, 255, 0.6);
            color: rgba(250, 133, 100, 1);
        }
    </style>

</head>
<body runat="server" id="pageBody" class=" login_page">


    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="pnlUpdate" runat="server">
            <ContentTemplate>

                <div class="login-wrapper">
                    <div id="login" class="login loginpage col-lg-offset-4 col-lg-4 col-md-offset-3 col-md-6 col-sm-offset-3 col-sm-6 col-xs-offset-2 col-xs-8">
                        <h1><a href="Login.aspx" title="Login Page" tabindex="-1">
                            <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ProjectName") :  GetGlobalResourceObject("Arabic", "ProjectName") %>
                        </a></h1>
                        <p>
                            <asp:Label ID="lblEmailID" CssClass="pull-left" runat="server" meta:resourcekey="lblEmailID"></asp:Label><br />
                            <asp:TextBox ID="txtEmailID" runat="server" CssClass="input" MaxLength="50" required="true"></asp:TextBox>
                        </p>
                        <p>
                            <asp:Label ID="lblPassword" CssClass="pull-left" runat="server" meta:resourcekey="lblPassword"></asp:Label><br />
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="input" MaxLength="20" required="true" TextMode="Password"></asp:TextBox>
                        </p>


                        <%--<asp:Label ID="lblLanuguage" runat="server" Text="Select Language"></asp:Label><asp:DropDownList ID="ddlLanguage" runat="server" cssclass="form-control m-bot15">
            <asp:ListItem Text="Arabic" Value="2"></asp:ListItem>
            <asp:ListItem Text="English" Value="1" Selected="True"></asp:ListItem>
        </asp:DropDownList>--%>
                        <p class="submit">
                            <asp:Button ID="btnSubmit" runat="server" meta:resourcekey="BtnTextSignin" class="btn btn-orange btn-block" OnClick="btnSubmit_Click" />
                        </p>
                        <div style="text-align: center;">
                            <asp:Label ID="lblSignUpMessage" meta:resourcekey="lblSignUpMessage" Text="Signup here" runat="server"></asp:Label>
                            <a href="mailto:info@futureaviators.ae" target="_top">info@futureaviators.ae</a>
                        </div>
                        <%-- <asp:Label ID="lblErrDesc" runat="server"></asp:Label>--%>
                        <asp:Literal ID="ltNotification" runat="server"></asp:Literal>



                        <%--                <p id="nav">

                    <a class="pull-right" href="RegisterUser.aspx" title="Sign Up">Sign Up</a>
                </p>--%>
                    </div>
                </div>


            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
    <!-- LOAD FILES AT PAGE END FOR FASTER LOADING -->


    <!-- CORE JS FRAMEWORK - START -->
    <script src="assets/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="assets/js/jquery.easing.min.js" type="text/javascript"></script>
    <script src="assets/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="assets/plugins/pace/pace.min.js" type="text/javascript"></script>
    <script src="assets/plugins/perfect-scrollbar/perfect-scrollbar.min.js" type="text/javascript"></script>
    <script src="assets/plugins/viewport/viewportchecker.js" type="text/javascript"></script>
    <!-- CORE JS FRAMEWORK - END -->


    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - START -->
    <script src="assets/plugins/icheck/icheck.min.js" type="text/javascript"></script>
    <!-- OTHER SCRIPTS INCLUDED ON THIS PAGE - END -->


    <!-- CORE TEMPLATE JS - START -->
    <script src="assets/js/scripts.js" type="text/javascript"></script>
    <!-- END CORE TEMPLATE JS - END -->

    <!-- Sidebar Graph - START -->
    <script src="assets/plugins/sparkline-chart/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="assets/js/chart-sparkline.js" type="text/javascript"></script>
    <!-- Sidebar Graph - END -->
</body>
</html>
