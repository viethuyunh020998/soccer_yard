class TimeCost < ApplicationRecord
  belongs_to :yard
  has_many :bookings, dependent: :destroy

  scope :all_time, ->(param){where("yard_id IN (?)", param).distinct}
  scope :time_yard, (lambda do |yard_ids, time|
    where("yard_id IN (?) AND time = ?", yard_ids, time)
  end)
end
