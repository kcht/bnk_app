BNK_DATA_PATH = "db/bnk_data"

namespace :bnk do
  task :import_bnk_data => :environment do

    Dir.entries(BNK_DATA_PATH).select { |f| f.match(/bnk_/) }.each do |entry|

      file_contents = File.readlines("#{BNK_DATA_PATH}/#{entry}")

      number, name = number_name(file_contents[0])
      date = file_contents[1].strip
      description, song_lines = parse_description_songs(file_contents[2..file_contents.size])

      program = Program.new(name: name, date: date, number: number, description: description)
      program.save!


      song_lines.each do |song_line|
        song, position =song_info_from_songline(song_line)
        song.save!
        playlist_info = PlaylistInfo.new(song_id: song.id, program_id: program.id, playlist_position: position)
        playlist_info.save!
      end
    end
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
      if ((line =~ /Playlist/) == 0)
        song_started = true
      elsif (!song_started)
        description += line + "\n"
      else
        song_lines.push(line)
      end
    end
    [description.strip, song_lines]
  end

  def song_info_from_songline(song_line)
    song_attributes = song_line.split(/,|(\(|\)|(-)(?= ))/)
    song_attributes.select! do |split|
      split.length > 1 || split.match(/[0-9]/)
    end
    number = song_attributes[0].split(/\./,2)[0].try(:strip)
    title = song_attributes[0].split(/\./,2)[1].try(:strip)
    artist = song_attributes[1].try(:strip)
    album = song_attributes[2].try(:strip)
    year = song_attributes[3].try(:strip)

    [Song.new(title: title, artist: artist, album: album, year: year), number]
  end

end
