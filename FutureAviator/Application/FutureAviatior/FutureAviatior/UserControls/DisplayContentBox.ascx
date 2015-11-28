<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayContentBox.ascx.cs" Inherits="FutureAviator.UserControls.DisplayContentBox" %>

<asp:Panel ID="pnlContentBoxWithDetails" runat="server" Visible="false">

    
    <div class="row container-fluid" runat="server" id="CarrersBlock">
        <asp:Repeater ID="rptBox" runat="server">
            <ItemTemplate>
                <%
                
                     %>
                <%--<div class='<%# Convert.ToInt32(Container.ItemIndex) == 0 ? "col-sm-2 pull-left col-lg-offset-1 teamImage" : "col-sm-2 pull-left teamImage"  %>'>--%>
                <div class='<%# Convert.ToInt32(Container.ItemIndex) == 0 ? " col-md-4 col-lg-2 teamImage" : " col-md-4 col-lg-2 teamImage"  %>'>
                    <img class="scale-with-grid lazy" src='<%# Convert.ToString(FutureAviator.Utlitity.Helper.CONTENT_BOX_IMAGE_PATH + Convert.ToString(Eval("ImagePath"))).Replace("~","") %>' alt='<%# Eval("Title") %>' />
                    <div class="teamName">
                        <h2><%# Eval("Title") %></h2>
                        <div>
                            <a class="white careerLink" href="#" id='<%# "cbox-"+ Container.ItemIndex %>'>
                                <%= FutureAviator.SessionManager.CurrentUser().LanguageCode == BusinessDTO.ApplicationLanguages.en ? GetGlobalResourceObject("English", "ReadMore") :  GetGlobalResourceObject("Arabic", "ReadMore") %>
                            </a>
                        </div>
                    </div>
                </div>

                <div runat="server" visible='<%# FutureAviator.Utlitity.Helper.IsMobileDevice() %>' class="panel-body">
                    <div class="row">
                        <div class='<%# "col-xs-12 col-md-12 col-lg-12 careerDetails cbox-"+ Container.ItemIndex.ToString() %>' style="display: none;">
                            <p>
                                <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                            </p>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>


    <asp:Panel ID="pnlCareerBox"  runat="server">
           
        <div runat="server"  class="panel-body">
            <div class="row " style="padding-left: 40px;">
                <asp:Repeater ID="rptBoxDetails" runat="server">
                    <ItemTemplate>
                        <div class='<%# "col-xs-12 col-md-12 col-lg-12 careerDetails cbox-"+ Container.ItemIndex.ToString() %>' style="display: none;">
                            <p>
                                <%# HttpUtility.HtmlDecode(Eval("Description").ToString()) %>
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </asp:Panel>

</asp:Panel>

<asp:Panel ID="contentBoxWithLink" runat="server" Visible="false">
    <asp:Repeater ID="rptContentLinked" runat="server">
        <ItemTemplate>


            <%--<div class=' <%# Convert.ToInt32(Eval("ImageContentBoxTypeID")) == 2 ? Convert.ToInt32(Container.ItemIndex) == 0 ? "teamImage col-md-3 pull-left col-lg-offset-0" : " teamImage col-md-3 pull-left " : "teamImage col-md-4 pull-left" %> '>--%>
            <div style="padding-left: 0px;" class=' <%# Convert.ToInt32(Eval("ImageContentBoxTypeID")) == 2 ? Convert.ToInt32(Container.ItemIndex) == 0 ? "teamImage col-xs-6 col-md-12 col-lg-3 " : " teamImage col-lg-offset-0 col-xs-6 col-md-12 col-lg-3 " : Convert.ToInt32(Eval("ImageContentBoxTypeID")) >= 3 ? "col-xs-6 col-md-4 col-lg-4" : "teamImage col-lg-offset-0 col-lg-12" %> '>
                <div id="mainwrapper">
                    <!-- Image Caption 1 -->
                    <div id="box-6" class="box">
                        <img src='<%# Convert.ToString(FutureAviator.Utlitity.Helper.CONTENT_BOX_IMAGE_PATH + Convert.ToString(Eval("ImagePath"))).Replace("~","") %>' alt='<%# Eval("Title") %>' class="img-responsive" />
                        <span class="caption scale-caption">
                            <h2 class="pull-left"><%# Eval("Title") %></h2>
                            <p class="clearfix" style="clear: both;">
                                <a href='<%# Eval("LinkURL") %>' target="_blank" class="white pull-left"><%# FutureAviator.Utlitity.Helper.ExtractDomainNameFromURL(Eval("LinkURL").ToString()) %></a>
                            </p>
                        </span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
