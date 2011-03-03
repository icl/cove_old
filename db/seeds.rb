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

marking = Factory(:tagging, :name => "Marking")
riffing = Factory(:tagging, :name => "Riffing")
sketching = Factory(:tagging, :name => "Sketching")
Factory(:tagging, :name => "Distributed Memory")
Factory(:tagging, :name => "Costumes")
Factory(:tagging, :name => "Sonification")
Factory(:tagging, :name => "Imagery")
Factory(:tagging, :name => "Props")

interval = Factory(:interval,  :taggings => [marking, riffing, sketching])

