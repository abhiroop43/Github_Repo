<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminWelcome.aspx.cs" Inherits="FutureAviator.Admin.AdminWelcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: rgba(116, 77, 144, 1.0)
            /*#744d90*/
            ;
            background-image: url('../assets/images/bg.jpg');
            background-attachment: fixed;
            height: 100%;
            max-height: 100%;
            min-height: 99%;
            overflow: hidden;
            width: 100%;
        }

        html, body, #wrapper {
            height: 100%;
            width: 100%;
            margin: 0;
            padding: 0;
            border: 0;
        }

            #wrapper td {
                vertical-align: middle;
                text-align: center;
                min-height: 100%;
                width: 100%;
            }

        .welcomeLogo {
            padding-top: 20%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">

    <%--   <div class="col-md-2 col-md-offset-5">
        <section class="panel">
             <asp:Image ID="imgLogo" runat="server" ImageUrl="~/assets/images/login-logo.png" Style="padding: 10% 20% 30% 35%" />
        </section>
    </div>
    --%>
    <table id="wrapper">
        <tr>
            <td>
                <center>
                <asp:Image CssClass="welcomeLogo img-responsive" ID="imgLogo" runat="server" ImageUrl="~/assets/images/login-logo.png" />
                    </center>
            </td>
        </tr>
    </table>


    <%--       <div class="col-lg-12">
            <section class="box nobox">
                <div class="content-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                            <div class="col-md-6 col-md-offset-5">
                               
                            </div>
                             <h1 class="page_error_code text-light">500</h1>
                            <h1 style="color: #48a1af !important;" class="page_error_info">Oops, The page you requested just run away!!!</h1>

                            <div class="col-md-6 col-sm-6 col-xs-8 col-md-offset-3 col-sm-offset-3 col-xs-offset-2">
                                <form action="javascript:;" method="post" class="page_error_search">
                                    <div class="text-center page_error_btn">
                                        <a class="btn btn-primary btn-lg" href='../'><i class='fa fa-location-arrow'></i>&nbsp; Back to Home</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>--%>
</asp:Content>
