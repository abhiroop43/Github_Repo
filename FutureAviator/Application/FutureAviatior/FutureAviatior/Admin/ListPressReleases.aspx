<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ListPressReleases.aspx.cs" Inherits="FutureAviator.Admin.ListPressReleases" %>
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
            <h2 class="title pull-left">Press Releases</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">


                    <div class="pull-right">
                        <p>
                            <a title="Add New Press Release" href="PressReleaseEditor.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>


    <asp:GridView ID="gvPressReleases" CssClass="table table-striped dt-responsive display MyDataTable" runat="server" OnPageIndexChanging="gvPressReleases_PageIndexChanging" AutoGenerateColumns="False" Width="100%" OnPreRender="gvPressReleases_PreRender" OnRowDeleting="gvPressReleases_RowDeleting">
        <Columns>

            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
            <asp:BoundField HeaderText ="Date" DataField="PressRlsDate" />
            <asp:BoundField HeaderText="Press Release Header" DataField="Header" />
            <asp:TemplateField HeaderText="Press Release Image">
                <ItemTemplate>
                    <asp:Image ID="imgSlider" Width="150px" runat="server" ImageUrl='<%# Convert.ToString(Eval("ImagePath")) %>' />
                </ItemTemplate>
            </asp:TemplateField>  
             <asp:TemplateField HeaderText="Tools">
                <ItemTemplate>
                    <div class="form-group">
                    <asp:LinkButton PostBackUrl='<%# "../admin/PressReleaseEditor.aspx?ID=" + Eval("ID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandName="EditTemplate">
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

        </div>
            </div>
        </div>
    </section>
</div>
</asp:Content>
