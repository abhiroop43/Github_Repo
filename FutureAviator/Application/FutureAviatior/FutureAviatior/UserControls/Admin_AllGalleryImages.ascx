<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AllGalleryImages.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AllGalleryImages" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Gallery Images</h2>
        </header>

        <div class="content-body">
            <div class="row">



                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div style="clear: both; width: 100%; padding-bottom: 5px; overflow: hidden;">
                        <div class="pull-right">
                            <a title="Add Gallery Image" href="AddGalleryImage.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </div>

                        <div style="margin-right: 5px;" class="pull-right">
                            <asp:DropDownList ID="ddlGalleryCategory" CssClass="form-control m-bot15" AutoPostBack="true" OnSelectedIndexChanged="ddlGalleryCategory_SelectedIndexChanged" required runat="server"></asp:DropDownList>
                        </div>
                    </div>

                    <asp:GridView OnRowCommand="gv_RowCommand" CssClass="table table-striped dt-responsive display" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Gallery Image">
                                <ItemTemplate>
                                    <asp:Image ID="imgSlider" Width="150px" runat="server" ImageUrl='<%# FutureAviator.Utlitity.Helper.GALLERY_IMAGE_PATH +"thumb-" +  Convert.ToString(Eval("ImagePath")) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Create Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tools">
                                <ItemTemplate>
                                    <div class="form-group">
                                        <asp:LinkButton PostBackUrl='<%# "../Admin/AddGalleryImage.aspx?id=" + Eval("PhotoGalleryID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton CommandArgument='<%# Eval("PhotoGalleryID").ToString() + "~" +Eval("ImagePath").ToString() %>' OnClientClick="return confirm('Are you sure to delete this item?')" ID="LinkButton1" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem">
                                         <i class="fa fa-trash-o"></i>
                                        </asp:LinkButton>
                                    </div>

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>


                </div>
            </div>
        </div>

    </section>
</div>
