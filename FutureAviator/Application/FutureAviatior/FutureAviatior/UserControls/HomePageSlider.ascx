<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HomePageSlider.ascx.cs" Inherits="FutureAviator.UserControls.HomePageSlider" %>


<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
     <ol class="carousel-indicators">
         <asp:Repeater runat="server" ID="rptHomeSlider">
             <ItemTemplate>
                 <li data-target="#myCarousel" data-slide-to='<%# Container.ItemIndex %>' class='<%# Container.ItemIndex == 0 ? "active" : "" %>'></li>
             </ItemTemplate>
         </asp:Repeater>
     </ol>

    <div class="carousel-inner" role="listbox">
        <asp:Repeater runat="server" ID="rptHomeSlider2">
            <ItemTemplate>
                <div class='<%# Container.ItemIndex == 0 ? "item active" : "item" %>'>
                    <img class="first-slide" src='<%# Convert.ToString(FutureAviator.Utlitity.Helper.HOME_SLIDER_IMAGE_PATH + Convert.ToString(Eval("ImagePath"))).Replace("~","") %>' alt='<%# Eval("Title") %>'>
                    <div class="container">
                        <div class="carousel-caption">
                            <div class="h1bntxt">
                                <h1><%# Eval("Title") %></h1>
                            </div>
                            <h2><%# Eval("SubTitle") %></h2>
                            <p runat="server" visible='<%# Convert.ToString(Eval("ButtonLink")).Trim() != "" ? true : false %>'><a class="btn btn-lg btn-outline" href='<%# Eval("ButtonLink") %>' role="button"><%# Eval("ButtonText") %></a></p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

