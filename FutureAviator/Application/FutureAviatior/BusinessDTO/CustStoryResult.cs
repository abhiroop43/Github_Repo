using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class CustStoryResult
    {
        public int StoryID { get; set; }
        public byte[] CustPicture { get; set; }
        public string CustName { get; set; }
        public string Designation { get; set; }
        public string StoryContent { get; set; }
        public string Status { get; set; }

    }
}
