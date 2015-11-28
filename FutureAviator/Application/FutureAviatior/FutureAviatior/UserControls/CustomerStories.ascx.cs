using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using ExceptionLogger;
using DataAccess;
using FutureAviator.Utlitity;
using BusinessDTO;

namespace FutureAviator.UserControls
{
    public partial class CustomerStories : System.Web.UI.UserControl
    {
        protected DataTable dtStories = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!this.IsPostBack)
                {
                    DAL_CustomerStory objCust = new DAL_CustomerStory();
                    List<CustStoryResult> stories;
                    if(SessionManager.CurrentUser()!=null)
                        stories = objCust.GetAllStories(SessionManager.CurrentUser().LanguageCode);
                    else
                        stories = objCust.GetAllStories(BusinessDTO.ApplicationLanguages.ar);
                    
                    rptCustImages.DataSource = stories;
                    rptCustImages.DataBind();

                    rptQuote.DataSource = stories;
                    rptQuote.DataBind();
                }
                
                    MainHeader.InnerText = (SessionManager.CurrentUser().LanguageCode == ApplicationLanguages.en ? GetGlobalResourceObject("English","ShareYourStory").ToString(): GetGlobalResourceObject("Arabic","ShareYourStory").ToString() );//ShareYourStory "SHARE YOUR STORY";
                
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex);
            }            
        }


        
       
    }
}