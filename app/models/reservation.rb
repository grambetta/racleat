class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :device
  validates :start_date, :end_date, :total_price
end
