using be.Models;
using be.Repositories.RoomRepository;
using Microsoft.EntityFrameworkCore;
using System.Dynamic;

namespace be.Repositories.BookingRepository
{
    public class BookingRepository : IBookingRepository
    {
        private readonly DbFourSeasonHotelContext _context;
        public IRoomRepository _roomRepository;

        public BookingRepository(IRoomRepository roomRepository)
        {
            _context = new DbFourSeasonHotelContext();
            _roomRepository = roomRepository;
        }

        public object AddBooking(Data data)
        {
            if (isBooking(data))
            {
                Data newData = new Data();
                newData.booking = new Booking();
                newData.listBooking = new List<BookingDetail> { new BookingDetail() };
                newData.booking.UserId = data.booking.User.UserId;
                newData.booking.CreateDate = DateTime.Now;
                newData.booking.UpdateDate = DateTime.Now;
                newData.booking.PriceDifference = 0;
                newData.booking.CheckIn = data.booking.CheckIn.AddDays(1);
                newData.booking.CheckOut = data.booking.CheckOut.AddDays(1);
                newData.booking.TotalPrice = data.booking.TotalPrice;
                newData.booking.Status = data.booking.Status;
                newData.listBooking = data.listBooking.ToList();
                _context.Bookings.Add(newData.booking);
                _context.SaveChanges();
                var _bookingId = _context.Bookings.OrderByDescending(X => X.BookingId).FirstOrDefault().BookingId;
                foreach (var item in newData.listBooking)
                {
                    item.BookingId = _bookingId;
                    _context.BookingDetails.Add(item);
                    _context.SaveChanges();
                }
                return new
                {
                    status = 200,
                    bookingId = newData.booking.BookingId,
                    message = "Booking success!",
                    createdDate = newData.booking.CreateDate,
                };
            }
            return new
            {
                status = 200,
                message = "Booking error!"
            };
        }

        public void ChangeStatus(int id, string status)
        {
            var updateBooking = _context.Bookings.SingleOrDefault(x => x.BookingId == id);
            updateBooking.Status = status;
            if (updateBooking.PriceDifference > 0)
            {
                var updateTotalPrice = updateBooking.TotalPrice + updateBooking.PriceDifference;
                updateBooking.TotalPrice = (decimal)updateTotalPrice;
                updateBooking.PriceDifference = 0;
            }
            else
            {
                var updateTotalPrice = updateBooking.TotalPrice - (updateBooking.PriceDifference * (-1));
                updateBooking.TotalPrice = (decimal)updateTotalPrice;
                updateBooking.PriceDifference = 0;
            }
            try
            {
                _context.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }
        }

        public void DeleteBooking(int bookingId)
        {
            var booking = _context.Bookings.Find(bookingId);
            booking.Status = "2";
            _context.SaveChanges();
        }

        public IList<BookingDetail> GetAllBookingDetail()
        {
            return _context.BookingDetails.ToList();
        }

        public IList<Booking> GetAllBookings()
        {
            return _context.Bookings.ToList();
        }

        public Booking GetBooking(int bookingId)
        {
            return _context.Bookings.Find(bookingId);
        }

        public IEnumerable<dynamic> GetBookingByConditions(int userId, string checkin, string checkout, string bookingDate)
        {
            var bookingHistories = (from bookings in _context.Bookings
                                    join users in _context.Users
                                    on bookings.UserId equals users.UserId
                                    join bookingDetails in _context.BookingDetails
                                    on bookings.BookingId equals bookingDetails.BookingId
                                    where bookings.UserId == userId
                                    select new
                                    {
                                        key = bookings.BookingId,
                                        userEmail = users.Email,
                                        phone = users.Phone,
                                        bookingDate = bookings.CreateDate.ToString("yyyy-MM-dd hh:mm tt"),
                                        checkIn = bookings.CheckIn.ToString("yyyy-MM-dd"),
                                        checkOut = bookings.CheckOut.ToString("yyyy-MM-dd"),
                                        totalPrice = CurrencyFormat(bookings.TotalPrice),
                                        status = bookings.Status,
                                        cancelAvailable = CancelAcceptable(bookings.CheckIn, bookings.Status),
                                        priceGap = bookings.PriceDifference,
                                        listRooms = _roomRepository.GetRoomsByBookingId(bookings.BookingId),
                                        totalPriceNotFormat = bookings.TotalPrice
                                    }).Distinct().OrderByDescending(x => x.key).ToList();
            if (!String.IsNullOrEmpty(bookingDate))
            {
                bookingHistories = (from bookings in bookingHistories
                                    where DateTime.Compare(DateTime.ParseExact(bookings.bookingDate, "dd-MM-yyyy hh:mm tt", null).Date, DateTime.Parse(bookingDate).Date) == 0
                                    select bookings).Distinct().OrderByDescending(x => x.key).ToList();
            }

            if (!String.IsNullOrEmpty(checkin) && !String.IsNullOrEmpty(checkout))
            {
                bookingHistories = (from bookings in bookingHistories
                                    where DateTime.Compare(DateTime.ParseExact(bookings.checkIn, "dd-MM-yyyy", null), DateTime.Parse(checkin)) >= 0
                                    && DateTime.Compare(DateTime.ParseExact(bookings.checkOut, "dd-MM-yyyy", null), DateTime.Parse(checkout)) <= 0
                                    select bookings).Distinct().OrderByDescending(x => x.key).ToList();
            }
            else
            {

                if (!String.IsNullOrEmpty(checkin))
                {
                    bookingHistories = (from bookings in bookingHistories
                                        where bookings.checkIn == DateTime.Parse(checkin).ToString("dd-MM-yyyy")
                                        select bookings).Distinct().OrderByDescending(x => x.key).ToList();
                }

                if (!String.IsNullOrEmpty(checkout))
                {
                    bookingHistories = (from bookings in bookingHistories
                                        where bookings.checkOut == DateTime.Parse(checkout).ToString("dd-MM-yyyy")
                                        select bookings).Distinct().OrderByDescending(x => x.key).ToList();
                }

            }
            return (IEnumerable<dynamic>)bookingHistories;
        }

        public dynamic GetBookingHistories(int userId)
        {
            dynamic bookingsInfo = new List<ExpandoObject>();

            //get all booking of user
            var bookingHistories = (from bookings in _context.Bookings
                                    join users in _context.Users
                                    on bookings.UserId equals users.UserId
                                    join bookingDetails in _context.BookingDetails
                                    on bookings.BookingId equals bookingDetails.BookingId
                                    where bookings.UserId == userId
                                    select new
                                    {
                                        key = bookings.BookingId,
                                        userEmail = users.Email,
                                        phone = users.Phone,
                                        bookingDate = bookings.CreateDate.ToString("yyyy-MM-dd hh:mm tt"),
                                        checkIn = bookings.CheckIn.ToString("yyyy-MM-dd"),
                                        checkOut = bookings.CheckOut.ToString("yyyy-MM-dd"),
                                        totalPrice = CurrencyFormat(bookings.TotalPrice),
                                        status = bookings.Status,
                                        cancelAvailable = CancelAcceptable(bookings.CheckIn, bookings.Status),
                                        priceGap = bookings.PriceDifference,
                                        listRooms = _roomRepository.GetRoomsByBookingId(bookings.BookingId),
                                        totalPriceNotFormat = bookings.TotalPrice
                                    }).Distinct().OrderByDescending(x => x.key).ToList();

            return bookingHistories;
        }        

        public bool isBooking(Data data)
        {
            var rooms = _context.Bookings.Where(x => DateTime.Compare(x.CheckIn, data.booking.CheckIn) == 0).ToList();
            foreach (var room in rooms)
            {
                foreach (var item in data.listBooking)
                {
                    if (room.BookingId == item.BookingId)
                    {
                        return false;
                    }
                }
            }
            return true;
        }

        public void UpdateBooking(Booking booking)
        {
            Booking updateBooking = _context.Bookings.Find(booking.BookingId);
            updateBooking = booking;
            _context.SaveChanges();
        }

        public void UpdateBooking(int id, DateTime checkIn, DateTime checkOut, string status, decimal totalPrice)
        {
            var updateBooking = _context.Bookings.SingleOrDefault(x => x.BookingId == id);
            //updateBooking.CheckIn = checkIn;
            //updateBooking.CheckOut = checkOut;
            updateBooking.Status = status;
            DateTime start = checkIn;
            DateTime end = checkOut;
            TimeSpan instance = end - start;
            var updatePrice = 0;
            var bookingDetail = _context.BookingDetails.Where(x => x.BookingId == id).ToList();
            var priceList = _roomRepository.GetAllRoom();
            foreach (var bd in bookingDetail)
            {
                foreach (var r in priceList)
                {
                    if (r.RoomId == bd.RoomId)
                    {
                        updatePrice += Convert.ToInt32(r.Price) * Convert.ToInt32(instance.TotalDays);
                    }
                }

            }
            if (totalPrice < updatePrice)
            {
                updateBooking.TotalPrice = totalPrice;
                updateBooking.PriceDifference = updatePrice - totalPrice;
            }
            else if (totalPrice > updatePrice)
            {
                updateBooking.TotalPrice = totalPrice;
                updateBooking.PriceDifference = updatePrice - totalPrice;
            }
            else
            {
                updateBooking.TotalPrice = totalPrice;
                updateBooking.PriceDifference = 0;
                updateBooking.Status = "1";
            }
            updateBooking.UpdateCheckIn = checkIn;
            updateBooking.UpdateCheckOut = checkOut;
            updateBooking.UpdateDate = DateTime.Now;
            try
            {
                _context.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                throw;
            }

        }

        /// <summary>
        /// Format currency with format like 100,000,000
        /// </summary>
        /// <param name="money"> number you want to format</param>
        /// <returns>currency string after format</returns>
        public static string CurrencyFormat(decimal money)
        {
            return String.Format("{0:0,0}", money);
        }

        /// <summary>
        /// Check cancel condition = cancel date must be at least 24 hours before checkin date (2 PM of checkin date)
        /// </summary>
        /// <param name="checkIn">Date guest checkin</param>
        /// <param name="status">Status of booking</param>
        /// <returns>true/false</returns>
        public static bool CancelAcceptable(DateTime checkIn, string status)
        {
            DateTime currentDateTime = DateTime.Now;
            DateTime checkInDateTime = checkIn.AddHours(14);
            double remainHoursBeforeCheckInDate = (checkInDateTime - currentDateTime).TotalHours;
            if (remainHoursBeforeCheckInDate > 24 && status != "2")
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// check user can pay or not = user can pay in 1 hours
        /// </summary>
        /// <param name="bookingDate"></param>
        /// <param name="status"></param>
        /// <returns></returns>
        public static bool PaymentAcceptable(DateTime bookingDate, string status)
        {
            DateTime currentDateTime = DateTime.Now;
            double remainHoursBeforeExpiredPayTime = (currentDateTime - bookingDate).TotalHours;
            if(remainHoursBeforeExpiredPayTime <= 1 && status == "0")
            {
                return true;
            }
            return false;
        }

        public IEnumerable<dynamic> GetCreatedBooking(int userId)
        {
            var get = (from b in _context.Bookings
                       where b.Status == "0" && b.UserId == userId
                       select new { StartTime = b.CreateDate, b.BookingId });

            return get.ToList();
        }

        public IEnumerable<dynamic> GetBookingDatesOfUser(int userId)
        {
            var get = (from b in _context.Bookings
                       where b.Status == "0" && b.UserId == userId
                       select new { b.UpdateDate, b.BookingId });

            return get.ToList();
        }

        public int GetLastBookingUser(int idBooking)
        {
            var getLastBooking = (from b in _context.Bookings
                                  join bd in _context.BookingDetails on b.BookingId equals bd.BookingId
                                  where b.BookingId == idBooking && b.Status == "0"
                                  select b.BookingId).FirstOrDefault();

            return getLastBooking;
        }
    }
}
