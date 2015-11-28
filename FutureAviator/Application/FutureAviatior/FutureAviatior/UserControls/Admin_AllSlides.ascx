<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AllSlides.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AllSlides" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Home Page Slides</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <p class="col-md-12 col-sm-12 col-xs-12">

                    <div class="pull-right">
                        <p>
                            <a title="Add New Slide" href="HomePageSlider.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>

                    <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" OnRowCommand="gv_RowCommand" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Slide Title">
                                <ItemTemplate>
                                    <%# Eval("Title") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Slide Sub Title">
                                <ItemTemplate>
                                    <%# Eval("SubTitle") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Button Text">
                                <ItemTemplate>
                                    <%# Eval("ButtonText") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Button URL">
                                <ItemTemplate>
                                    <a target="_blank" title='<%# Eval("ButtonLink") %>' href='<%# Eval("ButtonLink") %>'>Link</a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Slide Image">
                                <ItemTemplate>
                                    <asp:Image ID="imgSlider" Width="150px" runat="server" ImageUrl='<%# FutureAviator.Utlitity.Helper.HOME_SLIDER_IMAGE_PATH + Convert.ToString(Eval("ImagePath")) %>' />
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
                                        <asp:LinkButton PostBackUrl='<%# "../admin/HomePageSlider.aspx?id=" + Eval("SliderID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton CommandArgument='<%# Eval("SliderID").ToString() + "~" + Eval("ImagePath").ToString() %>' OnClientClick="return confirm('Are you sure to delete this item?')" ID="LinkButton1" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem">
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


