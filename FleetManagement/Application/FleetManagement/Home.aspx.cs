using System;
using System.Data;
using System.Globalization;
using System.Security.Principal;
using Telerik.Web.UI;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
            using (DbHelper helper = new DbHelper())
            {
                DataTable dtOutput = helper.GetYearlyRevenue();
                RadHtmlChart1.DataSource = dtOutput;
                RadHtmlChart1.DataBind();

                PieChart1.PlotArea.Series[0].Items.Clear();

                for (int i = 0; i < dtOutput.Rows.Count; i++)
                {
                    PieChart1.PlotArea.Series[0].Items.Add(new SeriesItem(decimal.Parse(dtOutput.Rows[i]["Year"].ToString()), decimal.Parse(dtOutput.Rows[i]["Rev"].ToString())));
                    PieChart1.PlotArea.Series[0].Items[i].Name = dtOutput.Rows[i]["Year"].ToString();
                }
            }
        }
    }

    public int Year
    {
        get
        {
            if (ViewState["Year"] == null)
            {
                return DateTime.Now.Year;
            }
            return (int)ViewState["Year"];
        }
        set
        {
            ViewState["Year"] = value;
        }
    }

    protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        string seriesName = RadHtmlChart1.PlotArea.Series[0].Name;
        int selectedCustomerId = 0;
        if (ViewState["CustomerID"] != null)
        {
            selectedCustomerId = Convert.ToInt32(ViewState["CustomerID"]);
        }
        if (seriesName == "Years")
        {
            Year = int.Parse(e.Argument);

            DataTable dtOutput;
            using (DbHelper helper = new DbHelper())
            {
                //dtOutput = helper.GetQuarterlyRevenue(Year);
                dtOutput = selectedCustomerId == 0
                    ? helper.GetQuarterlyRevenue(Year)
                    : helper.GetQuarterlyRevenue(Year, selectedCustomerId);
                RadHtmlChart1.DataSource = dtOutput;
                RadHtmlChart1.DataBind();
            }

            RadHtmlChart1.PlotArea.XAxis.DataLabelsField = "Quarter";
            RadHtmlChart1.PlotArea.Series[0].DataFieldY = "Rev";
            RadHtmlChart1.PlotArea.Series[0].Name = "Quarters";

            PieChart1.PlotArea.Series[0].Name = "Quarters";

            PieChart1.PlotArea.Series[0].Items.Clear();

            for (int i = 0; i < dtOutput.Rows.Count; i++)
            {
                PieChart1.PlotArea.Series[0].Items.Add(new SeriesItem(decimal.Parse(dtOutput.Rows[i]["Quarter"].ToString()), decimal.Parse(dtOutput.Rows[i]["Rev"].ToString())));
                PieChart1.PlotArea.Series[0].Items[i].Name = dtOutput.Rows[i]["Quarter"].ToString();
            }

        }
        else
        {
            if (seriesName == "Quarters")
            {
                int quarter = int.Parse(e.Argument);

                DataTable dtOutput;
                using (DbHelper helper = new DbHelper())
                {
                    //dtOutput = helper.GetMonthlyRevenue(Year, quarter);
                    dtOutput = selectedCustomerId == 0
                        ? helper.GetMonthlyRevenue(Year, quarter)
                        : helper.GetMonthlyRevenue(Year, quarter, selectedCustomerId);
                    RadHtmlChart1.DataSource = dtOutput;
                    RadHtmlChart1.DataBind();
                }

                RadHtmlChart1.PlotArea.XAxis.DataLabelsField = "Month";
                RadHtmlChart1.PlotArea.Series[0].DataFieldY = "Rev";
                RadHtmlChart1.PlotArea.Series[0].Name = "Months";

                PieChart1.PlotArea.Series[0].Name = "Months";
                PieChart1.PlotArea.Series[0].Items.Clear();

                for (int i = 0; i < dtOutput.Rows.Count; i++)
                {
                    PieChart1.PlotArea.Series[0].Items.Add(new SeriesItem(DateTime.ParseExact(dtOutput.Rows[i]["Month"].ToString(), "MMMM", CultureInfo.InvariantCulture).Month, decimal.Parse(dtOutput.Rows[i]["Rev"].ToString())));
                    PieChart1.PlotArea.Series[0].Items[i].Name = dtOutput.Rows[i]["Month"].ToString();
                }
            }
        }
    }


    private void BindGrid()
    {
        using (DbHelper helper = new DbHelper())
        {
            RadGrid1.DataSource = helper.GetCustomerOrders();
            RadGrid1.DataBind();
        }
    }
    protected void RadGrid1_PreRender(object sender, EventArgs e)
    {

    }
    protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int selectedCustomerId = 0;
        foreach (GridDataItem item in RadGrid1.SelectedItems)
        {
            selectedCustomerId = Convert.ToInt32(item.GetDataKeyValue("CustomerID"));
        }
        //int selectedCustomerId = Convert.ToInt32(RadGrid1.SelectedItems[0].GetDataKeyValue("CustomerID"));
        if (ViewState["CustomerID"] != null && selectedCustomerId == Convert.ToInt32(ViewState["CustomerID"]))
        {
            return; //prevent execution while filtering from quarter//
        }
        ViewState["CustomerID"] = selectedCustomerId;
        using (DbHelper helper = new DbHelper())
        {
            DataTable dtOutput = helper.GetYearlyRevenue(selectedCustomerId);
            RadHtmlChart1.DataSource = dtOutput;
            RadHtmlChart1.DataBind();

            PieChart1.PlotArea.Series[0].Items.Clear();

            for (int i = 0; i < dtOutput.Rows.Count; i++)
            {
                PieChart1.PlotArea.Series[0].Items.Add(new SeriesItem(decimal.Parse(dtOutput.Rows[i]["Year"].ToString()), decimal.Parse(dtOutput.Rows[i]["Rev"].ToString())));
                PieChart1.PlotArea.Series[0].Items[i].Name = dtOutput.Rows[i]["Year"].ToString();
            }


            RadHtmlChart1.PlotArea.XAxis.DataLabelsField = "Year";
            RadHtmlChart1.PlotArea.Series[0].DataFieldY = "Rev";
            RadHtmlChart1.PlotArea.Series[0].Name = "Years";

            PieChart1.PlotArea.Series[0].Name = "Years";
        }

    }

    protected void RadGrid1_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        RadGrid1.CurrentPageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void RadGrid1_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        using (DbHelper helper = new DbHelper())
        {
            RadGrid1.DataSource = helper.GetCustomerOrders();
        }
    }
}