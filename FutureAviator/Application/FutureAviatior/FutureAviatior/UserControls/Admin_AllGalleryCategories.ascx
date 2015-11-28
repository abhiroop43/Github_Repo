<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AllGalleryCategories.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AllGalleryCategories" %>



<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Gallery Categories</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-right">
                        <p>
                            <a title="Add New Category" href="RegisterPhotoGalleryCategory.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>

                    <asp:GridView OnRowCommand="gv_RowCommand" CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Title">
                                <ItemTemplate>
                                    <%# Eval("CategoryTitle") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <%# FutureAviator.Utlitity.Helper.Truncate(Convert.ToString(Eval("CategoryDescription"))) %>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField Visible="false" HeaderText="Category Image">
                                <ItemTemplate>
                                    <asp:Image ID="img" Width="150px" runat="server" ImageUrl='<%# FutureAviator.Utlitity.Helper.GALLERY_CATEGORY_IMAGE_PATH + Convert.ToString(Eval("CategoryImage")) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderStyle-Width="13%" HeaderText="Tools">
                                <ItemTemplate>
                                      <div class="form-group">
                                        <asp:LinkButton PostBackUrl='<%# "../Admin/RegisterPhotoGalleryCategory.aspx?id=" + Eval("PhotoGalleryCategoryID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandName="EditTemplate">
                                         <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>
                                        <asp:LinkButton CommandArgument='<%# Eval("PhotoGalleryCategoryID").ToString() + "~" + Eval("CategoryTitleTranslationID").ToString() + "~" + Eval("CategoryDescriptionTranslationID").ToString() + "~"+Eval("CategoryImage").ToString() %>' OnClientClick="return confirm('Are you sure to delete this item?')" ID="LinkButton1" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem">
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


