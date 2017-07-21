require 'capybara'

# Helper methods #

def fill_in_google_search(search_query)
  @session.fill_in('lst-ib', with: search_query)
  @session.find('#lst-ib').native.send_keys(:return)
end

def album_info_present?
  @session.has_css?('.kno-fb-ctx', text: 'Album')
end

def get_album_title
  tag = @session.find('.kno-fb-ctx', text: 'Album')
  tag.find('.kno-fv').find('.fl').text
end

def get_album_date
  tag = @session.find('.kno-fb-ctx', text: /Data wydania|Release/)
  tag.find('.kno-fv').text
end

def write_to_file(path_to_file, table_with_metadata)
  unless table_with_metadata.empty?
    File.open(path_to_file, 'a') do |f|
      f.puts table_with_metadata.join("\n")
    end
  end
end

# Script

@session = Capybara::Session.new(:selenium)
@session.visit('http://www.google.com')

path_to_file = "db/bnk_data/#{ARGV.first}"
file = File.new(path_to_file)

songs_with_metadata = []

begin
  file.each_line do |line|
    search_query= line.split('.')[-1]
    fill_in_google_search(search_query)

    if album_info_present?
      album_title = get_album_title
      album_date = get_album_date

      puts string = "#{line.strip}: (#{album_title}, #{album_date})"
      songs_with_metadata << "#{line.strip} (#{album_title}, #{album_date})"
    else
      puts line + ' - not found'
      songs_with_metadata << line.strip
    end
  end
rescue => e
    puts e.message
ensure
  write_to_file(path_to_file, songs_with_metadata)
end


