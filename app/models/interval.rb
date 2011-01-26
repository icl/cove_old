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
		st = read_attribute(:start_time)
		sprintf("%d-%d-%d", st.month, st.day, st.year)
	end
	
	def start_time_of_day
		st = read_attribute(:start_time)
		sprintf("%02d:%02d %s", st.hour % 12, st.min, (st.hour / 12).floor == 0 ? "AM" : "PM")
	end

	def self.unique_days
		find(:all, :order => "start_time").map{|int| int.day}.uniq
	end

	def self.unique_angles
		find(:all, :select => "DISTINCT camera_angle").map{|int| int.camera_angle}.sort
	end

	def self.lame_search(v)
		args = [].fill("%#{v}%", 0, column_names.size)
		query = column_names.map{|col| col.to_s}.map{|col| "#{col} LIKE ?"}.join(" OR ")
		where(query, *args)
	end
end
