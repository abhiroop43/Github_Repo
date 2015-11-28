<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AddNews.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AddNews" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" runat="server" Text="Register Press Release"></asp:Label></h2>
        </header>

        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-9 col-xs-10">

                    <div class="form-group">
                        <label class="form-label" for="field-1">Title (English)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtNewsTitleEnglish" required CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="field-1">Title (Arabic)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtNewsTitleArabic" CssClass="form-control" required runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="field-1">Press Release Date</label>
                        <div class="controls">
                            <asp:TextBox ID="txtPressReleaseDate" CssClass="form-control" runat="server" type="date"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">

                        <label class="form-label" for="field-1">Photo</label>

                        <div class="controls">
                            <div class="pull-left">
                                <asp:FileUpload ID="fuPhoto" runat="server" />
                            </div>
                            <div style="padding-left: 2%; color: green;" class="pull-left">
                                (Recomended Image Size : 450 X 280)
                            </div>
                        </div>
                        <br />
                        <div class="controls">
                            <asp:Image ID="imgNewsPhoto" Width="400px" runat="server" Visible="false" />
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <label class="form-label" for="field-1">Details (English)</label>
                        <div class="controls">
                            <CKEditor:CKEditorControl ID="txtDetailsEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
                            </CKEditor:CKEditorControl>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="field-1">Details (Arabic)</label>
                        <div class="controls">
                            <CKEditor:CKEditorControl ID="txtDetailsArabic" runat="server" BasePath="~/assets/plugins/ckeditor">
                            </CKEditor:CKEditorControl>
                        </div>
                    </div>


                    <div class="form-group">

                        <label class="form-label" for="field-1">Is Active?</label>
                        <div class="controls">
                            <asp:CheckBox ID="chkbxIsActive" runat="server" Checked="true" />
                        </div>


                    </div>



                    <div id="ButtonSaveArea" runat="server" class="form-group">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                        <a href="AllNews.aspx" class="btn">Cancel</a>
                    </div>

                    <div id="UpdateButtonArea" runat="server" visible="false" class="form-group">
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                        <a href="AllNews.aspx" class="btn">Cancel</a>
                    </div>

                    <asp:HiddenField ID="hdnNewsTitleTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnNewsDescriptionTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnNewsID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnImagePath" runat="server" Value="" />
                </div>
            </div>


        </div>

    </section>
</div>


