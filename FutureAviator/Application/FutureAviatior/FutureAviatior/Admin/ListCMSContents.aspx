<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ListCMSContents.aspx.cs" Inherits="FutureAviator.Admin.ListCMSContents" %>
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
            <h2 class="title pull-left">CMS Contents</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">

    <asp:GridView ID="gvCMS" CssClass="table table-striped dt-responsive display MyDataTable" runat="server" OnPageIndexChanging="gvCustomerStories_PageIndexChanging" AutoGenerateColumns="False" Width="100%" OnPreRender="gvCMS_PreRender">
        <Columns>
            <%--<asp:ButtonField CommandName="Select" Text="Select" />--%>
            <asp:BoundField HeaderText="CMSTypeID" DataField="ID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
            <asp:BoundField HeaderText="Section Type Name" DataField="SectionTypeName" />
            <asp:BoundField HeaderText="Created On" DataField="CreatedOn" />
            <%--<asp:ImageField HeaderText="Customer Picture" DataImageUrlField="ImageUrl" DataImageUrlFormatString="data:image/jpg;base64,{0}" ReadOnly="true"></asp:ImageField>--%>  
             <asp:TemplateField HeaderText="Tools">
                <ItemTemplate>
                    <div class="form-group">
                    <asp:LinkButton PostBackUrl='<%# "../admin/CMSEditor.aspx?id=" + Eval("ID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandName="EditTemplate">
                                         <i class="fa fa-pencil"></i>
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
