class Comment < ApplicationRecord
  belongs_to :location
  belongs_to :user
  scope :newest, ->{order created_at: :desc}

  delegate :name, to: :user
end
