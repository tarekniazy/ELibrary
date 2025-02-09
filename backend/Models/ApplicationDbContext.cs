using Microsoft.EntityFrameworkCore;

namespace ELibrary.Models
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        { }

        public DbSet<Book> Books { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // Configure relationships
            builder.Entity<Book>()
                .HasOne<ApplicationUser>()
                .WithMany(u => u.Books)
                .HasForeignKey("UserId")
                .IsRequired();
        }
    }
}
