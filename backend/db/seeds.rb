# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Schedule.create(name: "test_01", run_at: Time.new(2000, 01, 01, 22,  0, 0, '+09:00'), calc_index: 48)
Schedule.create(name: "test_02", run_at: Time.new(2000, 01, 01, 22,  5, 0, '+09:00'), calc_index: 32)
Schedule.create(name: "test_03", run_at: Time.new(2000, 01, 01, 21, 55, 0, '+09:00'), calc_index: 40)
Schedule.create(name: "test_04", run_at: Time.new(2000, 01, 01, 22,  2, 0, '+09:00'), calc_index: 45)
Schedule.create(name: "test_05", run_at: Time.new(2000, 01, 01, 22,  3, 0, '+09:00'), calc_index: 49)
Schedule.create(name: "test_06", run_at: Time.new(2000, 01, 01, 05,  0, 0, '+09:00'), calc_index: 14)
Schedule.create(name: "test_07", run_at: Time.new(2000, 01, 01, 05,  0, 0, '+09:00'), calc_index: 20)
Schedule.create(name: "test_08", run_at: Time.new(2000, 01, 01, 05,  1, 0, '+09:00'), calc_index: 25)
Schedule.create(name: "test_09", run_at: Time.new(2000, 01, 01, 05,  5, 0, '+09:00'), calc_index: 33)
Schedule.create(name: "test_10", run_at: Time.new(2000, 01, 01, 05,  8, 0, '+09:00'), calc_index: 42)
