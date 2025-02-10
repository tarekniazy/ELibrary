using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ELibrary.Models;
using Microsoft.AspNetCore.Identity;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using NuGet.Common;

namespace ELibrary.Controllers
{
    [Authorize]
    [ApiController]
    [Route("api/[controller]")]
    public class BooksController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public BooksController(
            ApplicationDbContext context,
            HttpClient httpClient,
            UserManager<ApplicationUser> userManager)
        {
            _context = context;
        }

        [HttpGet("{userId}")]
        public async Task<ActionResult<IEnumerable<Book>>> GetBooks(String userId)
        {
            return await _context.Books
                .Where(b => b.UserId == userId)
                .ToListAsync();
        }


        // PUT: api/Books/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Book>> PostBook(Book book)
        {
            // Get user ID from the JWT token
            var userEmail = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userEmail))
            {
                return Unauthorized();
            }

            // Assign the creation date book
            book.DownloadDate = DateTime.UtcNow;

            _context.Books.Add(book);
            await _context.SaveChangesAsync();

            return Ok();
        }

        // DELETE: api/Books/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteBook(int id)
        {
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized();
            }

            var book = await _context.Books
                .FirstOrDefaultAsync(b => b.Id == id && b.UserId == userId);

            if (book == null)
            {
                return NotFound();
            }

            // Verify the user owns the book
            if (book.UserId != userId)
            {
                return Forbid();
            }

            _context.Books.Remove(book);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
