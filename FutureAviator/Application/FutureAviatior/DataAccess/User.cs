//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataAccess
{
    using System;
    using System.Collections.Generic;
    
    public partial class User
    {
        public User()
        {
            this.EventAttendances = new HashSet<EventAttendance>();
            this.Industries = new HashSet<Industry>();
            this.Industries1 = new HashSet<Industry>();
            this.JobResponses = new HashSet<JobRespons>();
            this.Jobs = new HashSet<Job>();
            this.Jobs1 = new HashSet<Job>();
            this.ImageContentBoxes = new HashSet<ImageContentBox>();
        }
    
        public long UserID { get; set; }
        public int UserTypeID { get; set; }
        public string DisplayName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public bool IsActive { get; set; }
        public System.DateTime CreateDate { get; set; }
        public Nullable<System.DateTime> UpdateDate { get; set; }
        public Nullable<long> UpdateBy { get; set; }
        public string Picture { get; set; }
    
        public virtual ICollection<EventAttendance> EventAttendances { get; set; }
        public virtual ICollection<Industry> Industries { get; set; }
        public virtual ICollection<Industry> Industries1 { get; set; }
        public virtual ICollection<JobRespons> JobResponses { get; set; }
        public virtual ICollection<Job> Jobs { get; set; }
        public virtual ICollection<Job> Jobs1 { get; set; }
        public virtual UserType UserType { get; set; }
        public virtual ICollection<ImageContentBox> ImageContentBoxes { get; set; }
    }
}
