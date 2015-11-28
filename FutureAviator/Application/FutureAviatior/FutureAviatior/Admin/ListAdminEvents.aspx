<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/AdminMaster.Master" AutoEventWireup="true" CodeBehind="ListAdminEvents.aspx.cs" Inherits="FutureAviator.Admin.ListAdminEvents" %>
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
            <h2 class="title pull-left">Events</h2>
        </header>
        <div class="content-body">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-xs-12">


                   <div class="pull-right">
                        <p>
                            <a title="Add New Event" href="AddAdminEvents.aspx" class="btn btn-primary">
                                <span class="fa fa-plus"></span>
                            </a>
                        </p>
                    </div>


    <asp:GridView ID="gvAdminEvents" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="table table-striped dt-responsive display MyDataTable" OnRowDeleting="gvAdminEvents_RowDeleting" OnPreRender="gvAdminEvents_PreRender">
        <Columns>
            
            <asp:BoundField DataField="ID" HeaderText="Event ID"  ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
            <asp:BoundField DataField="EventName" HeaderText="Event Name" />
            <asp:BoundField DataField="EventFromDate" HeaderText="Start Date" />
            <asp:BoundField DataField="EventToDate" HeaderText="End Date" />
            <asp:BoundField DataField="Venue" HeaderText="Venue" />
            <asp:TemplateField HeaderText="Tools">
                <ItemTemplate>
                    <div class="form-group">
                    <asp:LinkButton PostBackUrl='<%# "../admin/AddAdminEvents.aspx?id=" + Eval("ID") %>' ID="lnkBtnEdit" CssClass="btn btn-primary" runat="server" CommandName="EditTemplate">
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
    <asp:Label ID="lblErrDesc" runat="server"></asp:Label><br /><br />
<%--    <a href="AddAdminEvents.aspx">Add New Admin Event</a>--%>
        </div>
            </div>
        </div>
    </section>
</div>
</asp:Content>
