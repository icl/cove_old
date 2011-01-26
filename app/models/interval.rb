class Interval < ActiveRecord::Base
	def duration
		st = read_attribute(:start_time)
		et = read_attribute(:end_time)

		duration = et-st
		hours = (duration / (60*60)).floor
		minutes = ((duration - hours*60*60)/60).floor
		sprintf("%02dh%02dm", hours, minutes)
	end

	def day
		read_attribute(:start_time).strftime("%d-%m-%y")
	end
	
	def start_time_of_day
		read_attribute(:start_time).strftime("%I:%M %p")
	end

	def self.unique_days
		find(:all, :order => "start_time").map{|int| int.day}.uniq
	end
	def self.unique_angles
		find(:all).map{|int| int.camera_angle}.uniq.sort
	end
end
