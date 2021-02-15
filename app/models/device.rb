class Device < ApplicationRecord
  belongs_to :user

  validates :name, :device_type, :capacity, :address, :price, presence: true
end
