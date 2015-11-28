<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AddGalleryImage.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AddGalleryImage" %>



<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblTitle" runat="server" Text="Add Gallery Image"></asp:Label>
            </h2>
        </header>
        <form id="msg_validate" action="javascript:;" novalidate="novalidate">
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-9 col-xs-10">

                        <div class="form-group">
                            <label class="form-label" for="field-1">Select Gallery Category</label>
                            <div class="controls">
                                <asp:DropDownList ID="ddlGalleryCategory" CssClass="form-control m-bot15" required runat="server"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Gallery Photo</label>
                            <div class="controls">
                                <div class="pull-left">
                                    <asp:FileUpload ID="fuGalleryPhoto" runat="server" />
                                </div>
                                <div style="padding-left: 2%; color: green;" class="pull-left">
                                    (Recomended Image Size : 780 X 520)
                                </div>

                            </div>
                        </div>
                        <br />
                        <div class="form-group">
                            <label class="form-label" for="field-1">Is Active?</label>
                            <div class="controls">
                                <asp:CheckBox ID="chkbxIsActive" runat="server" Checked="true" />

                            </div>
                            <div class="controls">
                                <asp:Image ID="imgGalleryPhoto" Width="400px" runat="server" Visible="false" />
                            </div>
                        </div>


                        <div id="SaveButtonArea" runat="server" class="form-group">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                            <a href="AllGalleryImages.aspx" class="btn">Cancel</a>

                        </div>

                        <div id="UpdateButtonArea" runat="server" visible="false" class="form-group">
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                            <a href="AllGalleryImages.aspx" class="btn">Cancel</a>
                        </div>
                        <asp:HiddenField ID="hdnGalleryImageID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnImagePath" runat="server" Value="" />
                    </div>
                </div>


            </div>
        </form>
    </section>
</div>

