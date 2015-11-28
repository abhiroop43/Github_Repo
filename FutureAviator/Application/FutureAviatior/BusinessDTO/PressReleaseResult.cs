using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class PressReleaseResult
    {
        public int ID { get; set; }
        public DateTime PressReleaseDate { get; set; }
        public string Header { get; set; }
        public string PressReleaseContent { get; set; }
        public string ImagePath { get; set; }
        public bool IsActive { get; set; }
        public DateTime CreateDate { get; set; }
        public long CreatedBy { get; set; }
        public DateTime UpdateDate { get; set; }
        public long UpdateBy { get; set; }
        public DateTime DeleteDate { get; set; }
        public long DeleteBy { get; set; }
    }
}
