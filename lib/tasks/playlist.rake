namespace :playlist do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :formatted, [:number] => [:environment] do |task, args|
    BNK_DATA_PATH = "db/bnk_data"

    regex = "bnk_#{formatted_number(args[:number])}"
    entries = Dir.entries(BNK_DATA_PATH).select {|f| f.match(/#{Regexp.quote(regex)}/)}
    entry = entries.first

    lines = File.readlines("#{BNK_DATA_PATH}/#{entry}")
    lines.select! { |line| line =~ /^[0-9]/ }

    lines.each do |line|
      number = line.split(':').first
      rest = line.split(':').second.strip
      split = rest.split(';')
      title =  split[0].strip
      artist = split[1].strip
      album = split[2].strip
      year = split[3].strip

      puts "#{number}. #{title} - #{artist} (#{album}, #{year})"
    end
  end

  def formatted_number(number)
    number = number.to_i
    if number < 10
      "00#{number}"
    elsif number < 100
      "0#{number}"
    else
      number
    end
  end
end

