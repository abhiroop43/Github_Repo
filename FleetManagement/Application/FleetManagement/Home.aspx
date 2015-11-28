<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" Runat="Server">
    <script src="assets/javascripts/biscripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" Runat="Server">
    
       <telerik:RadScriptManager runat="server" ID="RadScriptManager1"/>
    
            <telerik:RadAjaxLoadingPanel ID="LoadingPanel1" Width="256px" Height="64px" runat="server">
            <asp:Label ID="lblLoading" runat="server" ForeColor="Red">Loading... </asp:Label>
        </telerik:RadAjaxLoadingPanel>
    
    <div class="demo-container size-wide">

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1" LoadingPanelID="LoadingPanel1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="Refresh">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadHtmlChart1" LoadingPanelID="LoadingPanel1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                
                 <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="PieChart1" LoadingPanelID="LoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="Refresh">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="PieChart1" LoadingPanelID="LoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>

        

        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function getAjaxManager() {
                    //alert("test1");
                    return window.$find("<%= RadAjaxManager1.ClientID %>");
                }

                function getPieChart1() {
                    //alert("test2");
                    return window.$find("<%= PieChart1.ClientID %>");
                }
            </script>
        </telerik:RadCodeBlock>
        </div>
    
    <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="LoadingPanel1" Width="100%">
        <%--BAR CHART--%>
                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server"
                              OnClientSeriesClicked="OnClientSeriesClicked" Width="100%">
            <ChartTitle Text="Revenue Bar Chart">
            </ChartTitle>
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries DataFieldY="Rev" Name="Years">
                        <TooltipsAppearance Color="White"/>
                    </telerik:ColumnSeries>
                </Series>
                <XAxis DataLabelsField="Year">
                </XAxis>
            </PlotArea>
        </telerik:RadHtmlChart>
        
        <%--PIE CHART--%>

    <div style="float: left">
        <telerik:RadHtmlChart runat="server" ID="PieChart1" Width="800" Height="500" Transitions="true" OnClientSeriesClicked="OnClientSeriesClicked" OnClientSeriesHovered="OnClientSeriesHovered">
            <ChartTitle Text="Revenue Pie Chart">
                <Appearance Align="Center" Position="Top">
                </Appearance>
            </ChartTitle>
            <Legend>
                <Appearance Position="Right" Visible="true">
                </Appearance>
            </Legend>
            <PlotArea>
                <Series>
                    <telerik:PieSeries StartAngle="90" DataFieldY="Rev" NameField="Year">
                        <LabelsAppearance Position="OutsideEnd" DataFormatString="{0}">
                        </LabelsAppearance>
                        <TooltipsAppearance Color="White" DataFormatString="{0}"></TooltipsAppearance>
                    </telerik:PieSeries>
                </Series>
            </PlotArea>
        </telerik:RadHtmlChart>
        </div>

        <%--GRID--%>
<%--        <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" LoadingPanelID="LoadingPanel1" Width="100%">--%>
        <div style="float: left">
                        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False"
                    OnPreRender="RadGrid1_PreRender" OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                    Width="400px" Height="100%" GridLines="None" AllowMultiRowSelection="false"
                    PageSize="10" AllowPaging="true" OnPageIndexChanged="RadGrid1_OnPageIndexChanged" AllowFilteringByColumn="True" OnNeedDataSource="RadGrid1_OnNeedDataSource" PagerStyle-AlwaysVisible="true">
                            
                    <MasterTableView Height="100%" DataKeyNames="CustomerID">
                        <Columns>
                            <telerik:GridBoundColumn DataField="CustomerID" UniqueName="CustomerID" HeaderText="Customer ID"
                                EmptyDataText="&amp;nbsp;" Visible="False">
                                    <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="CustomerName" UniqueName="CustomerName" HeaderText="Customer Name"
                                EmptyDataText="&amp;nbsp;" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                                    <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="Revenue" UniqueName="Revenue" HeaderText="Revenue"
                                EmptyDataText="&amp;nbsp;" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="OrderYear" UniqueName="OrderYear" HeaderText="Order Year"
                                EmptyDataText="&amp;nbsp;" HeaderStyle-HorizontalAlign="Center"  FilterControlWidth="50px" AutoPostBackOnFilter="true">
                                <ItemStyle HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>

                        </Columns>
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                    </MasterTableView>
                    <FilterMenu EnableTheming="True">
                        <CollapseAnimation Duration="200" Type="OutQuint"></CollapseAnimation>
                    </FilterMenu>
                    <ClientSettings EnablePostBackOnRowClick="true">
                        <Selecting AllowRowSelect="true"></Selecting>
                    </ClientSettings>
                    <PagerStyle Mode="NumericPages"></PagerStyle>
                    <HeaderStyle Height="52px"></HeaderStyle>
                </telerik:RadGrid>

    </div>
             </telerik:RadAjaxPanel>
</asp:Content>

