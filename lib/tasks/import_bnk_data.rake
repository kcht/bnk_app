BNK_DATA_PATH = "db/bnk_data"

namespace :bnk do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :import_bnk_data => :environment do
    from_number = ask('Which program number to start with? ') || 1
    to_number = ask('Which program number to finish with? ') || 1000

    (from_number..to_number).each do |program_number|
      filepath = ProgramInfos::DetermineFilename.new(program_number).call
      puts "Analyzing file #{filepath}..."
      info_hash = ProgramInfos::ReadFromFile.new(filepath).call
      ProgramInfos::InsertIntoDb.new(info_hash).call

      puts "Finished analyzing file #{filepath}!"
    end
  end
end

def ask( message )
  print "#{message}: "
  STDIN.gets.chomp
end
