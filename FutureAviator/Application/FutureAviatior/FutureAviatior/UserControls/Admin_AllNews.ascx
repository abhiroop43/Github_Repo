<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AllNews.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AllNews" %>
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">PRESS RELEASES</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-right">
                        <p>
                            <a title="Add News" href="AddNews.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>

                    <asp:GridView OnRowCommand="gv_RowCommand" CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Title">
                                <ItemTemplate>
                                    <%# Eval("NewsTitle") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Image">
                                <ItemTemplate>
                                    <asp:Image ID="imgSlider" Width="150px" runat="server" ImageUrl='<%# FutureAviator.Utlitity.Helper.NEWS_IMAGE_PATH + Convert.ToString(Eval("ImagePath")) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- <asp:TemplateField HeaderText="News Details">
                                <ItemTemplate>
                                    <%# Eval("NewsDescription") %>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Publish Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tools">
                                <ItemTemplate>

                                    <div class="form-group">
                                        <asp:LinkButton ID="lnkBtnEdit" PostBackUrl='<%# "../admin/AddNews.aspx?id=" + Eval("NewsID") %>' CssClass="btn btn-primary" runat="server" CommandArgument='<%# Eval("NewsID") %>' CommandName="UpdateNews">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton CommandArgument='<%# Eval("NewsID") %>' OnClientClick="return confirm('Are you sure to delete this item?')" ID="LinkButton1" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem">
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
