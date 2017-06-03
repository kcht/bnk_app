require 'fileutils'

start_date = "3-10-2016"

skipped_dates = ["17-04-2017"]

entries = Dir.entries('db/bnk_data').select{ |f| f.match(/bnk_/) }

date = Date.parse(start_date)
entries.each do |file|
  tmpfile = File.new('db/bnk_data/tmp', 'w')
  f = File.readlines("db/bnk_data/#{file}")
  tmpfile << f[0]
  tmpfile << date.to_s
  tmpfile << "\n"
  f[1..f.size].each do |line|
    tmpfile << line
  end
  tmpfile.close
  FileUtils.mv("db/bnk_data/tmp", "db/bnk_data/#{file}")

  date = date + 7.days
  if skipped_dates.map{ |d| Date.parse(d) }.include?(date)
    date = date+7.days
  end
end
