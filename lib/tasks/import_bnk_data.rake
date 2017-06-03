BNK_DATA_PATH = "db/bnk_data/bnk_034_la_manche"

namespace :bnk do
  task :import_bnk_data do
    require 'pry'
    file_contents = File.readlines(BNK_DATA_PATH)

    number,name = number_name(file_contents[0])
    description, song_lines = parse_description_songs(file_contents[1..file_contents.size])
  end


  def number_name(line)
    number, name = line.split(":")
    number_index = number.index(/[0-9]/)
    number = number[number_index, number.length]
    [number.strip, name.strip]
  end

  def parse_description_songs(lines)
    description = ""
    song_lines = []
    song_started = false
    lines.each do |line|
      if( (line =~ /Playlist/) == 0)
        song_started = true
      elsif (!song_started)
        description += line + "\n"
      else
        song_lines.push(line)
      end
    end
    [description, song_lines]
  end


end
