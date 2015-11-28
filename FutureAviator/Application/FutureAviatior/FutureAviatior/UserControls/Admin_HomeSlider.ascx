<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_HomeSlider.ascx.cs" Inherits="FutureAviator.UserControls.Admin_HomeSlider" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" Text="Add New Home Page Slide" runat="server"></asp:Label></h2>
        </header>
        <form id="msg_validate" action="javascript:;" novalidate="novalidate">
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-9 col-xs-10">

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Title (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtSliderTitleEnglish" CssClass="form-control" required runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Title (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtSliderTitleArabic" CssClass="form-control" required runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Subtitle (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtSubTitleEnglish" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Subtitle (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtSubTitleArabic" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Button Text (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtButtonTextEnglish" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Button Text (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtButtonTextArabic" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Button URL</label>
                            <div class="controls">
                                <asp:TextBox ID="txtURL" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Slide Image</label>
                            <div class="controls">
                                 <div class="pull-left">
                                <asp:FileUpload ID="fuSliderImage" runat="server" />
                                     </div>
                                 <div style="padding-left: 2%; color: green;" class="pull-left">
                                    (Recomended Image Size : 1920 X 720)
                                </div>
                            </div>
                             <br />
                            <div class="controls">
                                <asp:Image ID="imgSlider" Width="400px" runat="server" Visible="false" />
                            </div>
                        </div>
                        <br />
                        <div class="form-group">
                            <label class="form-label" for="field-1">Is Active?</label>
                            <div class="controls">
                                <asp:CheckBox ID="chkbxIsActive" runat="server" Checked="true" />
                            </div>
                        </div>


                        <div id="SaveButtonArea" runat="server" class="form-group">
                            <asp:Button runat="server" CssClass="btn btn-success" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                            <a href="AllSliders.aspx" class="btn">Cancel</a>
                        </div>


                        <div id="UpdateButtonArea" runat="server" visible="false" class="form-group">
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                            <a href="AllSliders.aspx" class="btn">Cancel</a>
                        </div>
                    </div>
                </div>

                <asp:HiddenField ID="hdnSlideID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnTitleTranslationID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnSubTitleTranslationID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnButtonTextTranslationID" runat="server" Value="0" />
                <asp:HiddenField ID="hdnImagePath" runat="server" Value="" />
            </div>
        </form>
    </section>
</div>

