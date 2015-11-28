<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="PressReleaseEditor.aspx.cs" Inherits="FutureAviator.Admin.PressReleaseEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript" src="../assets/js/jquery-1.11.2.min.js"></script>    
        <script type="text/javascript" src="../assets/js/nicEdit.js"></script>
    <script type="text/javascript" src="../assets/js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
                <div class="col-lg-6 col-md-6 col-xs-12 col-sm-12" style="width:100%">
                        <section class="box ">
                            <header class="panel_header">
                                <h2 class="title pull-left">Press Release Editor</h2>
                            </header>
                            <div class="content-body">
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">


        <asp:HiddenField ID="hfPressRlsID" runat="server" />

        <div class="form-group">
        <asp:Label ID="Label5" CssClass="form-label" runat="server" Text="Press Release Date: "></asp:Label><asp:TextBox ID="txtPressRlsDate" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Press Release Date" type="date"></asp:TextBox></div>

        <div class="form-group">
        <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="Press Release Header (English): "></asp:Label><asp:TextBox ID="txtPressRlsHeaderEnglish" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Header in English"></asp:TextBox></div>

        <div class="form-group">
        <asp:Label ID="Label2" CssClass="form-label" runat="server" Text="Press Release Header (Arabic): "></asp:Label><asp:TextBox ID="txtPressRlsHeaderArabic" CssClass="form-control" runat="server" MaxLength="50" required="true" placeholder="Enter Header in Arabic"></asp:TextBox></div>

        <div class="form-group">
    <asp:Label ID="Label3" CssClass="form-label" runat="server" Text="Press Release Content (English): "></asp:Label>

            <textarea style="width:100%; height:100px" class="nicinstance" id="txtContentEnglish" runat="server"></textarea>
        </div>

        <div class="form-group">
<asp:Label ID="Label4" CssClass="form-label" runat="server" Text="Press Relase Content Content (Arabic): "></asp:Label>

            <textarea style="width:100%; height:100px" class="nicinstance" id="txtContentArabic" runat="server"></textarea>
        </div>

        <div class="form-group" id="dvImage" runat="server">
        <asp:Label ID="Label7" CssClass="form-label" runat="server" Text="Image: "></asp:Label><br />
            <div class="uprofile-image">
            <asp:Image ID="imgPressPicture" runat="server" Width="10%" Height="10%" Cssclass="img-responsive" />
                </div>
            </div>

        <div class="form-group">
        <asp:Label ID="Label6" CssClass="form-label" runat="server" Text="Upload Image: "></asp:Label><asp:FileUpload ID="flupImage" runat="server" CssClass="form-control" placeholder="Upload Press Release Picture in jpg format"/></div>

        <div class="form-group">
            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" CssClass="btn btn-primary " />

        </div>

        <div class="form-group">
<asp:Label runat="server" ID="lblStatus" ForeColor="Red"  CssClass="form-label"></asp:Label></div>


                                        </div>
                                </div>

                            </div>
                        </section></div>
</asp:Content>
