using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobTrackingSystem.Models
{
    [Table("Isler")]
    public class Is
    {
        [Key]
        public int IsId { get; set; }

        public string IsBaslik { get; set; }

        public string IsAciklama { get; set; }

        public int? IsPersonelId { get; set; }

        public DateTime? IletilenTarih { get; set; }

        public DateTime? YapilanTarih { get; set; }

        public int? IsDurumId { get; set; }

        // Navigation properties
        [ForeignKey("IsPersonelId")]
        public virtual Personel Personel { get; set; }

        [ForeignKey("IsDurumId")]
        public virtual Durum Durum { get; set; }
    }
}
