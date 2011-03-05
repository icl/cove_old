class Def_Import
=begin
  modding code from Paul Panarease's interval import. Pratik Commented it
=end
  def self.import!
    Dir.foreach("tmp/definitions/") do |file|  #for each file in tmp definitions
      
      if file =~ /[^(\.|\.\.)].*csv$/  #check if its a CSV file
        note_file = File.new("tmp/definitions/#{file}") #save file in temp variable
        notes = FasterCSV.new(note_file, #throw CSV file at FasterCSV tool
          :headers => true,
          :header_converters => [lambda {|h| h.gsub(/Term/, 'term').gsub(/Type/, 'type').gsub(/Definition/, 'definition')}, :symbol],
          :skip_blanks => true,
          :col_sep => ','
        )

        #converts notes to a usable format
        notes.convert do |field, info|
	        field.to_s
        end # End |do| block
        

        #puts notes inside the db, NEEDS TO BE MODDED FOR CODE!
        notes.each do |row|
          def_type = row[:type]
          case def_type
            when "Phenomenon"
              stored_phen = Code.find_by_name(row[:term])
              if stored_phen == nil
                new_phen = Code.new
                new_phen.name = row[:term]
                new_phen.description = row[:definition]
	            	new_phen.coding_type = "phenomenon"
	            	new_phen.save
              else
                stored_phen.description = row[:definition]
	            	stored_phen.save
              end
            else
              puts "Unrecognized term. create new tag type then try again."
          end #end case
        end #end |do row|


        if !File.directory?('log/definitions') # Doesn't work for some reason. Directory needs to be created manually
          Dir.mkdir('log/definitions')
        end
        
        #move file to new store
        File.move("tmp/definitions/#{file}","log/definitions/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
      end # End |if file| block
    end # End |Dir.foreach| block
  end # End |def import| block
end
