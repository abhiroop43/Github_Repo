<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="UpdatePrivacyPolicy.aspx.cs" Inherits="FutureAviator.Admin.UpdatePrivacyPolicy" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="col-lg-6 col-md-6 col-xs-12 col-sm-12" style="width: 100%">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">Update Privacy Policy</h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <asp:HiddenField ID="hfPolicyID" runat="server" />
                        <div class="form-group">
                            <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="Privacy Policy (English):"></asp:Label>
                            <CKEditor:CKEditorControl ID="txtEnglish" runat="server" BasePath="~/assets/plugins/ckeditor">
                            </CKEditor:CKEditorControl>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label5" CssClass="form-label" runat="server" Text="Privacy Policy (Arabic): "></asp:Label>
                            <CKEditor:CKEditorControl ID="txtArabic" runat="server" BasePath="~/assets/plugins/ckeditor">
                            </CKEditor:CKEditorControl>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-primary " />
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>
