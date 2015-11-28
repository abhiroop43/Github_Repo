<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_RegisterPhotoGalleryCategory.ascx.cs" Inherits="FutureAviator.UserControls.Admin_RegisterPhotoGalleryCategory" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" Text="Add Photo Gallery Category" runat="server"></asp:Label></h2>
        </header>
        <form id="msg_validate" action="javascript:;" novalidate="novalidate">
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-9 col-xs-10">

                        <div class="form-group">
                            <label class="form-label" for="field-1">Category Title (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCategoryTitleEnglish" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="field-1">Category Title (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCategoryTitleArabic" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>

                        <div runat="server" visible="false" class="form-group">
                            <label class="form-label" for="field-1">Category Photo</label>
                            <div class="controls">
                                <asp:FileUpload ID="fuCategoryPhoto" runat="server" />
                            </div>
                            <div class="controls">
                                <asp:Image ID="imgCategoryPhoto" Width="400px" runat="server" Visible="false" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Category Description (English)</label>
                            <div class="controls">

                                <CKEditor:CKEditorControl ID="txtDescriptionEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
                                </CKEditor:CKEditorControl>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Category Description (Arabic)</label>
                            <div class="controls">

                                <CKEditor:CKEditorControl ID="txtDescriptionArabic" runat="server" BasePath="~/assets/plugins/ckeditor">
                                </CKEditor:CKEditorControl>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Is Active?</label>
                            <div class="controls">
                                <asp:CheckBox CssClass="skin-square-green" ID="chkbxIsActive" runat="server" Checked="true" />
                            </div>
                        </div>

                        <div id="SaveButtonArea" runat="server" class="form-group">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                            <a href="AllGalleryCategories.aspx" class="btn">Cancel</a>
                        </div>

                        <div id="UpdateButtonArea" runat="server" visible="false" class="form-group">
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                            <a href="AllGalleryCategories.aspx" class="btn">Cancel</a>
                        </div>
                        <asp:HiddenField ID="hdnGalleryCategoryID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnTranslationTitleID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnTranslationDescriptionID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnImagePath" runat="server" Value="" />
                    </div>
                </div>


            </div>
        </form>
    </section>
</div>


