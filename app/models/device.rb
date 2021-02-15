class Device < ApplicationRecord
  belongs_to :user
  has_many :reservations
  validates :name, :device_type, :capacity, :address, :price, presence: true
end
