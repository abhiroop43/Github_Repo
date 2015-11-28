<%@ Page Title="Admin : Add Job Components" EnableEventValidation="false" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="JobComponents.aspx.cs" Inherits="FutureAviator.Admin.JobComponents" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">



    <div class='col-lg-12 col-md-12 col-sm-12 col-xs-12'>
        <div class="page-title">

            <div class="pull-left">
                <h1 class="title">Job Components</h1>
            </div>


        </div>
    </div>
    <div class="clearfix"></div>
    <div id="AddIndustry" runat="server" class="col-lg-6 col-md-6 col-xs-12 col-sm-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">
                    <asp:Label ID="lblTitleIndustry" runat="server" Text="Add Job Industry"></asp:Label></h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">

                        <div class="form-group">
                            <label class="form-label" for="field-1">Industry Name (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtIndusryNameEnglish" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="field-1">Industry Name (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtIndusryNameArabic" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="form-label">
                                <asp:CheckBox ID="chkbxIsActve" CssClass="iCheck" runat="server" Checked="true" />
                                <span>Is Active?</span>
                            </label>
                        </div>

                        <div id="IndustrySaveButtonArea" runat="server" class="form-group">
                            <asp:Button ID="btnAddIndustry" CssClass="btn btn-primary " runat="server" Text="Save" OnClick="btnAddIndustry_Click" /><br />
                        </div>

                        <div id="IndustryUpdateButtonArea" runat="server" visible="false" class="pull-right">
                            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnShowAll" runat="server" CssClass="btn" Text="Cancel" OnClick="btnShowAll_Click" />
                        </div>
                        <asp:HiddenField ID="hdnIndustryID" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnIndustryNameTranslationID" runat="server" Value="0" />


                    </div>
                </div>

            </div>
        </section>
    </div>

    <div id="AddLocation" runat="server" class="col-lg-6 col-md-6 col-xs-12 col-sm-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left"><asp:Label ID="lblTitleLocation" runat="server" Text="Add Job Location"></asp:Label></h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="form-group">
                            <label class="form-label" for="field-1">Location Name (English)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCountryNameEnglish" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="field-1">Location Name (Arabic)</label>
                            <div class="controls">
                                <asp:TextBox ID="txtCountryNameArabic" CssClass="form-control" runat="server" required></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                <asp:CheckBox ID="chkbxLocationIsActive" CssClass="iCheck" runat="server" Checked="true" />
                                <span>Is Active?</span>
                            </label>
                        </div>
                        <div id="LocationSaveButtonArea" runat="server" class="form-group">
                            <asp:Button ID="btnAddCountry" CssClass="btn btn-primary " runat="server" Text="Save" OnClick="btnAddCountry_Click" />
                        </div>

                        <div id="LocationUpdateButtonArea" runat="server" visible="false" class="pull-right">
                            <asp:Button ID="btnUpdateLocation" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnUpdateLocation_Click" />
                            <asp:Button ID="btnShowEveryting" runat="server" CssClass="btn" Text="Cancel" OnClick="btnShowAll_Click" />
                        </div>
                        <asp:HiddenField ID="hdnLocationNameTranslationID" runat="server" Value="0" />
                    </div>
                </div>
            </div>
        </section>
    </div>


    <div id="AllIndustries" runat="server" class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">Job Industries</h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <asp:GridView OnRowCommand="gvIndustries_RowCommand" CssClass="table table-striped dt-responsive display MyDataTable" ID="gvIndustries" AutoGenerateColumns="false" OnPreRender="gvIndustries_PreRender" runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="Industry Name">
                                    <ItemTemplate>
                                        <%# Eval("IndustryName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Reg. Date">
                                    <ItemTemplate>
                                        <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tools">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandArgument='<%# Eval("IndustryID") %>' CommandName="UpdateIndustry">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div id="AllLocation" runat="server" class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
        <section class="box ">
            <header class="panel_header">
                <h2 class="title pull-left">Job Locations</h2>
            </header>
            <div class="content-body">
                <div class="row">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <asp:GridView OnRowCommand="gvAllLocations_RowCommand" CssClass="table table-striped dt-responsive display MyDataTable" ID="gvAllLocations" AutoGenerateColumns="false" OnPreRender="gvAllLocations_PreRender" runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="Location Name">
                                    <ItemTemplate>
                                        <%# Eval("LocationName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Reg. Date">
                                    <ItemTemplate>
                                        <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tools">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandArgument='<%# Eval("LocationID") %>' CommandName="UpdateLocation">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </section>
    </div>

</asp:Content>
