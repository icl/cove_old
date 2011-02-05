class Interval < ActiveRecord::Base
  
	def end_time
    Time.at(start_time.to_i + duration)
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
          :header_converters => :symbol,
          :skip_blanks => true,
          :col_sep => ','
        )
        notes.convert do |field, info|
          case info.header.underscore
            when :file_name
              # Drop File Extension
            when :camera_angle
              
            when :session_number
              /^Session (\d+)$/.match(field)
            when :start_time
              
            when :duration
	      h = field.match(/(\d*)h/)
	      h.nil? ? 0 : h[1]
	      m = field.match(/(\d*)m/)
	      m.nil? ? 0 : m[1]
	      s = field.match(/(\d*)s/)
	      s.nil? ? 0 : s[1]
	      s + m*60 + h*60*60
            when :session_type
              
            when :phrase_name
              
            when :phrase_type
              
            when :task_name
              
            when :comments
              
            else
              
          end # End |case| block
        end # End |do| block
        
        notes.each do |row|
          Interval.create(row.to_hash)
        end
        
        File.move("tmp/notes/#{file}","log/notes/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block

end
