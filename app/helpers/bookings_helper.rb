module BookingsHelper
  def handle_name_status name
    case name
    when Settings.admin_booking.enum_status.pending
      t "booking.status.pending"
    when Settings.admin_booking.enum_status.accept
      t "booking.status.accept"
    when Settings.admin_booking.enum_status.rejected
      t "booking.status.rejected"
    else
      t "booking.status.cancel"
    end
  end

  def handle_layout name
    case name
    when Settings.admin_booking.enum_status.pending
      "danger"
    when Settings.admin_booking.enum_status.accept
      "success"
    when Settings.admin_booking.enum_status.rejected
      "warning"
    else
      "active"
    end
  end

  def greater_than_date_now? date_booking
    Time.zone.today <= date_booking
  end

  def greater_than_hour_now? hour
    hour = hour.to_s.split("-").map(&:to_i)[0]
    Time.zone.now.hour < hour
  end
end
