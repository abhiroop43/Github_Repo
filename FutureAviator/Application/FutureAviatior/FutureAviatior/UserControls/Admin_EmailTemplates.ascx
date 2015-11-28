<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_EmailTemplates.ascx.cs" Inherits="FutureAviator.UserControls.Admin_EmailTemplates" %>


<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Email Templates</h2>
        </header>
        <div class="content-body">
            <div id="templateList" runat="server" visible="true" class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" OnRowCommand="gv_RowCommand" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Template Name">
                                <ItemTemplate>
                                    <%# Eval("TemplateName") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email Subject">
                                <ItemTemplate>
                                    <%# Eval("EmailSubject") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Update On">
                                <ItemTemplate>
                                    <%# Eval("UpdateDate") != null ? Convert.ToDateTime(Eval("UpdateDate")).ToShortDateString() : "N/A" %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tools">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandArgument='<%# Eval("EmailTemplateID") %>' CommandName="EditTemplate">
                                         <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>
            </div>

            <div id="editTemplate" runat="server" visible="false" class="row">
                <div class="col-md-12 col-sm-9 col-xs-10">

                    <div class="form-group">
                        <label class="form-label" for="field-1">Email Subject</label>
                        <div class="controls">
                            <asp:TextBox ID="txtEmailSubject" required CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="form-label" for="field-1">Email Body Template</label>
                        <div class="controls">
                            <%--<FTB:FreeTextBox ID="txtNewsDetailsEnglish" runat="server" />--%>
                            <textarea class="nicinstance" style="width: 100%; height: 100px" id="txtEmailBodyTemplate" runat="server"></textarea>
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="form-label">
                            <span class="iCheck">
                                <asp:CheckBox ID="chkbxIsActive" Checked="true" runat="server"></asp:CheckBox>
                            </span>
                            <span>Is Active?</span>
                        </label>
                    </div>


                    <div class="pull-right">
                        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Cancel" OnClick="btnCancel_Click" />

                    </div>


                </div>
            </div>
            


        </div>
    </section>
</div>


