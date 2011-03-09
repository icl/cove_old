#== Schema for the interval class
    #t.string   "filename"
    #t.string   "camera_angle"
    #t.integer  "session_number"
    #t.datetime "start_time"
    #t.string   "session_type"
    #t.string   "phrase_name"
    #t.string   "phrase_type"
    #t.string   "task_name"
    #t.string   "comments"
    #t.datetime "created_at"
    #t.datetime "updated_at"
    #t.integer  "duration",                :default => 0, :null => false
    #t.string   "alternative_phrase_name"
#   
class Interval < ActiveRecord::Base

  has_and_belongs_to_many :collections
  
  has_many :codings
  has_many :codes, :through => :codings
  has_many :taggings
  has_many :tags, :through => :taggings

  def self.search args
	  search_params = [:camera_angle, :session_type, :phrase_type, :phrase_name]

	  ids = Interval.all.map{|i| i.id}

	  search_params.reject{|p| args[p].blank?}.each do |param|
		  ids &= Interval.includes(:codes).where("codes.name".to_sym => args[param], "codes.coding_type".to_sym => param.to_s).map{|i| i.id}
	  end

	  time = {};
	  unless args[:start_time].blank?
		  (m, d, y) = args[:start_time].split("-")
		  st = Time.gm(y,m,d)
		  time[:start_time] = st.beginning_of_day..st.end_of_day
	  end

	  query = args[:query].blank? ? [] : Interval.search_columns.collect{|col| "#{col} LIKE :query"}.join(" OR ")

	  includes(:codes).includes(:tags).where(query, :query => "%#{args[:query]}%").where(:id => ids).where(time)
  end
  
  def self.search_columns
    ['codes.name', 'tags.name']
  end
  
  def self.filters
    filters = []
    filters <<  ['camera_angle', unique_angles]
    filters << ['session_type', unique_session_types]
    filters << ['phrase_type', unique_phrase_types]
    filters << ['phrase_name' , unique_phrase_names]
    filters << ['start_time', unique_days]
    filters << ['people', ['Wayne', 'Oddette']]
    filters
  end
  
	def end_time
    Time.at(start_time.to_i + duration)
	end
	
	def duration_string
		hours = (duration / (60*60)).floor
		minutes = ((duration - hours*60*60)/60).floor
		sprintf("%02dh%02dm", hours, minutes)
	end

	def day
		start_time.strftime("%m-%d-%y") if start_time
	end

	def camera_angle
		t = codes.camera_angle[0]
		t.nil? ? "" : t.name
	end
	def session_number
		t = codes.session_number[0]
		t.nil? ? "" : t.name
	end
	def session_type
		t = codes.session_type[0]
		t.nil? ? "" : t.name
	end
	def phrase_type
		t = codes.phrase_type[0]
		t.nil? ? "" : t.name
	end
	def phrase_name
		t = codes.phrase_name[0]
		t.nil? ? "" : t.name
	end
	def task_name
		t = codes.task_name[0]
		t.nil? ? "" : t.name
	end
	
	def self.unique_days
		find(:all, :select => "start_time", :order => "start_time").map{|int| int.day}.uniq.compact
	end

	def self.unique_angles
		Code.camera_angle.order("name DESC").map{|c| c.name}
	end
	
	def self.unique_phrase_types
		Code.phrase_type.order("name DESC").map{|c| c.name}
	end
	
	def self.unique_phrase_names
		Code.phrase_name.order("name DESC").map{|c| c.name}
	end

	def self.unique_session_types
		Code.session_type.order("name DESC").map{|c| c.name}
	end

  def path_prefix
    return File.join(Rails.root, 'private')
  end
  
  def sprite_file
    return File.join(path_prefix, "sprites", %Q[#{filename.chomp(".m4v")}_sprite.jpg]) if filename
  end
  def thumbnail_file
    return File.join(path_prefix, "thumbs" , %Q[#{filename.chomp(".m4v")}_thumb.jpg]) if filename
  end

  def video_file
    return File.join(path_prefix, "videos",filename) if filename
  end

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
              field.to_s.downcase
          end # End |case| block
        end # End |do| block

        notes.each do |row|
          raw_data = row.to_hash.reject {|k,v| !Interval.column_names.index(k.to_s)}
          data={}
          #takes row data and downcases them so there are not duplicate things
          raw_data.each{|k,v| data[k]=v.strip rescue data[k]=v }
	  blacklist = [:duration, :start_time, :filename]

          interval = Interval.new(data.reject{|k,v| !blacklist.include?(k)})
          interval.start_time = DateTime.parse(interval.filename.match(/[0-9]{4}(-[0-9]{2}){2}/)[0] + " " + interval.start_time.strftime("%H:%M"))
          interval.save

	  data.keys.reject{|k| blacklist.include?(k)}.each do |k|
		v = data[k]
		Code.new(:name=>v, :coding_type=>k.to_s).save
		interval.codings << Coding.create(:name => v, :coding_type=>k.to_s, :user_id=>1)
	  end

        end
        
        #if !Dir.exists?('log/notes') # Doesn't work for some reason. Directory needs to be created manually
        #  Dir.mkdir('log/notes')
        #end
        
       # File.move("tmp/notes/#{file}","log/notes/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block

  def annotations
    @annotations ||= Annotation.new :interval_id => self.id
  end

  #kaminari
  paginates_per 10

end
