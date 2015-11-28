using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;
using System.Configuration;
using System.Data;

namespace FutureAviator.Admin
{
    public partial class ListCMSContents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    BindGrid();
                }
            }
            catch (Exception ex)
            {
               Helper.ShowNotification("Error occurred. Please check the log for details.", BusinessDTO.UINotificationType.Error);
               ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }

        private void BindGrid()
        {
            using (DAL_CMS objCMS = new DAL_CMS())
            {
                DataTable dtSectionTypes = new DataTable();
                dtSectionTypes.Columns.Add("ID", typeof(int));
                dtSectionTypes.Columns.Add("SectionTypeName", typeof(string));
                dtSectionTypes.Columns.Add("CreatedOn");
                IQueryable<DataAccess.CMSSectionType> sectionTypes = objCMS.Database.CMSSectionTypes;
                foreach (DataAccess.CMSSectionType cmstype in sectionTypes)
                {
                    DataRow drSectionType = dtSectionTypes.NewRow();
                    drSectionType["ID"] = cmstype.ID;
                    drSectionType["SectionTypeName"] = cmstype.SectionType;
                    drSectionType["CreatedOn"] = cmstype.CreateDate.Value.ToString("MM/dd/yyyy");
                    dtSectionTypes.Rows.Add(drSectionType);
                }
                gvCMS.DataSource = dtSectionTypes;
                gvCMS.DataBind();
            }
        }

        protected void gvCustomerStories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvCMS.PageIndex = e.NewPageIndex;
                BindGrid();
            }
            catch (Exception ex)
            {
                //lblErrDesc.Text = "An error occurred. Please check the log for more details.";
                Helper.ShowNotification("An error occurred. Please check the log for more details.", BusinessDTO.UINotificationType.Error);
                Logger.WriteErrorLog(ex);
            }
        }

        protected void gvCMS_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gvCMS.Rows.Count > 0)
                {
                    gvCMS.UseAccessibleHeader = true;
                    gvCMS.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gvCMS.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
            
        }
    }
}