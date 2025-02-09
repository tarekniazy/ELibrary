using ELibrary.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

[ApiController]
[Route("api/[controller]")]
public class AuthController : ControllerBase
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly SignInManager<ApplicationUser> _signInManager;
    private readonly IConfiguration _configuration;

    public AuthController(
        UserManager<ApplicationUser> userManager,
        SignInManager<ApplicationUser> signInManager,
        IConfiguration configuration)
    {
        _userManager = userManager;
        _signInManager = signInManager;
        _configuration = configuration;
    }

    [HttpPost("register")]
    [EnableCors("AllowFlutterApp")] // Apply CORS policy to specific endpoint
    public async Task<IActionResult> Register(RegisterModel model)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
        var result = await _userManager.CreateAsync(user, model.Password);

        if (result.Succeeded)
        {
            // Generate JWT token
            var token = await GenerateJwtToken(user);
            return Ok(new { UserId = user.Id, Email = user.Email, Token = token });
        }

        return BadRequest(result.Errors);
    }

    [HttpPost("login")]
    [EnableCors("AllowFlutterApp")] // Apply CORS policy to specific endpoint
    public async Task<IActionResult> Login(LoginModel model)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var user = await _userManager.FindByEmailAsync(model.Email);
        if (user == null)
            return BadRequest("Invalid credentials");

        var result = await _signInManager.CheckPasswordSignInAsync(user, model.Password, false);

        if (result.Succeeded)
        {
            // Generate JWT token
            var token = await GenerateJwtToken(user);
            return Ok(new { UserId=user.Id, Email = user.Email,Token = token });
        }

        return BadRequest("Invalid credentials");
    }

    [HttpPost("logout")]
    [Authorize] // Add authorization requirement
    [EnableCors("AllowFlutterApp")]
    public async Task<IActionResult> Logout()
    {
        try
        {
            // Get the user's email from the JWT token claims
            var userEmail = User.FindFirst(ClaimTypes.NameIdentifier)?.Value
                ?? User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

            if (string.IsNullOrEmpty(userEmail))
            {
                return BadRequest(new { message = "User identifier not found in token" });
            }

            // Find user by email
            var user = await _userManager.FindByEmailAsync(userEmail);
            if (user == null)
            {
                return NotFound(new { message = "User not found" });
            }

            // Perform the logout
            await _signInManager.SignOutAsync();

            // Update security stamp to invalidate all existing tokens
            await _userManager.UpdateSecurityStampAsync(user);

            return Ok(new { message = "Logged out successfully" });
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { message = "Invalid logout operation", error = ex.Message });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new
            {
                message = "An unexpected error occurred during logout",
                error = ex.Message,
                requestId = HttpContext.TraceIdentifier
            });
        }
    }
    private Task<string> GenerateJwtToken(ApplicationUser user)
    {
        var claims = new List<Claim>
        {
            new Claim(JwtRegisteredClaimNames.Sub, user.Email),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id)
        };

        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtKey"]));
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expires = DateTime.Now.AddDays(7);

        var token = new JwtSecurityToken(
            _configuration["JwtIssuer"],
            _configuration["JwtIssuer"],
            claims,
            expires: expires,
            signingCredentials: creds
        );

        return Task.FromResult(new JwtSecurityTokenHandler().WriteToken(token));
    }
}