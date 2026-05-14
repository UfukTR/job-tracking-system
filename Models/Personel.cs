using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobTrackingSystem.Models
{
    [Table("Personeller")]
    public class Personel
    {
        [Key]
        public int PersonelId { get; set; }

        [StringLength(50)]
        public string PersonelAdSoyad { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Kullanıcı adı zorunludur")]
        public string PersonelKullaniciAd { get; set; }

        [StringLength(50)]
        [Required(ErrorMessage = "Parola zorunludur")]
        public string PersonelParola { get; set; }

        public int? PersonelBirimId { get; set; }

        public int? PersonelYetkiTurId { get; set; }

        // Navigation properties
        [ForeignKey("PersonelBirimId")]
        public virtual Birim Birim { get; set; }

        [ForeignKey("PersonelYetkiTurId")]
        public virtual YetkiTur YetkiTur { get; set; }

        public virtual ICollection<Is> Isler { get; set; }

        public Personel()
        {
            Isler = new List<Is>();
        }
    }
}
