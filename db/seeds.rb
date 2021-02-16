require 'faker'

puts 'Cleaning database...'
Reservation.destroy_all
Device.destroy_all
User.destroy_all



# first_name = Faker::Name.first_name
# last_name = Faker::Name.last_name
# email = Faker::Internet.free_email(name: "#{first_name}.#{last_name}")
# password = Faker::Internet.password(min_length: 10, max_length: 20)

# puts first_name
# puts last_name
# puts email
# puts password


