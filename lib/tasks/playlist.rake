namespace :playlist do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :formatted, [:number] => [:environment] do |_task, args|
    result = Playlists::FormatFromFile.new(args[:number]).call.value!
    puts result.join("\n")
  end

  task :to_file, [:from, :to] => :environment do |_task, args|
    # TODO: ignore forever 13,64,111,114 (no available data)
    (args[:from]..args[:to]).each do |i|
      result= Playlists::FormatFromFile.new(i).call.value!
      filename = "bnk_#{i.to_s.rjust(3, '0')}"

      file = File.open("./output/rs_playlists/#{filename}", "w")
      file.write(result.join("\n"))
      file.close

      puts result.join("\n")
    end
  end
end
