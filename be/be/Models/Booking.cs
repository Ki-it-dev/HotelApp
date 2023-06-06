using System;
using System.Collections.Generic;

namespace be.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public int UserId { get; set; }

    public DateTime CreateDate { get; set; }

    public DateTime CheckIn { get; set; }

    public DateTime CheckOut { get; set; }

    public decimal TotalPrice { get; set; }

    public string Status { get; set; } = null!;

    public decimal? PriceDifference { get; set; }

    public DateTime? UpdateDate { get; set; }

    public DateTime? UpdateCheckIn { get; set; }

    public DateTime? UpdateCheckOut { get; set; }

    public virtual ICollection<BookingDetail> BookingDetails { get; set; } = new List<BookingDetail>();

    public virtual User User { get; set; } = null!;
}
