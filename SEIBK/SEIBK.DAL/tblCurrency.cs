//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SEIBK.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblCurrency
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblCurrency()
        {
            this.tblAccounts = new HashSet<tblAccount>();
        }
    
        public int ID { get; set; }
        public string ISOCurrencyCode { get; set; }
        public string CurrencyName { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblAccount> tblAccounts { get; set; }
    }
}
