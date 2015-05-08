using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DDSInvertedIndex
{
    public partial class DisplayIndex : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if(!this.IsPostBack)
                {
                    BindGrid();
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        protected void gvInvertedIndex_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvInvertedIndex.PageIndex = e.NewPageIndex;
                BindGrid();
            }
            catch (Exception ex)
            {
                lblError.Text = "An error has occurred. Please contact the administrator.";
                Logger.LogException(ex, WindowsIdentity.GetCurrent().Name);
            }
        }

        private void BindGrid()
        {
            if (Session["dtInvIndex"] != null)
            {
                DataTable dtInvIndex = Session["dtInvIndex"] as DataTable;
                //replace | with commas//
                foreach (DataRow drInvIndex in dtInvIndex.Rows)
                {
                    drInvIndex["Postings"] = drInvIndex["Postings"].ToString().Replace(")|(", "), (");
                }
                DataView dv = dtInvIndex.DefaultView;
                dv.Sort = "Word";
                gvInvertedIndex.DataSource = dv.ToTable();
                gvInvertedIndex.DataBind();
            }
        }
    }
}