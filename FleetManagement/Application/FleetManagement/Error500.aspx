<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error500.aspx.cs" Inherits="Error500" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" class="gt-ie8 gt-ie9 not-ie">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <title>GCAA Fleet Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>

    <!-- Open Sans font from Google CDN -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,600,700,300&amp;subset=latin" rel="stylesheet" type="text/css"/>

    <!-- LanderApp's stylesheets -->
    <link href="assets/stylesheets/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="assets/stylesheets/landerapp.min.css" rel="stylesheet" type="text/css"/>
    <link href="assets/stylesheets/pages.min.css" rel="stylesheet" type="text/css"/>
    <link href="assets/stylesheets/rtl.min.css" rel="stylesheet" type="text/css"/>
</head>
<body class="page-500">
    <form id="form1" runat="server">
        <script>var init = [];</script>

        <div class="header">
            <a href="Home.aspx" class="logo">FLEET MANAGEMENT
		</a>
            <!-- / .logo -->
        </div>
        <!-- / .header -->

        <div class="error-code">500</div>

        <div class="error-text">
            <span class="oops">OUCH!</span><br/>
            <span class="hr"></span>
            <br/>
            SOMETHING IS NOT QUITE RIGHT

            <br/>
            <span class="solve">We hope to solve it shortly</span>
        </div>
        <!-- / .error-text -->


        <script src="assets/javascripts/jquery.min.js" type="text/javascript"></script>
        <script src="assets/javascripts/bootstrap.min.js"></script>
        <script src="assets/javascripts/landerapp.min.js"></script>

        <script type="text/javascript">
            init.push(function () {
                
            });
            window.LanderApp.start(init);
</script>
    </form>
</body>
</html>
