<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_AllImageContentBoxes.ascx.cs" Inherits="FutureAviator.UserControls.Admin_AllImageContentBoxes" %>

<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">
                <asp:Label ID="lblMainTitle" runat="server"></asp:Label></h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="pull-right">
                        <p>
                            <a runat="server" id="lnkAddNew" title="Add New" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>
                    <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" OnRowCommand="gv_RowCommand" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Title">
                                <ItemTemplate>
                                    <%# Eval("Title") %>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="External URL">
                                <ItemTemplate>
                                    <a target="_blank" title='<%# Eval("LinkURL") %>' href='<%# Eval("LinkURL") %>'>Link</a>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <span><%# FutureAviator.Utlitity.Helper.TrimText(Eval("Description").ToString()) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Box Image">
                                <ItemTemplate>
                                    <asp:Image ID="imgSlider" Width="150px" runat="server" ImageUrl='<%# FutureAviator.Utlitity.Helper.CONTENT_BOX_IMAGE_PATH + Convert.ToString(Eval("ImagePath")) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ItemStyle-Width="15%" HeaderText="Tools">
                                <ItemTemplate>
                                    <div class="form-group">
                                        <asp:LinkButton CommandName="EditRecord" CommandArgument='<%# Eval("ImageContentBoxID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server">
                                         <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton CommandArgument='<%# Eval("ImageContentBoxID").ToString() + "~" + Eval("ImagePath").ToString() %>' OnClientClick="return confirm('Are you sure to delete this item?')" ID="LinkButton1" CssClass="btn btn-danger" runat="server" CommandName="DeleteItem">
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
    <asp:HiddenField ID="hdnContextBoxTypeID" runat="server" Value="" />
    <asp:HiddenField ID="hdnUpdatePageURL" runat="server" Value="" />
</div>




