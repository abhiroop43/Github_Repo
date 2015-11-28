<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/UserMaster.Master" CodeBehind="Default.aspx.cs" Inherits="FutureAviator.Default" EnableEventValidation="false" %>

<%@ Register TagPrefix="uc" TagName="EventCal" Src="~/UserControls/EventCalendar.ascx" %>
<%@ Register Src="~/UserControls/ContactUs.ascx" TagPrefix="uc" TagName="ContactUs" %>
<%@ Register Src="~/UserControls/CustomerStories.ascx" TagPrefix="uc" TagName="CustomerStories" %>
<%@ Register Src="~/UserControls/LanguageSwitch.ascx" TagPrefix="uc1" TagName="LanguageSwitch" %>
<%@ Register Src="~/UserControls/GalleryCategory.ascx" TagPrefix="uc" TagName="GalleryCategory" %>
<%@ Register Src="~/UserControls/HomePageSlider.ascx" TagPrefix="uc" TagName="HomePageSlider" %>
<%@ Register Src="~/UserControls/DisplayNews.ascx" TagPrefix="uc" TagName="DisplayNews" %>
<%@ Register Src="~/UserControls/DisplayContentBox.ascx" TagPrefix="uc" TagName="DisplayCareers" %>
<%@ Register Src="~/UserControls/ShowPressReleases.ascx" TagPrefix="uc" TagName="ShowPressReleases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <script type="text/javascript">
        var InvalidName = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "InvalidName") :  GetGlobalResourceObject("Arabic", "InvalidName") %>';
        var InvalidEmail = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "InvalidEmail") :  GetGlobalResourceObject("Arabic", "InvalidEmail") %>';
        var InvalidMessage = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "InvalidMessage") :  GetGlobalResourceObject("Arabic", "InvalidMessage") %>';
        var InvalidInputWarning = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "warning") :  GetGlobalResourceObject("Arabic", "warning") %>';
        var InvalidInputSuccess = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "success") :  GetGlobalResourceObject("Arabic", "success") %>';
        var InvalidInputError = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "error") :  GetGlobalResourceObject("Arabic", "error") %>';

        var SubmitSuccessMessage = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "SubmitSuccessMessage") :  GetGlobalResourceObject("Arabic", "SubmitSuccessMessage") %>';
        var SubmitErrorMessage = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "SubmitErrorMessage") :  GetGlobalResourceObject("Arabic", "SubmitErrorMessage") %>';

        var ProjectName = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ProjectName") :  GetGlobalResourceObject("Arabic", "ProjectName") %>';
        var ContactAddress = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ContactAddress") :  GetGlobalResourceObject("Arabic", "ContactAddress") %>';
        var EmailString = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "Email") :  GetGlobalResourceObject("Arabic", "Email") %>';
        var Tel = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "Tel") :  GetGlobalResourceObject("Arabic", "Tel") %>';

        var TestAlignStyle = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? "text-align:left;" : "text-align:right;" %>';

        var NumberInFormat = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? ": 800-4466<br>" : ": 4466-800<br>" %>';

        var LoadingText = '<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "PleaseWait") :  GetGlobalResourceObject("Arabic", "PleaseWait") %>';
    </script>


    <div id="mainDiv" class="mainFormDiv">

        <div class="navi-pad" id="top">
            <div class="header">
                <div class="head-continer">
                    <div class="row">
                        <div class="col-xs-6 sm-offset-0 floatRight">
                            <img id="top" class="img-responsive floatRight lazy" src="userassets/img/gcaawhitelogo.png" width="370px">
                        </div>
                        <div class="col-xs-6 sm-offset-0 floatLeft">
                            <img id="top" class="img-responsive floatLeft" src="userassets/img/futureaviator-01.svg" width="370px">
                        </div>
                        <div class="col-xs-12">
                            <ul class="head-continer Capital">
                                <li>
                                    <uc1:LanguageSwitch runat="server" ID="LanguageSwitch" />
                                </li>
                                <li>
                                    <asp:Label CssClass="MainTop" ID="lblLoginUserName" runat="server"></asp:Label>
                                    <a class="MainTop" href="javascript:void(0);" runat="server" id="hypLogin" onclick="ShowLoginPopup();"></a>
                                </li>
                               
                                <li><a target="_blank" href="https://www.facebook.com/GCAAUAE">
                                    <img src="userassets/img/fbicon.svg"></a></li>
                                <li><a target="_blank" href="https://twitter.com/gcaa_uae">
                                    <img src="userassets/img/twittericon-01.svg"></a></li>
                                <li><a target="_blank" href="https://instagram.com/gcaa_uae">
                                    <img src="userassets/img/instagramicon-01.svg"></a></li>
                                <li><a target="_blank" href="https://www.youtube.com/user/gcaauae">
                                    <img src="userassets/img/youtubeicon-01.svg"></a></li>
                                <%-- <li><a target="_blank" href="https://www.facebook.com/GCAAUAE">
                                    <img src="userassets/img/facebook.png"></a></li>
                                <li><a target="_blank" href="https://twitter.com/gcaa_uae">
                                    <img src="userassets/img/twitter.png"></a></li>
                                <li><a target="_blank" href="https://instagram.com/gcaa_uae">
                                    <img src="userassets/img/instagram.png"></a></li>
                                <li><a target="_blank" href="https://www.youtube.com/user/gcaauae">
                                    <img src="userassets/img/youtube.png"></a></li>--%>
                               <%-- <li><a target="_blank" href="https://www.linkedin.com/company/general-civil-aviation-authority-gcaa-">
                                    <img src="userassets/img/linkdinicon-01.svg"></a></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Black header problem in this code   --->
        <div id="tempDiv" style="position: fixed; z-index: 1500; top: 0px; width: 100%; background-color: green;">
        </div>

        <div id="homePageSliderDiv">
            <uc:HomePageSlider runat="server" ID="HomePageSlider" />
        </div>

        <div id="StickyMain" style="z-index: 1000; width: 100%; position: fixed; bottom: 0px; left: 0px;">
            <div class="Stickynav" style="z-index: 1000; width: 100%; position: fixed;">
                <nav class="navbar navbar-inverse">
                    <div class="container-fluid">
                        <nav class="navbar navbar-inverse" role="navigation">
                            <div class="navbar-header">

                                <div class="floatLeft">
                                    <img id="top" class="menulogo img-responsive padding5px secondaryLogo floatRight" src="userassets/img/gcaawhitelogo.png" style="display: none;">
                                </div>


                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                                    <span class="sr-only">
                                        <asp:Label ID="lblToggleNavigation" meta:resourcekey="lblToggleNavigation" runat="server" Text="Toggle navigation"></asp:Label></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div id="parentMenu" class="collapse navbar-collapse navbar-ex1-collapse">
                                <ul id="top-menu" class="nav navbar-nav Capital">
                                    <li class="active"><a runat="server" meta:resourcekey="lnkHome" id="lnkHome" href="#top">HOME</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkAboutUs" id="lnkAboutUs" href="#aboutgcaa">ABOUT US</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkCareers" id="lnkCareers" href="#careers">CAREERS</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkEducation" id="lnkEducation" href="#education">EDUCATION</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkMedia" id="lnkMedia" href="#media">MEDIA</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkTipsAndAdvice" id="lnkTipsAndAdvice" href="#tipsadvice">TIPS & ADVICE</a></li>
                                    <li><a runat="server" meta:resourcekey="lnkContactUs" id="lnkContactUs" href="#contactgcaa">CONTACT US</a></li>
                                </ul>
                                <!--
                            <div class="floatLeft">
                                <img id="top" class="img-responsive padding5px secondaryLogo floatLeft" src="../userassets/img/futureaviator-01.svg" style="height: 50px; display: none;">
                            </div>
                            -->
                            </div>
                        </nav>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Black header problem end -->

        <div class="news">
            <div>
                <div class="newsstickcont">
                    <div class="marquee-sibling">
                        <asp:Label ID="lblLatestNews" meta:resourcekey="lblLatestNews" runat="server"></asp:Label>
                    </div>
                    <div class="marquee">
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false" RenderMode="Block">
                            <ContentTemplate>
                                <uc:DisplayNews runat="server" ID="DisplayNews" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>

        <div id="home" class="home parallax-height">
            <div id="aboutgcaa" class="text-vcenter">
            </div>
        </div>

        <div id="aboutus" class="row container-fluid">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="cmsAboutUsHeader" class="pull-left Capital" runat="server"></h1>
            </div>
            <div class="col-sm-6">
                <div class="panel-body">
                    <div class="pull-left col-md-3">
                        <img src="userassets/img/dg.jpg" style="padding: 0px 10px;" class="img-responsive " />
                    </div>
                    <div id="cmsAboutUs" runat="server" class="pull-left col-md-9">
                    </div>

                    <blockquote class="pull-right">
                        <asp:Label ID="Label3" meta:resourcekey="DGName" runat="server"></asp:Label><br />
                        <asp:Label ID="Label4" meta:resourcekey="DGDesignation" runat="server"></asp:Label>
                    </blockquote>
                </div>
            </div>
            <div class="col-sm-6 col-md-offset-0">
                <div class="wrapper">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" class="collapsed" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                        <h4 id="cmsIntlAviationOverviewHeader" runat="server"></h4>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <p id="cmsIntlAviationOverView" runat="server">
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        <h4 id="cmsWhyCareerHeader" runat="server"></h4>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body">
                                    <div class="row " style="padding-left: 35px;">
                                        <div>
                                            <div class="col-lg-6 TextAlighLeft" id="cmsWhyHaveCareerInAviation1" runat="server">
                                            </div>
                                            <div class="col-lg-6 TextAlighLeft" id="cmsWhyHaveCareerInAviation2" runat="server">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        <h4 id="cmsIntroToGCAAHeader" runat="server"></h4>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body" id="cmsIntroTOGCAA" runat="server">
                                    <div class="">
                                        <img src="userassets/img/gcaalogo.png" class="img-responsive clear-fix text-center col-lg-12" />
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading" role="tab" id="headingFour">
                                <h4 class="panel-title">
                                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                        <h4 id="cmsUAEOverviewHeader" runat="server"></h4>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                                <div class="panel-body" id="cmsUAEOverview" runat="server">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="page-header"></div>
        <div id="careers" class="careers parallax-height">
        </div>

        <div class="row container-fluid">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="job" class="pull-left Capital" runat="server"></h1>
            </div>
            <div id="careersBody" class="panel-body">
                <div class="row">
                    <uc:DisplayCareers runat="server" ID="DisplayCareers" />
                </div>
            </div>
        </div>


        <div id="NationalCarriers" class="row container-fluid">

            <div class="headingtxt clearfix col-lg-12">
                <h1 class="pull-left Capital" id="cmsNationalCareerHeader" runat="server"></h1>
            </div>
            <div class="col-lg-12">

                <div class="panel-body">
                    <p id="cmsNationalCareers" runat="server">
                    </p>
                </div>
            </div>
            <div class="col-md-12" style="padding-top: 0px;">
                <div class="panel-body">
                    <div class="col-md-12 " style="padding-top: 0px;">
                        <!---Links Start-->
                        <div class="train-tipsec">
                            <div class="wrapper">

                                <div class="row whiteTitle">

                                    <uc:DisplayCareers runat="server" ID="DisplayNationalCarrers" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!---Links End-->
                </div>
            </div>
        </div>


        <div id="education" class="training parallax-height">
        </div>

        <div class="row container-fluid">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="cmsEducationMainHeader" class="pull-left Capital" runat="server"></h1>
            </div>
            <div class="row panel-body">
                <div class="col-md-6 md-offset-0">
                    <h2 id="cmsUAEStudyHeader" class="pull-left clearfix  col-lg-12 Capital" runat="server"></h2>
                    <div class="panel-body">
                        <p class="text-left clearfix">
                            <asp:Label ID="lbl" CssClass="custom-content" runat="server" meta:resourcekey="lblUAEStudyText1"></asp:Label>
                        </p>

                    </div>
                    <div class="col-lg-12">
                        <uc:DisplayCareers runat="server" ID="DisplayUAEStudy" />
                    </div>



                </div>
                <div class="col-md-6 md-offset-0" runat="server" id="addStyle">
                    <h2 id="cmsIntlStudyHeader" class="pull-left clearfix col-lg-12 Capital" runat="server"></h2>
                    <div class="panel-body ">
                        <p class="text-left">
                            <asp:Label ID="lblss" CssClass="custom-content" runat="server" meta:resourcekey="lblInternationalStudyText1"></asp:Label>
                        </p>

                    </div>

                    <uc:DisplayCareers runat="server" ID="DisplayInternationalStudy" />

                </div>
            </div>

        </div>



        <div class="page-header"></div>
        <div id="media" class="training parallax-height"></div>

        <div class="row panel-body">

            <div class="headingtxt clearfix col-lg-12">
                <h1 id="cmsMediaMainHeader" class="pull-left Capital" runat="server"></h1>
            </div>


            <div class="panel-body">
                <div class="row ">
                    <div class="col-md-12">
                        <h2 id="cmsPressRlsHeader" runat="server" class="pull-left clearfix  col-lg-12 Capital"></h2>
                    </div>
                    <uc:ShowPressReleases runat="server" ID="ShowPressReleases" />
                </div>
            </div>
        </div>

        <div class="headingtxt clearfix col-lg-12">
            <h1 id="cmsEventsHeader" class="pull-left Capital" runat="server"></h1>
        </div>



        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <uc:EventCal ID="eventCal1" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>

        </div>

        <div class="page-header"></div>
        <div class="panel-body">
            <uc:GalleryCategory runat="server" ID="GalleryCategory" />
        </div>


        <div class="page-header"></div>
        <div id="tipsadvice" class="tipsadvice parallax-height"></div>

        <div class="row container-fluid">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="TipsAdviceMainHeader" class="pull-left Capital" runat="server"></h1>
            </div>

            <div class="row panel-body TextAlighLeft">
                <div class="col-md-6 md-offset-0" runat="server" id="AddStyle2">

                    <h2 id="cmsInterviewTech1Header" runat="server"></h2>

                    <div class="panel-body custom-content" id="cmsInterviewTech1Content" runat="server">
                    </div>

                    <div class="wrapper">
                        <div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingOne">
                                    <h4 class="panel-title">
                                        <a role="button" data-toggle="collapse" class="collapsed" data-parent="#accordion2" href="#collapseOne2" aria-expanded="false" aria-controls="collapseOne2">
                                            <h4 id="cmsPersonalDetailsHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne2" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsPersonalDetailsContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingTwo">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo2" aria-expanded="false" aria-controls="collapseTwo2">
                                            <h4 id="cmsEducationQualificationHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseTwo2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo2">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsEducationQualificationContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree2" aria-expanded="false" aria-controls="collapseThree">
                                            <h4 id="cmsWorkExHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseThree2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree2">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsWorkExContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseFour2" aria-expanded="false" aria-controls="collapseFour2">
                                            <h4 id="cmsInterestAchievementsHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseFour2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree2">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsInterestAchievementsContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseFive2" aria-expanded="false" aria-controls="collapseFive2">
                                            <h4 id="cmsSkillsHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseFive2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree2">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsSkillsContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default">
                                <div class="panel-heading" role="tab" id="headingThree">
                                    <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#collapseSix2" aria-expanded="false" aria-controls="collapseSix2">
                                            <h4 id="cmsReferencesHeader" runat="server"></h4>
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseSix2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree2">
                                    <div class="custom-content">
                                        <div class="panel-body TextAlighLeft" id="cmsReferencesContent" runat="server">
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>


                    </div>


                </div>


                <div class="col-md-6 md-offset-0">
                    <h2 id="cmsInterviewTech2Header" runat="server"></h2>
                    <div class="custom-content">
                        <div class="panel-body" id="cmsInterviewTech2Content" runat="server">
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <div id="contactgcaa"></div>

        <div class="page-header"></div>


        <div class="container-fluid">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="contactus" class="pull-left Capital"><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ContactUs") :  GetGlobalResourceObject("Arabic", "ContactUs") %></h1>
            </div>


            <div class="aligncenter">

                <p class="lead"><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ContactUsMessage") :  GetGlobalResourceObject("Arabic", "ContactUsMessage") %></p>
                <div class="row">
                    <div class="col-md-6 col-md-offset-3">

                        <div>
                            <div class="form-group col-lg-6">
                                <label for="name"></label>
                                <input type="text" class="form-control" style="width: 100%; display: inline-block" id="name" placeholder="<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "YourName") :  GetGlobalResourceObject("Arabic", "YourName") %>" maxlength="80" />
                            </div>
                            <div class="form-group col-lg-6">
                                <label for="youremail"></label>
                                <input type="email" class="form-control" style="width: 100%; display: inline-block" id="youremail" placeholder="<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "YourEmail") :  GetGlobalResourceObject("Arabic", "YourEmail") %>" maxlength="80" />
                            </div>
                        </div>
                        <div>
                            <div class=" col-lg-12">
                                <div class="">
                                    <label id="smsid" for="yourmessage"></label>
                                    <textarea class="form-control" style="width: 100%; display: inline-block" rows="5" placeholder="<%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "YourMessage") :  GetGlobalResourceObject("Arabic", "YourMessage") %>" maxlength="1000" id="ContactRequestMsg"></textarea>
                                </div>
                            </div>
                        </div>
                        <!-- BUTTON TRIGGER ICON//-->
                        <!-- Button trigger modal -->
                        <div>
                            <div class="col-lg-12">
                                <button type="button" class="btn btn-gclr btn-lg " style="margin-top: 10px;" data-toggle="modal" data-target="#myModal" id="btnContactUsSubmit" onclick="SubmitContactUsForm();">
                                    <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "Submit") :  GetGlobalResourceObject("Arabic", "Submit") %>
                                </button>
                            </div>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <h4 class="modal-title" id="myModalLabel"></h4>
                                    </div>
                                    <div class="modal-body" id="ContactUsMsgBody">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">
                                            <asp:Label ID="Label6" runat="server" meta:resourcekey="lblClose"></asp:Label>
                                        </button>
                                        <%--                        <button type="button" class="btn btn-primary">Save changes</button>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- BUTTON TRIGGER END-->


                    </div>
                </div>
            </div>
        </div>
        <div id="LocationMap"></div>
        <div class="page-header"></div>

        <div class="row ">
            <div class="headingtxt clearfix col-lg-12">
                <h1 id="cmsLocationMapMainHeader" class="pull-left Capital" runat="server"></h1>
            </div>

            <div>
                <div class="aligncenter">

                    <div style="padding-left:25px; padding-right:10px;">
                        <div id="googleMap" style="width: 100%; height: 380px;"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="page-header"></div>
        <asp:UpdatePanel ID="updtCustStories" runat="server">
            <ContentTemplate>
                <uc:CustomerStories runat="server" ID="CustomerStories" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="CustomerStories" />
            </Triggers>
        </asp:UpdatePanel>


        <div class="aligncenter">
            <div class="container">
                <div class="row">
                    <div class="col-xs-4 col-lg-4">
                        <img src="userassets/img/phone-01.svg" class="contactClass" />
                        <br />
                        <br />
                        <span class="contactFontSize">800-4466</span>

                    </div>
                    <div class="col-xs-4 col-lg-4">
                        <a href="mailto:info@futureaviators.ae">
                        <img src="userassets/img/envelope.svg" class="contactClass" />
                        <br />
                        <br />
                        <div class="visible-lg">
                                <span class="contactFontSize">info@futureaviators.ae</span>
                        </div>
                        <div class="visible-xs">
                                <span class="contactFontSize">info@ futureaviators.ae</span>
                            </div>
                        </a>
                        </div>
                    <div class="col-xs-4 col-lg-4 bottomLink">

                        <a href="#LocationMap">
                        <img src="userassets/img/location.svg" class="contactClass" />
                        <br />
                        <br />
                        <span class="contactFontSize"><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ContactAddressFooter") :  GetGlobalResourceObject("Arabic", "ContactAddressFooter") %></span>
                        </a>
                    </div>
                </div>
            </div>
            <!--footer start -->
            <footer class="footer">
                <div class="container">
                    <p class="text-muted white panel-body">&#169; 2015 <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ProjectName") :  GetGlobalResourceObject("Arabic", "ProjectName") %>  |  <a href="javascript:void(0);" onclick="ShowPrivacyPolicy();"><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "PrivacyPolicy") :  GetGlobalResourceObject("Arabic", "PrivacyPolicy") %></a></p>
                </div>
            </footer>
            <!--footer end -->
        </div>


        <div class="modal fade" id="modalNews" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="large modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title" id="ModalNewsTitle"></h4>
                    </div>
                    <div class="modal-body">
                        <iframe id="newsIframe" src="" style="height: 100%; width: 100%;" frameborder="0" allowtransparency="true"></iframe>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <asp:Label ID="Label1" runat="server" meta:resourcekey="lblClose"></asp:Label></button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalLoginX" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h1 class="text-center">Login</h1>
                    </div>
                    <div class="modal-body">
                        <div class="form col-md-12 center-block">
                            <div class="form-group">
                                <input type="text" class="form-control input-lg" placeholder="Email">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control input-lg" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary btn-lg btn-block">Sign In</button>
                            </div>
                        </div>
                    </div>
                    <div style="border-top: none;" class="modal-footer">
                        <div class="col-md-12">
                            <button class="btn" data-dismiss="modal" aria-hidden="true">
                                <asp:Label ID="Label2" runat="server" meta:resourcekey="lblClose"></asp:Label></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalLogin" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="large modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">
                            <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "LoginPageTitle") :  GetGlobalResourceObject("Arabic", "LoginPageTitle") %>
                        </h4>
                    </div>
                    <div style="padding: 0 !important;" class="modal-body">
                        <iframe src="/Login.aspx?source=home" style="height: 100%; width: 100%;" frameborder="0" allowtransparency="true"></iframe>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <asp:Label ID="lblClose" runat="server" meta:resourcekey="lblClose"></asp:Label>
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%--privacy policy start--%>
        <div class="modal fade" id="modalPrivacyPolicy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="large modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">
                            <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "PrivacyPolicy") :  GetGlobalResourceObject("Arabic", "PrivacyPolicy") %>
                        </h4>
                    </div>
                    <div class="modal-body">
                        <iframe src="/PrivacyPolicy.aspx" style="height: 100%; width: 100%; padding: 5px;" frameborder="0" allowtransparency="true"></iframe>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <asp:Label ID="Label8" runat="server" meta:resourcekey="lblClose"></asp:Label></button>
                    </div>
                </div>
            </div>
        </div>
        <%--privacy policy end--%>
    </div>

</asp:Content>
