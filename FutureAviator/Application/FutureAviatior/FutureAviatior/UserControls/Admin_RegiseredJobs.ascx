<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Admin_RegiseredJobs.ascx.cs" Inherits="FutureAviator.UserControls.Admin_RegiseredJobs" %>
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Regisered Jobs</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <asp:GridView CssClass="table table-striped dt-responsive display MyDataTable" ID="gv" AutoGenerateColumns="false" OnPreRender="gv_PreRender" runat="server">
                        <Columns>
                            <asp:TemplateField HeaderText="Job Title">
                                <ItemTemplate>
                                    <%# Eval("JobTitle") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Industry">
                                <ItemTemplate>
                                    <%# Eval("IndustryName") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Location">
                                <ItemTemplate>
                                    <%# Eval("CountryName") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <%# Convert.ToBoolean(Eval("IsActive")) == true ? "Active" : "Deactive" %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Post Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("CreateDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Expiry Date">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("ExpiryDate")).ToShortDateString() %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tools">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" PostBackUrl='<%# "../Admin/RegisterJob.aspx?id="+ Eval("JobID") %>' CommandName="UpdateJob">
                                         <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                    <a href="RegisterJob.aspx">Register A Job</a>
                </div>
            </div>
        </div>
    </section>
</div>
