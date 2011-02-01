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
		find(:all, :select => "start_time", :order => "start_time").map{|int| int.day}.uniq
	end

	def self.unique_angles
		find(:all, :select => "DISTINCT camera_angle", :order => "camera_angle")
	end

	def self.lame_search(v)
		args = [].fill("%#{v}%", 0, column_names.size)
		query = column_names.map{|col| col.to_s}.map{|col| "#{col} LIKE ?"}.join(" OR ")
		where(query, *args)
	end
	
  has_many :interval_tags, :dependent => :destroy
  has_many :tags, :through => :interval_tags
end
