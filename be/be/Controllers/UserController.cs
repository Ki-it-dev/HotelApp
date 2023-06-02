using be.Helpers;
using be.Models;
using be.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Text.Json;
using System.Text.RegularExpressions;
using System.Xml.Linq;

namespace be.Controllers
{
    [ApiController]
    [Route("api/user")]

    public class UserController : ControllerBase
    {
        private readonly IUserService UserService;
        private readonly DbFourSeasonHotelContext Db;
        public UserController(DbFourSeasonHotelContext db, IUserService userService)
        {
            this.Db = db;
            this.UserService = userService;
        }

        #region HIEUVMH15 - LOGIN/REGISTER/CREATE TOKEN
        [HttpGet("info")]
        public async Task<ActionResult> GetInfo(string token)
        {
            try
            {
                if(token == "")
                {
                    return BadRequest();
                }
                var result = await UserService.GetInfo(token);
                return Ok(result);
            }
            catch
            {
                return BadRequest();
            }
        }
        [HttpGet("search")]
        public async Task<ActionResult> GetUserByEmail(string email)
        {
            try
            {
                var result = await UserService.GetUserByEmail(email);
                return Ok(result);
            }
            catch
            {
                return BadRequest();
            }
        }
        [HttpPost("forgot")]
        public async Task<ActionResult> ForgotPassword([FromBody] string email)
        {
            try
            {
                var result = await UserService.ForgotPassword(email);
                return Ok(result);
            }
            catch
            {
                return BadRequest();
            }
        }
        #endregion

        #region KHUYENHTB - USER-INFORMATION/VIEW BOOKING HISTORY/CANCEL BOOKING
        [HttpGet("GetUserInformation")]
        public ActionResult GetUserInformation(int userId)
        {
            try
            {
                var user = UserService.GetUserInformation(userId);
                return Ok(user);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPut("UpdateUser")]
        public ActionResult UpdateUser([FromBody] UserUpdateInfor user)
        {
            try
            {
                var updateData = UserService.UpdateUser(user);
                return Ok(updateData);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        #endregion
    }
}
