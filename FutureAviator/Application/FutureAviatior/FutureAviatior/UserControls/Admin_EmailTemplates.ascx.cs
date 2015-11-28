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
    public partial class Admin_EmailTemplates : System.Web.UI.UserControl
    {
        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
            try
            {
                if (e.CommandName == "EditTemplate")
                {
                    using (DAL_EmailTemplate dalEmailTemplate = new DAL_EmailTemplate())
                    {
                        EmailTemplate emailTemplate = dalEmailTemplate.GetTemplateByTemplateID(Convert.ToInt32(e.CommandArgument));
                        if (emailTemplate != null)
                        {
                            txtEmailSubject.Text = emailTemplate.EmailSubject;
                            txtEmailBodyTemplate.InnerHtml = emailTemplate.TemplateBody;
                            chkbxIsActive.Checked = emailTemplate.IsActive;
                            ViewState["TemplateID"] = e.CommandArgument;
                            ShowEditTemplateArea();
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ViewState["TemplateID"] != null)
                using (DAL_EmailTemplate dalEmailTemplate = new DAL_EmailTemplate())
                {
                    EmailTemplate emailTemplate = new EmailTemplate();
                    emailTemplate = Helper.AutoFill<EmailTemplate>(emailTemplate, DBMethod.Update);
                    emailTemplate.TemplateBody = txtEmailBodyTemplate.InnerHtml;
                    emailTemplate.IsActive = chkbxIsActive.Checked;
                    emailTemplate.EmailSubject = txtEmailSubject.Text;

                    if (dalEmailTemplate.UpdateTemplateByID(Convert.ToInt32(ViewState["TemplateID"]), emailTemplate))
                    {
                        //lblStatus.Text = "Template Update Successfully";
                        Helper.ShowNotification("Template Update Successfully", UINotificationType.Success);
                        ShowTemplateList();
                        Helper.ClearInputs(this.Page.Controls);
                    }
                }
            else
            {
                ShowTemplateList();
            }


        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ShowTemplateList();
        }
        #endregion
        #region Methods
        private void BindGrid()
        {
            try
            {
                using (DAL_EmailTemplate dalEmailTemplates = new DAL_EmailTemplate())
                {
                    List<EmailTemplate> listTemplates = dalEmailTemplates.GetAllTemplates();
                    if (listTemplates != null && listTemplates.Count > 0)
                    {
                        gv.DataSource = listTemplates;
                        gv.DataBind();
                    }
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }
        }
        private void ShowTemplateList()
        {
            templateList.Visible = true;
            editTemplate.Visible = false;
        }
        private void ShowEditTemplateArea()
        {
            templateList.Visible = false;
            editTemplate.Visible = true;
        }
        #endregion




    }
}