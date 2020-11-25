class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum role: {user: 0, admin: 1}

  has_secure_password
  has_one_attached :image

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # validates :name, presence: true,
  #           length: {maximum: Settings.model.user.name_max}

  # validates :email, presence: true,
  #           length: {maximum: Settings.model.user.email_max},
  #           format: {with: VALID_EMAIL_REGEX},
  #           uniqueness: {case_sensitive: true}
  # validates :phone, presence: true

  # validates :password, presence: true,
  #           length: {minimum: Settings.model.user.password_mini},
  #           allow_nil: true

  # validate :acceptable_image_type?

  # validate :acceptable_image_size?

  def acceptable_image_type?
    return unless image.attached?

    return if image.content_type.in? Settings.model.user.content_type

    errors.add :image
    flash[:warning] = t "user_model.error_type"
  end

  def acceptable_image_size?
    return unless image.attached?

    return unless image.byte_size > Settings.model.user.image_size.megabyte

    errors.add :image
    flash[:warning] = t "user_model.error_size"
  end

  def displayed_image
    if image.attached?
      image
    else
      Settings.model.user.display_image
    end
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def send_notify_booking_to_user_email booking
    UserMailer.booking_to_user(self, booking).deliver_now
  end

  def send_notify_cancel_by_user_email booking
    UserMailer.cancel_booking_by_user(self, booking).deliver_now
  end

  def send_notify_cancel_by_admin_email booking
    UserMailer.cancel_booking_by_admin(self, booking).deliver_now
  end

  def send_notify_accept_to_user_email booking
    UserMailer.accept_booking_to_user(self, booking).deliver_now
  end

  def send_notify_reject_to_user_email booking
    UserMailer.reject_booking_to_user(self, booking).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end
end
