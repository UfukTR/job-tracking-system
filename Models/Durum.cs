using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobTrackingSystem.Models
{
    [Table("Durumlar")]
    public class Durum
    {
        [Key]
        public int DurumId { get; set; }

        [StringLength(50)]
        public string DurumAd { get; set; }

        // Navigation property
        public virtual ICollection<Is> Isler { get; set; }

        public Durum()
        {
            Isler = new List<Is>();
        }
    }
}
