using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessDTO
{
    public class DynamicDTO: Westwind.Utilities.Dynamic.Expando
    {
        public long Key { get; set; }
        public string Value { get; set; }
        public DynamicDTO() : base()
        {

        }
        public DynamicDTO(object instance) : base(instance)
        {

        }
    }
}

