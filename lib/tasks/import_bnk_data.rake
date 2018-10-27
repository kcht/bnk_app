BNK_DATA_PATH = "db/bnk_data"

namespace :bnk do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :import_bnk_data => :environment do
    entries = Dir.entries(BNK_DATA_PATH).select {|f| f.match(/bnk_/)}

    entries.each do |entry|
      puts "Analyzing file #{entry}..."
      full_name = "#{BNK_DATA_PATH}/#{entry}"
      info_hash = ProgramInfo::ReadFromFile.new(file_name: full_name).call
      ProgramInfo::InsertIntoDb.new(program_info_hash: info_hash).call

      puts "Finished analyzing file #{entry}!"
    end
  end
end

