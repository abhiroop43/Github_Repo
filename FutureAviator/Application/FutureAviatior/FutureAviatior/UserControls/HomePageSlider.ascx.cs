using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using BusinessDTO;
using FutureAviator.Utlitity;

namespace FutureAviator.UserControls
{
    public partial class HomePageSlider : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindSlider();
            }
        }
        private void BindSlider()
        {
            try
            {
                using(DAL_HomeSlider dalHomeSlider = new DAL_HomeSlider())
                {
                    List<SliderResult> sliderResult = dalHomeSlider.GetAllActiveHomeSlides(SessionManager.CurrentUser().LanguageCode);
                    if(sliderResult != null && sliderResult.Count > 0)
                    {
                        rptHomeSlider.DataSource = sliderResult;
                        rptHomeSlider.DataBind();
                        rptHomeSlider2.DataSource = sliderResult;
                        rptHomeSlider2.DataBind();
                    }
                  
                }
            }
            catch (Exception ex)
            {
                ExceptionLogger.Logger.WriteErrorLog(ex);
            }

        }
    }
}