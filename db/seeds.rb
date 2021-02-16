require 'faker'
require 'net/http'
require 'json'
Faker::Config.locale = 'fr'

puts 'Cleaning Racleat database...'
Reservation.destroy_all
puts 'Old reservations removed !'
Device.destroy_all
puts 'Old devices removed !'
User.destroy_all
puts 'Old Cheezers removed !'

streets = []
url = 'https://api-adresse.data.gouv.fr/search/?q=rue&postcode=75011&limit=30'
uri = URI(url)
response = Net::HTTP.get(uri)
addresses = JSON.parse(response)

addresses['features'].each do | item |
  streets << item['properties']['name']
end

puts 'Creating Cheezers...'

# device needs :name, :device_type, :capacity, :address, :price
DEVICES_TYPES = ['Traditionnel', 'Electrique']
CAPACITIES = [2, 4, 6, 8]
STREET_NUMBERS = (1..20).to_a
PRICES = [5, 10, 15]
BRANDS = ['Tefal', 'Moulinex', 'Proline', 'Electrolux']


5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.free_email(name: "#{first_name}.#{last_name}")
  password = Faker::Internet.password(min_length: 10, max_length: 20)
  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: password
    )
  user.save
  [1, 1, 1, 2].sample.times do
    device_type = DEVICES_TYPES.sample
    capacity = CAPACITIES.sample
    device_name = "Appareil #{device_type} pour #{capacity} personnes"
    address = "#{STREET_NUMBERS.sample} #{streets.sample}"
    brand = BRANDS.sample
    price = PRICES.sample
    device = Device.new(
      name: device_name,
      device_type: device_type,
      capacity: capacity,
      address: address,
      brand: brand,
      price: price,
      user_id: user.id
      )
  end
  puts "#{first_name} #{last_name} is now a Cheezer !"

end
