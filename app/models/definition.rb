class Definition < ActiveRecord:Base

=begin
  modding code from Paul Panarease's interval import. Pratik Commented it
=end
  def self.import!
    Dir.foreach("tmp/definitions/") do |file|  #for each file in tmp definitions
      if file =~ /[^(\.|\.\.)].*csv$/  #check if its a CSV file
        note_file = File.new("tmp/notes/#{file}") #save file in temp variable
        notes = FasterCSV.new(note_file, #throw CSV file at FasterCSV tool
          :headers => true,
          :header_converters => [lambda {|h| h.gsub(/Term/, 'term').gsub(/Type/, 'type').gsub(/Definition/, 'definition')}, :symbol],
          :skip_blanks => true,
          :col_sep => ','
        )

        #converts notes to a usable format
        notes.convert do |field, info|
          case info.header
            when :term
              #field.gsub(/\.(mov|m4v)/,'')
              puts "Found term."
            when :definition
              #/^[A-Za-z\s]+(\d+)/.match(field)[1]
              puts "Found definition."
            when :type
              puts "Found type."
            else
              field.to_s
          end # End |case| block
        end # End |do| block
        

        #puts notes inside the db, NEEDS TO BE MODDED FOR PHENOMENON!
        notes.each do |row|
          def_type = row.get_the_type
          case def_type
            when 'Phenomenon'|'phenomenon'|'phenomena'|'Phenomena'
              stored_phen = Phenomenon.find_by_name(row.get_the_term.generalize)
              if stored_phen == nil
                new_phen = Phenomenon.new
                new_phen.name = row.get_the_term
                new_phen.description = row.get_the_definition
              else
                stored_phen.description = row.get_the_definition
            else
              puts "Unrecognized term. create new tag type then try again."
            end #end when
          end #end case


          #raw_data = row.to_hash.reject {|k,v| !Interval.column_names.index(k.to_s)}
          #data={}
          #raw_data.each{|k,v| data[k]=v.strip rescue data[k]=v }
          #interval = Interval.new(data)
          #interval.save
        end
        
        #if !Dir.exists?('log/notes') # Doesn't work for some reason. Directory needs to be created manually
        #  Dir.mkdir('log/notes')
        #end
        
        #move file to new store
        File.move("tmp/definitions/#{file}","log/definitions/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block
end
