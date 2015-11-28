<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DisplayNews.ascx.cs" Inherits="FutureAviator.UserControls.DisplayNews" %>
<ul class="marquee-content-items">
    <asp:Repeater runat="server" ID="rptHomeNews">
        <ItemTemplate>
            <li><a onclick="ShowNewsDetail('<%# Eval("NewsID") %>','<%# HttpUtility.HtmlEncode(Eval("NewsTitle").ToString()) %>')" href="javascript:void(0);"><%# Eval("NewsTitle") %> </a></li>
        </ItemTemplate>
    </asp:Repeater>
</ul>
