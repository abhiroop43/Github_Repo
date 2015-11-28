<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_JobResponses.ascx.cs" Inherits="FutureAviator.UserControls.Admin_JobResponses" %>
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Job Responses</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="User Name">
                                <ItemTemplate>
                                    <%# Eval("UserDisplayName") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Job Title">
                                <ItemTemplate>
                                    <%# Eval("JobTitle") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            

                            <asp:TemplateField HeaderText="Applied Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("AppliedDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Job Expiry Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("JobExpiryDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Tools">
                                <ItemTemplate>
                                    
                                    <a ID="lnkBtnEdit" class="btn btn-primary" onclick='javascript:ShowJobResponseDetails("<%# Eval("ResponseID") + "~" +  Eval("UserID")+ "~" +  Eval("JobID") %>")'>
                                         <i class="fa fa-search-plus"></i>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </section>
</div>
