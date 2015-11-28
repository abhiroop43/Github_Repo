<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoGallery.ascx.cs" Inherits="FutureAviator.UserControls.PhotoGallery" %>


<asp:Label ID="lblCategoryTitle" runat="server" CssClass="Capital"></asp:Label>
<br />
<br />
<asp:DataList ID="dlGallery" runat="server">
    <ItemTemplate>
        <asp:Image runat="server" ID="imgGalleryCategory" style="width:200px"  ImageUrl='<%# FutureAviator.Utlitity.Helper.GALLERY_IMAGE_PATH + Convert.ToString(Eval("ImagePath")) %>' /><br />
    </ItemTemplate>
</asp:DataList>
<asp:Label ID="lblStatus" runat="server"></asp:Label>

<br />
<br />
<asp:Label ID="lblCategoryDescription" runat="server"></asp:Label>