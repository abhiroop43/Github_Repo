<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AddImageContentBox.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AddImageContentBox" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" runat="server" Text="Add News"></asp:Label></h2>
        </header>

        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-9 col-xs-10">

                    <div class="form-group">
                        <label class="form-label" for="field-1">Title (English)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtTitleEnglish" required CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="field-1">Title (Arabic)</label>
                        <div class="controls">
                            <asp:TextBox ID="txtTitleArabic" CssClass="form-control" required runat="server"></asp:TextBox>
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="form-label" for="field-1">Photo</label>
                        <div class="controls">
                            <asp:FileUpload ID="fuPhoto" runat="server" />
                        </div>
                        <div class="controls">
                            <asp:Image ID="imgPhoto" Width="400px" runat="server" Visible="false" />
                        </div>
                    </div>
                    <asp:Panel ID="pnlDetails" runat="server">
                        <div class="form-group">
                            <label class="form-label" for="field-1">Details (English)</label>
                            <div class="controls">

                                <CKEditor:CKEditorControl ID="txtEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
                                </CKEditor:CKEditorControl>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Details (Arabic)</label>
                            <div class="controls">
                               <CKEditor:CKEditorControl ID="txtArabic" runat="server" BasePath="~/assets/plugins/ckeditor">
                                </CKEditor:CKEditorControl>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel runat="server" ID="pnlLink">
                        <div class="form-group">
                            <label class="form-label" for="field-1">External URL</label>
                            <div class="controls">
                                <asp:TextBox ID="txtExternalURL" CssClass="form-control" required runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </asp:Panel>
                    <div class="form-group">

                        <label class="form-label" for="field-1">Is Active?</label>
                        <div class="controls">
                            <asp:CheckBox ID="chkbxIsActive" runat="server" Checked="true" />
                        </div>


                    </div>



                    <div id="ButtonSaveArea" runat="server" class="form-group">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                        <a runat="server" id="AllRecord2" class="btn">Cancel</a>
                    </div>

                    <div id="UpdateButtonArea" runat="server" visible="false" class="form-group">
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                        <a runat="server" id="AllRecord" class="btn">Cancel</a>
                    </div>

                    <asp:HiddenField ID="hdnTitleTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnDescriptionTranslationID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnImageContentBoxID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnImagePath" runat="server" Value="" />
                    <asp:HiddenField ID="hdnContextBoxTypeID" runat="server" Value="" />

                </div>
            </div>


        </div>

    </section>
</div>
