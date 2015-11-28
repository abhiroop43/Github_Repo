using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FutureAviator.Utlitity;
using ExceptionLogger;
using DataAccess;
using BusinessDTO;


namespace FutureAviator.UserControls
{
    public partial class DisplayContentBox : System.Web.UI.UserControl
    {
        #region Public Properties
        public BusinessDTO.ImageContentBoxType ContentBoxType { get; set; }
        #endregion

        #region Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData((int)ContentBoxType);
                if (ContentBoxType == BusinessDTO.ImageContentBoxType.NationalCarrers)
                {
                    contentBoxWithLink.Attributes.Add("class", "col-lg-10 col-lg-offset-1");
                }
                else if (ContentBoxType == BusinessDTO.ImageContentBoxType.Carrers)
                {
                    CarrersBlock.Attributes.Add("class", "col-lg-offset-2");
                }

                if(FutureAviator.Utlitity.Helper.IsMobileDevice())
                {
                    pnlCareerBox.Visible = false;
                }
                else
                {
                    pnlCareerBox.Visible = true;
                }
            }
        }
        #endregion
        #region Methods
        private void BindData(int ImageBoxContentType)
        {
            try
            {
                using (DAL_ImageBoxContent dalContentBox = new DAL_ImageBoxContent())
                {
                    List<ImageContentBoxResult> result = dalContentBox.GetAllImageContentBoxesByTypeID(ImageBoxContentType, SessionManager.CurrentUser().LanguageCode);
                    if (result != null && result.Count > 0)
                    {
                        if (ImageBoxContentType == (int)BusinessDTO.ImageContentBoxType.Carrers)
                        {
                            rptBox.DataSource = result;
                            rptBox.DataBind();

                            rptBoxDetails.DataSource = result;
                            rptBoxDetails.DataBind();

                            pnlContentBoxWithDetails.Visible = true;
                            contentBoxWithLink.Visible = false;
                        }
                        else
                        {
                            rptContentLinked.DataSource = result;
                            rptContentLinked.DataBind();
                            pnlContentBoxWithDetails.Visible = false;
                            contentBoxWithLink.Visible = true;
                        }

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