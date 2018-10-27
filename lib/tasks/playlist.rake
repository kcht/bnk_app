namespace :playlist do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :formatted, [:number] => [:environment] do |_task, args|
    result = Playlists::FormatFromFile.new(args[:number]).call.value!
    puts result.join("\n")
  end
end

