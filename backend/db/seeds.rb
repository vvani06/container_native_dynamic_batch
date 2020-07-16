# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


2.times do |i|
  Schedule.create(name: "240min #{i}", run_at: Time.new(2000, 01, 01, 03, 00, 00, '+09:00'), calc_index: 240)
end

5.times do |i|
  Schedule.create(name: "120min #{i}", run_at: Time.new(2000, 01, 01, 03, 00, 00, '+09:00'), calc_index: 120)
end

12.times do |i|
  Schedule.create(name: "60min #{i}", run_at: Time.new(2000, 01, 01, 02 + i/6, i%6 * 10, 00, '+09:00'), calc_index: 60)
end

24.times do |i|
  Schedule.create(name: "30min #{i}", run_at: Time.new(2000, 01, 01, 01 + i/6, i%6 * 10, 00, '+09:00'), calc_index: 30)
end

48.times do |i|
  Schedule.create(name: "10min #{i}", run_at: Time.new(2000, 01, 01, i/2, i%2 * 30, 00, '+09:00'), calc_index: 10)
end

48.times do |i|
  Schedule.create(name: "5min #{i}", run_at: Time.new(2000, 01, 01, i/2, i%2 * 30, 00, '+09:00'), calc_index: 5)
end

48.times do |i|
  Schedule.create(name: "1min #{i}", run_at: Time.new(2000, 01, 01, i/2, i%2 * 30, 00, '+09:00'), calc_index: 1)
end
