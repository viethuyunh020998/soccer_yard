class UserMailer < ApplicationMailer
  def booking_to_user user, booking
    handle_send_mail user, booking, t("send_email.sub_booking")
  end

  def cancel_booking_by_user user, booking
    handle_send_mail user, booking, t("send_email.sub_cancel_user")
  end

  def cancel_booking_by_admin user, booking
    handle_send_mail user, booking, t("send_email.sub_cancel_admin")
  end

  def accept_booking_to_user user, booking
    handle_send_mail user, booking, t("send_email.sub_accept")
  end

  def reject_booking_to_user user, booking
    handle_send_mail user, booking, t("send_email.sub_reject")
  end

  private

  def handle_send_mail user, booking, subject_text
    @user = user
    @booking = booking
    mail to: @user.email, subject: subject_text
  end
end
