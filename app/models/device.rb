class Device < ApplicationRecord
  DEVICE_TYPE = ['Traditionnel', 'Electrique']
  belongs_to :user
  has_many :reservations
  validates :name, :device_type, :capacity, :address, :price, presence: true
end
