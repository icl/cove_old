# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Factory(:regular_user)
Factory(:admin_user)
Factory(:first_time_user)

marking = Factory(:tag, :name => "Marking")
riffing = Factory(:tag, :name => "Riffing")
sketching = Factory(:tag, :name => "Sketching")
Factory(:tag, :name => "Distributed Memory")
Factory(:tag, :name => "Costumes")
Factory(:tag, :name => "Sonification")
Factory(:tag, :name => "Imagery")
Factory(:tag, :name => "Props")

interval = Factory(:interval, :tags => [marking, riffing, sketching])

