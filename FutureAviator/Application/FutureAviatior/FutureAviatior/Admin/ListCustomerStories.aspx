<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ListCustomerStories.aspx.cs" Inherits="FutureAviator.Admin.ListCustomerStories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
  .hiddencol
  {
    display: none;
  }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="server">
<div class="col-lg-12 col-md-12 col-xs-12 col-sm-12">
    <section class="box ">
        <header class="panel_header">
            <h2 class="title pull-left">Customer Stories</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">


                    <div class="pull-right">
                        <p>
                            <a title="Add New Customer Story" href="UploadCustomerStory.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>


    <asp:GridView ID="gvCustomerStories" CssClass="table table-striped dt-responsive display MyDataTable" runat="server" OnPageIndexChanging="gvCustomerStories_PageIndexChanging" AutoGenerateColumns="False" Width="100%" OnPreRender="gvCustomerStories_PreRender" OnRowDeleting="gvCustomerStories_RowDeleting">
        <Columns>
            <%--<asp:ButtonField CommandName="Select" Text="Select" />--%>
            <asp:BoundField HeaderText="StoryID" DataField="ID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
            <asp:BoundField HeaderText ="Customer Name" DataField="CustName" />
            <asp:BoundField HeaderText="Designation" DataField="Designation" />
            <%--<asp:ImageField HeaderText="Customer Picture" DataImageUrlField="ImageUrl" DataImageUrlFormatString="data:image/jpg;base64,{0}" ReadOnly="true"></asp:ImageField>--%>  
             <asp:TemplateField HeaderText="Tools">
                <ItemTemplate>
                    <div class="form-group">
                    <asp:LinkButton PostBackUrl='<%# "../admin/UploadCustomerStory.aspx?StoryID=" + Eval("ID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandName="EditTemplate">
                                         <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>
                    <asp:LinkButton ID="lnkBtnDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure to delete this item?')" CssClass="btn btn-danger">
                                         <i class="fa fa-trash-o"></i>
                                    </asp:LinkButton>
                        </div>
                </ItemTemplate>                
            </asp:TemplateField>          
        </Columns>
    </asp:GridView>
    <asp:Label ID="lblErrDesc" runat="server" ForeColor="Red"></asp:Label><br /><br />
<%--    <a href="UploadCustomerStory.aspx">Add New Customer Story</a>--%>
        </div>
            </div>
        </div>
    </section>
</div>
</asp:Content>
