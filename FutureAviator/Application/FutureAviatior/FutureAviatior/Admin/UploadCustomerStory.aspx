<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPages/AdminMaster.Master" CodeBehind="UploadCustomerStory.aspx.cs" Inherits="FutureAviator.Admin.UploadCustomerStory" %>
<%@ Register TagPrefix="FTB" Assembly="FreeTextBox" Namespace="FreeTextBoxControls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../assets/js/jquery-1.11.2.min.js"></script>    
        <script type="text/javascript" src="../assets/js/nicEdit.js"></script>
    <script type="text/javascript" src="../assets/js/scripts.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
            <div class="col-lg-6 col-md-6 col-xs-12 col-sm-12" style="width:100%">
            <section class="box ">
                <header class="panel_header">
                    <h2 class="title pull-left">Add Customer Story</h2>
                </header>
                <div class="content-body">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">

        <div class="form-group">
        <asp:Label ID="lblEventDate" CssClass="form-label" runat="server" Text="English Name: "></asp:Label><asp:TextBox ID="txtEnglishName" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Customer English Name"></asp:TextBox></div>
                            <asp:HiddenField ID="hfStoryID" runat="server" />
        <div class="form-group">
        <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="Arabic Name: "></asp:Label><asp:TextBox ID="txtArabicName" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Customer Arabic Name"></asp:TextBox></div>

        <div class="form-group">
        <asp:Label ID="Label2" CssClass="form-label" runat="server" Text="English Designation: "></asp:Label><asp:TextBox ID="txtEnglishDesignation" CssClass="form-control" runat="server" MaxLength="50" placeholder="Enter Customer English Designation"></asp:TextBox></div>

        <div class="form-group">
        <asp:Label ID="Label3" CssClass="form-label" runat="server" Text="Arabic Designation: "></asp:Label><asp:TextBox ID="txtArabicDesignation" CssClass="form-control" runat="server" MaxLength="50" placeholder="Enter Customer Arabic Designation"></asp:TextBox></div>

        <div class="form-group">
        <asp:Label ID="Label4" CssClass="form-label" runat="server" Text="Story Content English: "></asp:Label>
        <%--<FTB:FreeTextBox id="fbtxtEnglishStoryContent" runat="server" />--%>
                    <textarea style="width:100%; height:100px"  class="nicinstance" id="txtEnglishStoryContent" runat="server"></textarea>
        </div>

        <div class="form-group">
        <asp:Label ID="Label5" CssClass="form-label" runat="server" Text="Story Content Arabic: "></asp:Label>
        <%--<FTB:FreeTextBox id="fbtxtArabicStoryContent" runat="server" />--%>
            <textarea style="width:100%; height:100px"  class="nicinstance" id="txtArabicStoryContent" runat="server"></textarea>
            </div>


        <div class="form-group" id="dvImage" runat="server">
        <asp:Label ID="Label7" CssClass="form-label" runat="server" Text="Image: "></asp:Label><br />
            <div class="uprofile-image">
            <asp:Image ID="imgCustPicture" runat="server" Width="10%" Height="10%" Cssclass="img-responsive" />
                </div>
            </div>

        <div class="form-group">
        <asp:Label ID="Label6" CssClass="form-label" runat="server" Text="Upload Image in jpg format (max. 100KB): "></asp:Label><asp:FileUpload ID="flupImage" runat="server" CssClass="form-control" placeholder="Upload Customer Picture in jpg format"/></div>

        <div class="form-group">
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary " /></div>

        <div class="form-group">
        <asp:Button ID="btnDelete" runat="server" Text="Delete Story" OnClick="btnDelete_Click" CssClass="btn btn-primary " /></div>

        <div class="form-group">
        <asp:Label ID="lblErrDesc" CssClass="form-label" runat="server" ForeColor="Red"></asp:Label></div>

                                        </div>
                                </div>

                            </div>
                        </section></div>

</asp:Content>
