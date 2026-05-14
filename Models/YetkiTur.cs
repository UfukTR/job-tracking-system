using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobTrackingSystem.Models
{
    [Table("YetkiTurler")]
    public class YetkiTur
    {
        [Key]
        public int YetkiTurId { get; set; }

        [StringLength(50)]
        public string YetkiTurAd { get; set; }

        // Navigation property
        public virtual ICollection<Personel> Personeller { get; set; }

        public YetkiTur()
        {
            Personeller = new List<Personel>();
        }
    }
}
