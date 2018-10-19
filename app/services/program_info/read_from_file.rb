module ProgramInfo
  class ReadFromFile
    def initialize(file_name:)
      @file_name = file_name
    end

    attr_reader :file_name

    def call
      read_from_file
    end

    def read_from_file
      file_contents = File.readlines(file_name)

      {
        number: number(file_contents[0]),
        title: title(file_contents[1]),
        date: date(file_contents[2]),
        description: description(file_contents[3]),
        playlist: playlist_items(file_contents[4..-1])
      }
    end

    def number(number_line)
      number_line.split('number:')[1].strip
    end

    def title(title_line)
      title_line.split('title:')[1].strip
    end

    def date(date_line)
      date_line.split('date:')[1].strip
    end

    def description(description_line)
      description_line.split('description:')[1].strip
    end

    def playlist_items(playlist_items)
      song_hash = []
      playlist_items.each_with_index do |item, index|
        number = index + 1
        song_info = item.split("#{number}:")
        break if song_info[1].nil?
        song_info = song_info[1].split(';')
        info = {
            number: number,
            title: song_info[0].strip,
            artist: song_info[1].strip,
            album: song_info[2].strip,
            year: song_info[3].strip,
        }
        song_hash << info
      end
      song_hash
    end
  end
end