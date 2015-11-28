using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using Google.GData.Client;
using Google.YouTube;

namespace DemoYouTube
{
    public class YouTubeVideoObject
    {
        public string VideoId { get; set; }
        public string Title { get; set; }        
    }
        
    public class YouTubeVideoHelper
    {
        //const string YOUTUBE_CHANNEL = "UCNtaDbQvj2i-6KN1araC3Hg";
        //const string YOUTUBE_DEVELOPER_KEY = "AI39si4LWmfkdGQ7ld_-gytsybSJTDOlBW8ZTTbpq7Up22AWRAp1ChppuOM4vSjMIhQkHHWKgg8wyMh6CrbYD554pKKOxLtOQA";
        
        public static YouTubeVideoObject[] GetVideos()
        {
            YouTubeRequestSettings settings = new YouTubeRequestSettings("test Channel", ConfigurationManager.AppSettings["GoogleDevKey"]);
            YouTubeRequest request = new YouTubeRequest(settings);

            //Sample UrL:https://www.youtube.com/feeds/videos.xml?channel_id=UCNtaDbQvj2i-6KN1araC3Hg

            string feedUrl = String.Format("https://www.youtube.com/feeds/videos.xml?channel_id={0}", ConfigurationManager.AppSettings["ChannelID"]);
            Feed<Video> videoFeed = request.Get<Video>(new Uri(feedUrl));

            //"yt:video:qvHFpa5wK5g"

            return (from video in videoFeed.Entries
                     select new YouTubeVideoObject() {VideoId = video.Id.Substring(video.Id.LastIndexOf(":")+1), Title = video.Title}).ToArray();                        
        }
    }
}