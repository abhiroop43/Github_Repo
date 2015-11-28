using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;
using FutureAviator.Utlitity;
using ExceptionLogger;

namespace FutureAviator.UserControls
{
    public partial class Admin_AllSlides : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["MessageType"] != null)
                {
                    if (Convert.ToString(Request.QueryString["MessageType"]).Trim().ToLower() == "successupdate")
                    {
                        Helper.ShowNotification("Update Successfully", UINotificationType.Success);
                    }
                }
                BindGrid();
            }
        }

        protected void gv_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (gv.Rows.Count > 0)
                {
                    gv.UseAccessibleHeader = true;
                    gv.HeaderRow.TableSection = TableRowSection.TableHeader;
                    gv.FooterRow.TableSection = TableRowSection.TableFooter;
                }
            }
            catch (Exception)
            {


            }
        }
        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                
                string[] param = e.CommandArgument.ToString().Split('~');
                long SlideID = Convert.ToInt64(param[0]);
                string ImageName = Convert.ToString(param[1]);
                if (Helper.DeleteFile(FileUploadType.HomeSliderImage, ImageName))
                {
                    using (DAL_HomeSlider dalHomeSlider = new DAL_HomeSlider())
                    {
                        if (dalHomeSlider.DeleteHomeSlideByID(SlideID))
                        {
                            BindGrid();
                            Helper.ShowNotification("Item deleted successfully.", UINotificationType.Success);
                        }
                           
                        else
                            Helper.ShowNotification("Error while deletion in database.", UINotificationType.Error);
                    }
                }
                else
                {
                    Helper.ShowNotification("Error while deletion image.", UINotificationType.Error);
                }
            }
        }
        #endregion
        #region Methods
        private void BindGrid()
        {
            try
            {
                using (DAL_HomeSlider dalHomeSlider = new DAL_HomeSlider())
                {
                    List<SliderResult> listSlides = dalHomeSlider.GetAllHomeSlides();
                    if (listSlides != null && listSlides.Count > 0)
                    {
                        gv.DataSource = listSlides;
                        gv.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }
        #endregion


    }
}