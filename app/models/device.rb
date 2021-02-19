class Device < ApplicationRecord
  include PgSearch::Model
  DEVICE_TYPE = ['Traditionnel', 'Electrique']
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :name, :device_type, :capacity, :address, :price, presence: true
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  pg_search_scope :search_by_all_fields,
    against: [ :name, :brand, :device_type, :capacity ],
    using: {
      tsearch: { prefix: true }
    }
end
