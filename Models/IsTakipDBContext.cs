using System.Data.Entity;

namespace JobTrackingSystem.Models
{
    public class IsTakipDBContext : DbContext
    {
        public IsTakipDBContext() : base("IsTakipDBContext")
        {
        }

        public virtual DbSet<Birim> Birimler { get; set; }
        public virtual DbSet<Durum> Durumlar { get; set; }
        public virtual DbSet<YetkiTur> YetkiTurler { get; set; }
        public virtual DbSet<Personel> Personeller { get; set; }
        public virtual DbSet<Is> Isler { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Foreign key configurations
            modelBuilder.Entity<Personel>()
                .HasOptional(p => p.Birim)
                .WithMany(b => b.Personeller)
                .HasForeignKey(p => p.PersonelBirimId);

            modelBuilder.Entity<Personel>()
                .HasOptional(p => p.YetkiTur)
                .WithMany(y => y.Personeller)
                .HasForeignKey(p => p.PersonelYetkiTurId);

            modelBuilder.Entity<Is>()
                .HasOptional(i => i.Personel)
                .WithMany(p => p.Isler)
                .HasForeignKey(i => i.IsPersonelId);

            modelBuilder.Entity<Is>()
                .HasOptional(i => i.Durum)
                .WithMany(d => d.Isler)
                .HasForeignKey(i => i.IsDurumId);
        }
    }
}
