class Yard < ApplicationRecord
  belongs_to :location
  has_many :time_costs, dependent: :destroy

  scope :all_yard_by_type, (lambda do |id, types|
    where("location_id = ? AND type_yard = ?", id, types)
  end)
end
