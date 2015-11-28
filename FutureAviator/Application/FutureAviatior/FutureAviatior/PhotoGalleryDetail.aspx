<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PhotoGalleryDetail.aspx.cs" Inherits="FutureAviator.PhotoGalleryDetail" %>

<%@ Register Src="~/UserControls/PhotoGallery.ascx" TagPrefix="uc1" TagName="PhotoGallery" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc1:PhotoGallery runat="server" ID="PhotoGallery" />
    </div>
    </form>
</body>
</html>
