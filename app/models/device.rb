class Device < ApplicationRecord
  DEVICE_TYPE = ['Traditionnel', 'Electrique']
  belongs_to :user
  has_many :reservations
  validates :name, :device_type, :capacity, :address, :price, presence: true
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
