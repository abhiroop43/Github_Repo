using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using FutureAviator.Utlitity;
using ExceptionLogger;
using BusinessDTO;

namespace FutureAviator.UserControls
{
    public partial class Admin_AllImageContentBoxes : System.Web.UI.UserControl
    {
        #region Public Properties
        public string MainTitle { get; set; }
        public string UpdatePageURL { get; set; }
        public BusinessDTO.ImageContentBoxType ImageContentBoxType { get; set; }
        public BoxContentType BoxType { get; set; }
        #endregion
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
                hdnUpdatePageURL.Value = UpdatePageURL;
                hdnContextBoxTypeID.Value = Convert.ToString((int)ImageContentBoxType);
                ViewState["BoxType"] = BoxType;
                lnkAddNew.HRef = "../Admin/"+hdnUpdatePageURL.Value;
                lblMainTitle.Text = MainTitle;
                Session["AllPageURL"] = Request.RawUrl.Split('?')[0];
                BindData();
            }
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRecord")
            {
                Response.Redirect(hdnUpdatePageURL.Value + "?id=" + e.CommandArgument + "&type=" + hdnContextBoxTypeID.Value, false);
               
            }
            else if (e.CommandName == "DeleteItem")
            {
                string[] param = e.CommandArgument.ToString().Split('~');
                int ImageContentBoxID = Convert.ToInt32(param[0]);
                string ImageName = Convert.ToString(param[1]);
                if (Helper.DeleteFile(FileUploadType.ContentBoxImage, ImageName))
                {
                    using (DAL_ImageBoxContent dalImageContent = new DAL_ImageBoxContent())
                    {
                        if (dalImageContent.DeleteImageContentBox(ImageContentBoxID))
                        {
                            BindData();
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
        #endregion
        #region Methods
        private void BindData()
        {
            try
            {
                using (DAL_ImageBoxContent dalImageContextBox = new DAL_ImageBoxContent())
                {
                    List<ImageContentBoxResult> result = dalImageContextBox.GetAllImageContentBoxesByTypeID(Convert.ToInt32(hdnContextBoxTypeID.Value), ApplicationLanguages.en);
                    if (result != null && result.Count > 0)
                    {
                        gv.DataSource = result;
                        gv.DataBind();
                    }
                    else
                    {
                        Helper.ShowNotification("Record not found!", UINotificationType.Notify);
                    }
                }

                if ((BusinessDTO.BoxContentType)ViewState["BoxType"] == BoxContentType.Detail)
                {
                    gv.Columns[1].Visible = false;
                    gv.Columns[2].Visible = true;
                }
                else
                {
                    gv.Columns[1].Visible = true;
                    gv.Columns[2].Visible = false;
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