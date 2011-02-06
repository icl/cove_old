class Interval < ActiveRecord::Base
  
	def end_time
    Time.at(start_time.to_i + duration)
	end
	
	def duration_string
	  # Need duration string code
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

  def self.import
    Dir.foreach("tmp/notes/") do |file|
      if file =~ /[^(\.|\.\.)].*csv$/
        note_file = File.new("tmp/notes/#{file}")
        notes = FasterCSV.new(note_file,
          :headers => true,
          :header_converters => [lambda {|h| h.gsub(/#/,'number')}, :symbol],
          :skip_blanks => true,
          :col_sep => ','
        )
        notes.convert do |field, info|
          case info.header.gsub(/#/,'number')
            when :file_name
              field.gsub(/\.(mov|m4v)/,'')
            when :camera_angle
              field.to_s
            when :session_number
              /^Session (\d+)$/.match(field)
            when :start_time
              
            when :duration
	            h = field.match(/(\d*)h/)[0]
      	      h.nil? ? 0 : h[1]
      	      m = field.match(/(\d*)m/)[0]
      	      m.nil? ? 0 : m[1]
      	      s = field.match(/(\d*)s/)[0]
      	      s.nil? ? 0 : s[1]
      	      s + m*60 + h*60*60
            when :session_type
              field.to_s
            when :phrase_name
              field.to_s
            when :phrase_type
              field.to_s
            when :task_name
              field.to_s
            when :comments
              field.to_s
            else
              nil
          end # End |case| block
        end # End |do| block
        
        notes.each do |row|
          interval = Interval.new(row.to_hash)
          interval.start_time = DateTime.parse(interval.file_name.match(/[0-9]{4}(-[0-9]{2}){2}/)[0] + " " + interval.start_time.strftime("%H:%M"))
        end
        
        File.move("tmp/notes/#{file}","log/notes/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block

end
