class Interval < ActiveRecord::Base
  
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
              
            when :camera_angle
              
            when :session_number
              
            when :start_time
              
            when :duration
              
            when :session_type
              
            when :phrase_name
              
            when :phrase_type
              
            when :task_name
              
            when :comments
              
            else
              
          end # End |case| block
        end # End |do| block
        
        report.each do |row|
          Interval.create(row.to_hash)
        end
        
        File.move("tmp/notes/#{file}","log/notes/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block
  
end
