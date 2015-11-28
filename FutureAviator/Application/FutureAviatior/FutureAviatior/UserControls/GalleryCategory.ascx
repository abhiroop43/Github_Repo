<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GalleryCategory.ascx.cs" Inherits="FutureAviator.UserControls.GalleryCategory" %>


<!--EVENTS END -->
<!--PHOTOGALLERY Start -->

<div class="row container-fluid">
    <div class="headingtxt clearfix col-lg-12">
        <h1 class="pull-left Capital"><%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "PhotoGallery") :  GetGlobalResourceObject("Arabic", "PhotoGallery") %></h1>
    </div>

    <div class="aligncenter">
        <div class="portfolioFilter">
            <a href="#" data-filter="*" class="current">
                <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "AllCategories") :  GetGlobalResourceObject("Arabic", "AllCategories") %>
            </a>
            <asp:Repeater ID="rptgalleryCategories" runat="server">
                <ItemTemplate>
                    <a href="#" data-filter='<%# "."+ Eval("PhotoGalleryCategoryID") %>'><%# Eval("CategoryTitle") %></a>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>
    <div class="panel-body">
        <div class="portfolioContainer">
            <asp:Repeater ID="rptGalleryImages" runat="server">
                <ItemTemplate>

                    <div class='<%# Eval("PhotoGalleryCategoryID") %>'>
                        <a class="example-image-link img-responsive" href='<%# Convert.ToString(FutureAviator.Utlitity.Helper.GALLERY_IMAGE_PATH + Convert.ToString(Eval("PhotoPath"))).Replace("~","") %>' data-lightbox="example-2">
                            <img class="example-image" src='<%# Convert.ToString(FutureAviator.Utlitity.Helper.GALLERY_IMAGE_PATH + "thumb-" + Convert.ToString(Eval("PhotoPath"))).Replace("~","") %>' />
                        </a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>


</div>

