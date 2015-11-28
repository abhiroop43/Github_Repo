<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CMSEditor.aspx.cs" MasterPageFile="~/MasterPages/AdminMaster.Master" Inherits="FutureAviator.Admin.CMSEditor" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../assets/js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../assets/js/nicEdit.js"></script>
    <script type="text/javascript" src="../assets/js/scripts.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="col-lg-6 col-md-6 col-xs-12 col-sm-12" style="width: 100%">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">Content Editor</h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">


                        <%--        <div class="form-group">
        <asp:Label ID="lblSectionType" CssClass="form-label" runat="server" Text="Section Type: "></asp:Label><asp:DropDownList ID="ddlsectionType"  cssclass="form-control m-bot15" runat="server" OnSelectedIndexChanged="ddlsectionType_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></div>--%>


                        <asp:HiddenField ID="hfCMSSectionID" runat="server" />

                        <div class="form-group">
                            <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="Section Name (English): "></asp:Label><asp:TextBox ID="txtSectionNameEnglish" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Section English Name"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label2" CssClass="form-label" runat="server" Text="Section Name (Arabic): "></asp:Label><asp:TextBox ID="txtSectionNameArabic" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Section Arabic Name"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label3" CssClass="form-label" runat="server" Text="Content (English): "></asp:Label>
                            
                            <CKEditor:CKEditorControl ID="txtEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
	
                            </CKEditor:CKEditorControl>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label4" CssClass="form-label" runat="server" Text="Content (Arabic): "></asp:Label>
                           
                            <CKEditor:CKEditorControl ID="txtArabic" runat="server" BasePath="~/assets/plugins/ckeditor">
	
                            </CKEditor:CKEditorControl>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CssClass="btn btn-primary " />

                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblStatus" ForeColor="Red" CssClass="form-label"></asp:Label>
                        </div>


                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>
