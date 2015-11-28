<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAdminEvents.aspx.cs" MasterPageFile="~/MasterPages/AdminMaster.Master" Inherits="FutureAviator.Admin.AddAdminEvents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script type="text/javascript" src="../assets/js/jquery-1.11.2.min.js"></script>    
        <script type="text/javascript" src="../assets/js/nicEdit.js"></script>
    <script type="text/javascript" src="../assets/js/scripts.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#fileUpload').hide();
            $('#externalURL').hide();
            ShowEventDetails();
        $("#cphMain_ddlDetailType").change(function () {
            ShowEventDetails();
          });
        });
        function ShowEventDetails()
        {
            var selectedDetail = $('#cphMain_ddlDetailType :selected').val();
            //alert(selectedDetail);
            if (selectedDetail != '' && selectedDetail == 'P') {
                $('#fileUpload').show();
                $('#externalURL').hide();
            }
            else if (selectedDetail != '' && selectedDetail == 'E') {
                $('#fileUpload').hide();
                $('#externalURL').show();
            }
            else {
                $('#fileUpload').hide();
                $('#externalURL').hide();
                $('#cphMain_txtExternalURL').val('');
                $('#cphMain_flupEnglish').val('');
                $('#cphMain_flupArabic').val('');
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
    <div class="col-lg-6 col-md-6 col-xs-12 col-sm-12" style="width: 100%">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">Register New Admin Event</h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="form-group">
                            <asp:Label ID="lblEventFromDate" CssClass="form-label" runat="server" Text="Event Start Date: "></asp:Label>
                            <asp:TextBox ID="txtFromDate" CssClass="form-control" runat="server" type="date" required="true" placeholder="Enter event start date"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblEventToDate" CssClass="form-label" runat="server" Text="Event End Date: "></asp:Label>
                            <asp:TextBox ID="txtToDate" CssClass="form-control" runat="server" type="date" required="true" placeholder="Enter event end date"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblEnglishEventName" CssClass="form-label" runat="server" Text="Event Name (English): "></asp:Label><asp:TextBox ID="txtEnglishName" CssClass="form-control" runat="server" required="true" placeholder="Enter event English Name"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="blbArabicEventName" CssClass="form-label" runat="server" Text="Event Name (Arabic): "></asp:Label><asp:TextBox ID="txtArabicName" CssClass="form-control" runat="server"  required="true" placeholder="Enter event Arabic Name"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblEventVenue" CssClass="form-label" runat="server" Text="Event Venue: "></asp:Label>
                            <asp:TextBox ID="txtEventVenue" CssClass="form-control" runat="server" required="true" placeholder="Enter event venue"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="Label1" CssClass="form-label" runat="server" Text="External URL: "></asp:Label>
                            <asp:DropDownList ID="ddlDetailType" runat="server" CssClass="form-control">
                                <asp:ListItem>--Select--</asp:ListItem>
                                <asp:ListItem Value="P">PDF File</asp:ListItem>
                                <asp:ListItem Value="E">External URL</asp:ListItem>
                            </asp:DropDownList><asp:HiddenField ID="hfDetailType" runat="server" />
                        </div>

                        <div id="externalURL">
                            <div class="form-group">
                                <asp:Label ID="lblExternalURL" CssClass="form-label" runat="server" Text="External URL: "></asp:Label>
                                <asp:TextBox ID="txtExternalURL" CssClass="form-control" runat="server" placeholder="Enter URL of the external site"></asp:TextBox>
                            </div>
                        </div>

                        <div id="fileUpload">
                            <div class="form-group">
                                <asp:Label ID="lblEnglishUpload" CssClass="form-label" runat="server" Text="Upload Event Details (English): "></asp:Label>
                                <asp:FileUpload ID="flupEnglish" runat="server" CssClass="form-control" placeholder="Upload English event details in pdf format" /><br />
                                <asp:HyperLink ID="hypEnglishFile" runat="server" Visible="false">Download English File</asp:HyperLink>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblArabicUpload" CssClass="form-label" runat="server" Text="Upload Event Details (Arabic): "></asp:Label>
                                <asp:FileUpload ID="flupArabic" runat="server" CssClass="form-control" placeholder="Upload Arabic event details in pdf format" /><br />
                                <asp:HyperLink ID="hypArabicFile" runat="server" Visible="false">Download Arabic File</asp:HyperLink>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblLongitude" CssClass="form-label" runat="server" Text="Location Longitude: "></asp:Label>
                            <asp:TextBox ID="txtLongitude" CssClass="form-control" runat="server" MaxLength="50" placeholder="Enter longitude of venue"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblLatitude" CssClass="form-label" runat="server" Text="Location Latitude: "></asp:Label>
                            <asp:TextBox ID="txtLatitude" CssClass="form-control" runat="server" MaxLength="50" placeholder="Enter latitude of venue"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnAdd" runat="server" Text="Add New Event" OnClick="btnAdd_Click" CssClass="btn btn-primary " />

                        </div>

                        <div class="form-group">
                            <asp:Label ID="lblErrDesc" CssClass="form-label" runat="server" ForeColor="Red"></asp:Label>

                        </div>

                    </div>
                </div>

            </div>
        </section>
    </div>
</asp:Content>
