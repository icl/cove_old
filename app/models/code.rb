class Code < ActiveRecord::Base
  has_many :codings

  validates_presence_of :name
  validates_presence_of :description
  validates_uniqueness_of :name
  validates_presence_of :coding_type

  scope :phenomenon, lambda{where(:coding_type => "phenomenon")}
  scope :people, lambda{where(:coding_type => "people")}
  scope :camera_angle, lambda{ where(:coding_type => "camera_angle")}
  scope :session_number, lambda{ where(:coding_type => "session_number")}
  scope :session_type, lambda{ where(:coding_type => "session_type")}
  scope :phrase_name, lambda {where(:coding_type => "phrase_name")}
  scope :phrase_type, lambda {where(:coding_type => "phrase_type")}
  scope :task_name, lambda {where(:coding_type => "task_name")}

  scope :unapplied, lambda {|interval_id| joins(:codings).where("codings.interval_id <> ?", interval_id)}


=begin
  modding code from Paul Panarease's interval import. Pratik Commented it
=end
  def self.import!
    Dir.foreach("tmp/codings/") do |file|  #for each file in tmp definitions
      
      if file =~ /[^(\.|\.\.)].*csv$/  #check if its a CSV file
        note_file = File.new("tmp/codings/#{file}") #save file in temp variable
        notes = FasterCSV.new(note_file, #throw CSV file at FasterCSV tool
          :headers => true,
          :header_converters => [:downcase, :symbol],
          :skip_blanks => true,
          :col_sep => ','
        )

        #converts notes to a usable format
        notes.convert do |field, info|
	        field.to_s
        end # End |do| block
        

        #puts notes inside the db, NEEDS TO BE MODDED FOR PHENOMENON!
        notes.each do |row|
          def_type = row[:type].downcase
          #case def_type
           # when "Phenomenon"
              stored_phen = Code.where(:name => row[:name].downcase, :coding_type => row[:type].downcase).first
              if stored_phen == nil
                new_phen = Code.new
                new_phen.name = row[:name].downcase
                new_phen.coding_type = row[:type].downcase
                new_phen.description = row[:description]
              	new_phen.save
                #puts "fuck 1","Name:"new_phen.name,"Type:"new_phen.coding_type,"Def:"new_phen.description
              else
                stored_phen.description = row[:description]
              	stored_phen.save
                #puts "fuck 2"
              end
            #else
            #  puts "Unrecognized type. create new tag type then try again."
         # end #end case
        end #end |do row|


        if !File.directory?('log/codings') # Doesn't work for some reason. Directory needs to be created manually
          Dir.mkdir('log/codings')
        end
        
        #move file to new store
        File.move("tmp/codings/#{file}","log/codings/#{file}.imported_at_#{Time.now.strftime("%Y%m%d%H%M")}")
        
    end # End if block
  end # End |Dir.foreach| block
end # End |def import| block 
end # End file
