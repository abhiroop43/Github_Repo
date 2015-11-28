using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BusinessDTO
{
    public class BugLog
    {
        public string LogDate { get; set; }
        public string ExceptionURL { get; set; }
        public string ErrorMessage { get; set; }
        public string TraceStack { get; set; }
    }
}
