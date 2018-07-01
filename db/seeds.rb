# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'mgiacomi@gltech.com', password: password, admin: true)
puts "#{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'kblack@pdx.edu', password: password, admin: true)
puts "#{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'walcottma@msn.com', password: password, admin: true)
puts "#{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'ssi.ishibuchi@gmail.com', password: password, ssi_admin: true)
puts "#{user.email} #{password}"

password = SecureRandom.urlsafe_base64(6)
user = User.create(email: 'pjbilotta@aol.com', password: password, admin: true)
puts "#{user.email} #{password}"
