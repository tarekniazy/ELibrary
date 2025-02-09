using Microsoft.AspNetCore.Identity;

namespace ELibrary.Models
{
    // Models/ApplicationUser.cs
    public class ApplicationUser : IdentityUser
    {
        public ICollection<Book> Books { get; set; } = new List<Book>();
    }
}
