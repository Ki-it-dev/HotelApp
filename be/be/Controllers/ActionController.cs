using BCrypt.Net;
using be.Helpers;
using be.Models;
using be.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Xml.Linq;

namespace be.Controllers
{
    [ApiController]
    [Route("api")]

    public class ActionController : ControllerBase
    {
        private readonly DbFourSeasonHotelContext DateBase;
        private readonly IConfiguration Configuration;
        private readonly IUserService UserService;

        public ActionController(DbFourSeasonHotelContext db, IConfiguration configuration, IUserService userService)
        {
            this.DateBase = db;
            this.Configuration = configuration;
            this.UserService = userService;
        }
        [HttpPost("login")]
        public ActionResult Login([FromBody] Login login)
        {
            try
            {
                var result = UserService.Login(login.Email, login.Password, Configuration);
                return Ok(result);
            }
            catch
            {
                return BadRequest();
            }
        }
        [HttpPost("register")]
        public async Task<ActionResult> Register([FromBody]User user)
        {
            try
            {
                var result = await UserService.Register(user);
                return Ok(result);
            }
            catch
            {
                return BadRequest();
            }
        }
        [HttpGet("confirm")]
        public async Task<ActionResult> ConfirmAccount(int id)
        {
            try
            {
                var _user = await DateBase.Users.FindAsync(id);
                if (_user == null)
                {
                    return NotFound();
                }
                _user.Status = "1";
                DateBase.Entry(await DateBase.Users.FirstOrDefaultAsync(x => x.UserId == id)).CurrentValues.SetValues(_user);
                await DateBase.SaveChangesAsync();
                return Ok(new
                {
                    status = 200,
                    message = "Confirm success"
                });
            }
            catch
            {
                return BadRequest();
            }
        }
    }

    public class Login
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
