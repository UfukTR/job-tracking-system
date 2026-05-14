using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobTrackingSystem.Models
{
    [Table("Birimler")]
    public class Birim
    {
        [Key]
        public int BirimId { get; set; }

        [StringLength(50)]
        public string BirimAd { get; set; }

        // Navigation property
        public virtual ICollection<Personel> Personeller { get; set; }

        public Birim()
        {
            Personeller = new List<Personel>();
        }
    }
}
