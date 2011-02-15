# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
#PRATIK PRAMANIK IS GOING TO EAT YOUR BRAINS!!!!!!!!!!!! 2/6/2011
#in lib/tasks/
directory "public/videos"

task :default do
  puts "Possible Cmds:"
  puts "   vid_import"
  puts "   sync_db"
end

task :vid_import => "videos" do
  puts "Importing Videos."
  #Chris's code goes here if necessary
    #<alt> Chris's code leaves a flag saying new videos have been imported, prevents this task from running unless new shit is added. something like that. we'll see.
end


task :sync_vid_db => [:environment, "public/videos"] do
  puts "Synchronizing DB."

  #We are working in the public video's folder
  cd "public/videos"
  #1. Grabs DB (intervals [note: dedi video db later])
  puts "DB->files"
  #2. Checks <interval> elements for unstandardized video filepaths (videos not in /videos/<ID>/)
  Interval.all.each do | itvl |
    #3. for Non-conforming elements: Move/Copy files at original filepath to the standardized filepaths (file rename not necessary)
    if itvl.filename != nil
      #SOME file is associated as a video to this interval
      if File.exists?(itvl.filename)
        #file exists, mess with it
        if itvl.filename != "public/videos/"+itvl.id.to_s+"/*"
          filenm = File.basename(itvl.filename)
          mv itvl.filename , itvl.id.to_s+"/"+filenm
          #4. Update DB to reflect new file structure
          itvl.filename = "public/videos/"+itvl.id.to_s+"/"+filenm
          itvl.save
        end
      else
        #doesn't exist, append a comment saying videos are missing
        puts "Interval <"+itvl.id.to_s+">: Video is Missing."
        if itvl.comments != nil
          itvl.comments << " Video File is Missing/Non-Existent."
        else
          itvl.comments = " Video File is Missing/Non-Existent."
        end
      end
    else
      #NO file is associated as a video with this interval
      puts "Interval <"+itvl.id.to_s+">: No Video File associated."
      if itvl.comments != nil
        #append a comment saying its a videoless
        itvl.comments >> " No Video File associated with Interval."
      else
        #listed interval, but
        puts "Interval <"+itvl.id.to_s+">: SIGNIFICANT PROBLEM, All fields are nil, please check Interval in 'rails console'"
      end
    end
  end
  #5. Check video folder for videos without a listing in the database
  puts "files->DB"
  files = Dir.glob("*.*") #only files with extensions (aka no folders, script files) PROBABLY NEED TO CHECK IF MOVIE FILE!
  files.each do | file |
    #6. Create a new listing in DB
    newfile = Interval.new
    newfile.save   #save db item in order to to get an ID value
    #7. videos should be placed in a folder-bucket(name: db ID) if not in a folder already
    newfile.filename = "public/videos/"+newfile.id.to_s+"/"+File.basename(file)
    mkdir newfile.id.to_s       #making directory to move file to
    mv file,newfile.id.to_s+"/"+File.basename(file) #move
    newfile.save
  end
end

=begin
#just a test method, delete later
task :make_vid => "videos" do
  sh "echo 'Video' >> 'videos/test.tmp'"
  mv "videos/test.tmp","videos/test_move.tp"
  files = Dir.glob("*.*")
  files.each do | file |

  end
end
=end

