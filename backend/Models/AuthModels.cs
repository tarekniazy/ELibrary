using System.ComponentModel.DataAnnotations;

namespace ELibrary.Models
{
    public class LoginModel
    {
        [EmailAddress]
        public required string Email { get; set; }

        [DataType(DataType.Password)]
        public required string Password { get; set; }
    }

    public class RegisterModel
    {
        [EmailAddress]
        public required string Email { get; set; }

        [StringLength(100, MinimumLength = 6)]
        [DataType(DataType.Password)]
        public required string Password { get; set; }

        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Passwords don't match.")]
        public required string ConfirmPassword { get; set; }
    }
}
