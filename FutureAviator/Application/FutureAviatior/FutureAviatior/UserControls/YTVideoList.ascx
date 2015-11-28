<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YTVideoList.ascx.cs" Inherits="DemoYouTube.YTVideoList" %>

    <div style="margin:0 auto ; width:100%">
    
    <asp:Repeater ID="VideosRepeater" runat="server">
    <ItemTemplate>
       <%--<%# Eval("Title") %>" <br />--%>
       <object width="200" height="150">
            <param name="movie" value="http://www.youtube.com/v/<%# Eval("VideoId") %>"></param>
            <param name="allowFullScreen" value="true"></param>
            <param name="allowscriptaccess" value="always"></param>
            <param name="wmode" value="opaque"></param>
            <embed src="http://www.youtube.com/v/<%# Eval("VideoId") %>?" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="false" wmode="opaque"></embed>
          </object>
    </ItemTemplate>
<%--    <SeparatorTemplate>
      <hr />
    </SeparatorTemplate>--%>
    </asp:Repeater>

    </div>