using System.ComponentModel.DataAnnotations;

namespace ELibrary.Models
{
    public class Book
    {
        [Key]
        public int Id { get; set; }
        public required string UserId { get; set; }
        public required string Content { get; set; }
        public required string TextAnalysis { get; set; }
        public required string GutenbergId { get; set; }
        public required string Title { get; set; }
        public required string Language { get; set; }
        public DateTime DownloadDate { get; set; }
    }
}
