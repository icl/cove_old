class Interval < ActiveRecord::Base
  
	def end_time
    Time.at(start_time.to_i + duration)
	end
	
	def duration_string
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
		find(:all, :select => "start_time", :order => "start_time").map{|int| [int.day, int.start_time ]}.uniq
	end

	def self.unique_angles
		return group(:camera_angle).collect { |interval| interval.camera_angle}
	end
	
	def self.unique_phrase_types
	  return group(:phrase_type).collect { |interval| interval.phrase_type}
	end
	
	def self.unique_phrase_names
	  return group(:phrase_name).collect { |interval| interval.phrase_name}
	end

  def self.unique_session_types
    return group(:session_type).collect { |interval| interval.session_type}
  end

	def self.lame_search(v)
		args = [].fill("%#{v}%", 0, column_names.size)
		query = column_names.map{|col| col.to_s}.map{|col| "#{col} LIKE ?"}.join(" OR ")
		where(query, *args)
	end
	
	def self.search args
	  search_conditions = {}
	  
	  search_conditions[:camera_angle] = args[:camera_angle] unless args[:camera_angle].blank?
	  search_conditions[:session_type] = args[:session_type] unless args[:session_type].blank?
	  search_conditions[:phrase_type] =  args[:phrase_type]  unless args[:phrase_type].blank?
	  search_conditions[:phrase_name] =  args[:phrase_name]  unless args[:phrase_name].blank?
	  search_conditions[:start_time] =  Time.parse(args[:date]).beginning_of_day..Time.parse(args[:date]).end_of_day  unless args[:date].blank?
	  
	  parm = [].fill("%#{args[:search]}%", 0, column_names.size)
		query = column_names.map{|col| col.to_s}.map{|col| "#{col} LIKE ?"}.join(" OR ")
		where(query, *parm).where(search_conditions)
	end
	
  has_many :interval_tags, :dependent => :destroy
  has_many :tags, :through => :interval_tags
  has_many :snippets

  def self.import!
    Dir.foreach("tmp/notes/") do |file|
      if file =~ /[^(\.|\.\.)].*csv$/
        note_file = File.new("tmp/notes/#{file}")
        notes = FasterCSV.new(note_file,
          :headers => true,
          :header_converters => [lambda {|h| h.gsub(/#/,'number').gsub(/comment/i, 'comments').gsub(/File\sName/i,'filename').gsub(/Type of Session/,"session_type").gsub(/Phrase Name/, 'phrase_name').gsub(/Phrase Tyle/, 'phrase_type')}, :symbol],
          :skip_blanks => true,
          :col_sep => ','
        )
        notes.convert do |field, info|
          case info.header
            when :filename
              field.gsub(/\.(mov|m4v)/,'')
            when :session_number
              /^[A-Za-z\s]+(\d+)/.match(field)[1]
            when :start_time
              field.gsub!(/-/,':')
      		    (t1,t2) = field.split("+")
      		    if t2.nil?
      			    DateTime.parse(t1)
      		    else
      			    (h,m,s) = t2.split(":").map{|v| v.to_i}
      			    DateTime.parse(t1) + h.hours + m.minutes + s.seconds
      		    end
            when :duration
	            h = field.match(/(\d*)h/)[1]
      	      h.nil? ? 0 : h[1]
      	      m = field.match(/(\d*)m/)[1]
      	      m.nil? ? 0 : m[1]
      	      s = field.match(/(\d*)s?$/)[1]
      	      s.nil? ? 0 : s[1]
      	      s.to_i + m.to_i*60 + h.to_i*60*60
            else
              field.to_s
          end # End |case| block
        end # End |do| block
        
        notes.each do |row|
          raw_data = row.to_hash.reject {|k,v| !Interval.column_names.index(k.to_s)}
          data={}
          raw_data.each{|k,v| data[k]=v.strip rescue data[k]=v }
          interval = Interval.new(data)
          interval.start_time = DateTime.parse(interval.filename.match(/[0-9]{4}(-[0-9]{2}){2}/)[0] + " " + interval.start_time.strftime("%H:%M"))
          interval.save
        end
        
        #if !Dir.exists?('log/notes') # Doesn't work for some reason. Directory needs to be created manually
        #  Dir.mkdir('log/notes')
        #end
        
        File.move("tmp/notes/#{file}","log/notes/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block

  def annotations
    @annotations ||= Annotation.new :interval_id => self.id
  end
end
