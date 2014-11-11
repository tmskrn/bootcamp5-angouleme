# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 person = Person.create(first_name: "Jane", last_name: "Doe")
 Car.create(model: "bmw", registration_number: "Y550p", owner: person)
 Car.create(model: "fiat uno", registration_number: "v34fr5", owner: person)

