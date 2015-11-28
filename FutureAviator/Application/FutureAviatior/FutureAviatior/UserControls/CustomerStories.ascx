<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerStories.ascx.cs" Inherits="FutureAviator.UserControls.CustomerStories" %>

<br />
<style type="text/css">
    #quote-carousel .inner-testimonials {
        /*background-color: #b3dfe3;
        padding: 50px;*/
        border-radius: 25px;
        min-height: 270px;
        overflow: hidden;
    }



    #quote-carousel .carousel-control {
        background: none;
        color: #CACACA;
        font-size: 2.3em;
        text-shadow: none;
        margin-top: -180px;
    }

    #quote-carousel .carousel-indicators {
        position: relative;
        /*right: 50%;*/
        top: auto;
        bottom: 80px;
        margin-top: 45px;
        min-height: 80px;
        /*margin-right: -19px;*/
    }

        #quote-carousel .carousel-indicators li {
            width: 50px;
            height: 50px;
            cursor: pointer;
            border: 1px solid #ccc;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            border-radius: 50%;
            opacity: 0.6;
            overflow: hidden;
            transition: all .4s ease-in;
            vertical-align: middle;
        }

        #quote-carousel .carousel-indicators .active {
            width: 80px;
            height: 80px;
            opacity: 1;
            transition: all .2s;
        }

    #quote-carousel item.active p {
        margin-left: auto;
        margin-right: auto;
    }

    #quote-carousel .item blockquote {
        border: none;
        margin: 0;
    }

    #quote-carousel small {
        content: '';
        width: 100%;
        font-size: 110%;
    }
    /*.item blockquote p:before {
            content: "\f10d";
            font-family: 'Fontawesome';
            float: left;
            margin-right: 10px;
        }*/

    #quote-carousel .carousel-control.left {
        left: -40px;
    }

    #quote-carousel .carousel-control.right {
        right: -40px;
    }

    #quote-carousel .carousel-inner {
        min-height: 180px;
    }

    @media (min-width:250px) and (max-width:500px) {
        #quote-carousel .carousel-indicators {
            position: relative;
            /*right: 50%;*/
            top: auto;
            margin-top: 80px;
            /*margin-right: -19px;*/
        }

            #quote-carousel .carousel-indicators li {
                width: 40px !important;
                height: 40px !important;
                cursor: pointer;
                border: 1px solid #ccc;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
                border-radius: 50%;
                opacity: 0.6;
                overflow: hidden;
                transition: all .4s ease-in;
                vertical-align: middle;
            }

            #quote-carousel .carousel-indicators .active {
                width: 80px;
                height: 80px;
                opacity: 1;
                transition: all .2s;
            }

        #quote-carousel .carousel-control {
            display: none;
        }

        .testimonial {
            font-family: "Tradegothic-regular";
            margin: 0;
            background: #fff  !important;
            padding: 35px 50px;
            position: relative;
            color: #000 !important;
            border-radius: 5px;
            text-shadow: 0 1px 0 #ECFBFF;
            background-image: linear-gradient(#CEF3FF, #48a1af);

        }
    }



    .testimonial {
        font-family: "Tradegothic-regular";
        margin: 0;
        background: #48a1af;
        padding: 35px 50px;
        position: relative;
        color: #000 !important;
        border-radius: 5px;
        text-shadow: 0 1px 0 #ECFBFF;
        background-image: linear-gradient(#CEF3FF, #48a1af);
    }

        .testimonial:before, .testimonial:after {
            content: "\201C";
            position: absolute;
            font-size: 80px;
            line-height: 1;
            color: gray;
            font-style: normal;
        }

        .testimonial:before {
            top: 0;
            left: 10px;
        }

        .testimonial:after {
            content: "\201D";
            right: 10px;
            bottom: -0.5em;
        }

    .arrow-down {
        width: 0;
        height: 0;
        border-left: 15px solid transparent;
        border-right: 15px solid transparent;
        border-top: 15px solid #B7EDFF;
        margin: 0 0 0 25px;
    }

    .testimonial-author {
        margin: 0 0 0 25px;
        font-family: Arial, Helvetica, sans-serif;
        color: #999;
        text-align: left;
    }

        .testimonial-author span {
            font-size: 12px;
            color: #666;
        }
</style>

<div class="row container-fluid">
    <div class="headingtxt clearfix col-lg-12">
        <h1 id="MainHeader" class="pull-left Capital" runat="server"></h1>
    </div>


    <%--New Code--%>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="carousel slide" data-ride="carousel" id="quote-carousel">
                    <div class="inner-testimonials">
                        <!-- Carousel Slides / Quotes -->
                        <div id="testimonial-area" class="carousel-inner text-center">
                            <asp:Repeater ID="rptQuote" runat="server">
                                <ItemTemplate>
                                    <div class='<%# Convert.ToInt32(Container.ItemIndex) == 0 ? "item active":"item" %>'>
                                        <blockquote>
                                            <div style="min-height: 150px; overflow: hidden;" class="row">
                                                <div class="col-sm-8 col-sm-offset-2">
                                                    <p class="testimonial" style="text-align: center">
                                                        <%# FutureAviator.Utlitity.Helper.ConvertHTMLToText(Eval("StoryContent").ToString()) %>
                                                    </p>
                                                    <small class="pull-left TextAlighRight"><%# FutureAviator.Utlitity.Helper.ConvertHTMLToText(Eval("CustName").ToString()) %></small>
                                                </div>
                                            </div>
                                        </blockquote>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>


                            <%-- <!-- Quote 1 -->
                    <div class="item active">
                        <blockquote>
                            <div class="row">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. !</p>
                                    <small>Someone famous</small>
                                </div>
                            </div>
                        </blockquote>
                    </div>
                    <!-- Quote 2 -->
                    <div class="item">
                        <blockquote>
                            <div class="row">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. </p>
                                    <small>Someone famous</small>
                                </div>
                            </div>
                        </blockquote>
                    </div>
                    <!-- Quote 3 -->
                    <div class="item">
                        <blockquote>
                            <div class="row">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. .</p>
                                    <small>Someone famous</small>
                                </div>
                            </div>
                        </blockquote>
                    </div>--%>
                        </div>
                        <!-- Bottom Carousel Indicators -->
                        <ol class="carousel-indicators">
                            <asp:Repeater ID="rptCustImages" runat="server">
                                <ItemTemplate>
                                    <li data-target="#quote-carousel" data-slide-to='<%# Container.ItemIndex %>' class='<%# Convert.ToInt32(Container.ItemIndex) == 0 ? "active":"" %>'>
                                        <img class="img-responsive " src='<%# String.Format("data:image/jpg;base64,{0}", Convert.ToBase64String((byte[])Eval("CustPicture"))) %>' alt="">
                                    </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ol>
                        <%-- <ol class="carousel-indicators">
                    <li data-target="#quote-carousel" data-slide-to="0" class="active">
                        <img class="img-responsive " src="https://s3.amazonaws.com/uifaces/faces/twitter/mantia/128.jpg" alt="">
                    </li>
                    <li data-target="#quote-carousel" data-slide-to="1">
                        <img class="img-responsive" src="https://s3.amazonaws.com/uifaces/faces/twitter/adhamdannaway/128.jpg" alt="">
                    </li>
                    <li data-target="#quote-carousel" data-slide-to="2">
                        <img class="img-responsive" src="https://s3.amazonaws.com/uifaces/faces/twitter/brad_frost/128.jpg" alt="">
                    </li>
                </ol>--%>
                    </div>
                    <!-- Carousel Buttons Next/Prev -->
                    <a data-slide="prev" href="#quote-carousel" class="left carousel-control"><i class="glyphicon glyphicon-chevron-left"></i></a>
                    <a data-slide="next" href="#quote-carousel" class="right carousel-control"><i class="glyphicon glyphicon-chevron-right"></i></a>

                </div>
            </div>
        </div>
    </div>
</div>






