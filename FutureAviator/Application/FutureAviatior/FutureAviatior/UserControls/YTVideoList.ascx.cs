using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DemoYouTube
{
    public partial class YTVideoList : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                VideosRepeater.DataSource = YouTubeVideoHelper.GetVideos();
                VideosRepeater.DataBind();
            }            
        }
    }
}