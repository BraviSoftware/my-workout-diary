# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Default Activity Types
ActivityType.create(name: "Physical Exercises", description: "Have you done physical exercies?", status: true)
ActivityType.create(name: "Drink Water", description: "Have you drunk water?", status: true)
ActivityType.create(name: "Fruits", description: "Have you eaten fruits?", status: true)