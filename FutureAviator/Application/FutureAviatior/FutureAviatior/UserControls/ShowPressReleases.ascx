<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShowPressReleases.ascx.cs" Inherits="FutureAviator.UserControls.ShowPressReleases" %>

<div class="col-md-8 col-md-offset-2 news">
    <asp:Repeater ID="rptPressReleases" runat="server">


        <ItemTemplate>
            <div class="row divider">
                <div class="col-lg-4">
                    <p>
                        <img class="img-responsive" src='<%# (FutureAviator.Utlitity.Helper.NEWS_IMAGE_PATH + Eval("ImagePath")).Replace("~","") %>' title='<%# DataBinder.Eval(Container.DataItem, "NewsTitle") %>' />
                    </p>
                </div>
                <div class="col-lg-8">
                    <div class="row ">
                        <div class="col-lg-12">
                            <h4>
                                <asp:Label ID="lblPressRlsHeader" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "NewsTitle") %>'></asp:Label>

                            </h4>
                        </div>
                        <div class="col-lg-12">
                            <p>
                                <asp:Label ID="lblPressRlsDate" runat="server" Text ='<%# Convert.ToDateTime(Eval("PressReleaseDate")).ToString(FutureAviator.Utlitity.Helper.DATE_FORMAT) %>'></asp:Label>
                            </p>
                        </div>

                        <div class="col-lg-12">
                            <p>
                                <asp:Label CssClass="custom-content" ID="lblPressRlsContent" runat="server" Text='<%# FutureAviator.Utlitity.Helper.TrimText(DataBinder.Eval(Container.DataItem, "NewsDescription").ToString()) %>'></asp:Label>
                            </p>
                        </div>

                        <div class="col-lg-12 text-right">
                            <p><a href="javascript:void(0);" onclick="ShowNewsDetail('<%# Eval("NewsID") %>','<%# HttpUtility.HtmlEncode(Eval("NewsTitle").ToString()) %>')">
                                <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ReadMore") :  GetGlobalResourceObject("Arabic", "ReadMore") %>
                               </a></p>
                        </div>

                    </div>
                </div>

            </div>
        </ItemTemplate>




    </asp:Repeater>
</div>
