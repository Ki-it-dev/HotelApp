using be.Models;

namespace be.Services
{
    public interface IBookingService
    {
        IList<Booking> GetAllBookings();
        Booking GetBooking(int bookingId);
        void UpdateBooking(Booking booking);
        void DeleteBooking(int bookingId);
        IEnumerable<dynamic> GetBookingByConditions(int userId, string checkin, string checkout, string bookingDate);
        dynamic GetBookingHistories(int userId);
        IList<BookingDetail> GetAllBookingDetail();
        void ChangeStatus(int id, string status);
        void UpdateBooking(int id, DateTime checkIn, DateTime checkOut, string status, decimal totalPrice);
        object AddBooking(Data data);
        bool isBooking(Data data);
        IEnumerable<dynamic> GetCreatedBooking(int userId);
        IEnumerable<dynamic> GetBookingDatesOfUser(int userId);

        int GetLastBookingUser(int idBooking);
    }
}
