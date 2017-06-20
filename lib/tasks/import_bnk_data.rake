BNK_DATA_PATH = "db/bnk_data"

namespace :bnk do
  @logger = Logger.new(STDOUT)
  desc 'Import BNK data from files to db'
  task :import_bnk_data => :environment do

    Dir.entries(BNK_DATA_PATH).select { |f| f.match(/bnk_/) }.each do |entry|

      file_contents = File.readlines("#{BNK_DATA_PATH}/#{entry}")

      number, name = number_name(file_contents[0])
      date = file_contents[1].strip
      description, song_lines = parse_description_songs(file_contents[2..file_contents.size])

      program = Program.new(name: name, date: date, number: number, description: description)

      if save_program(program)

        song_lines.each do |song_line|
          song, position =song_info_from_songline(song_line)
          save_song(program,song, position)
        end
      end
    end
  end

  def save_program(program)
    present_in_db = Program.all.pluck(:number).include?(program.number)
    if present_in_db
      @logger.debug("Skipping program with number= #{program.number} as it is already present in the db")
      false
    else
      program.save!
      @logger.debug("Saved program with number= #{program.number}")
      true
    end
  end

  def save_song(program,song, position)
    present_in_db = Song.all.pluck(:artist, :title).
        select {|s| s[0] == song.artist && s[1] == song.title}.
        count != 0


    if present_in_db
      @logger.debug("Skipping song with title= #{song.title}, artist=#{song.artist} as it is already present in the db")
      #playlist info should still be added
      song = Song.where(artist: song.artist, title: song.title).first
    else
      song.save!
      @logger.debug("Saving song with title= #{song.title}, artist=#{song.artist}")

    end

    playlist_info_present_in_db = PlaylistInfo.all.pluck(:song_id, :program_id).
        select {|info| info[0] == song.id && info[1] == program.id}.
        count != 0
    #todo: cleanup this ugly code:P
    if playlist_info_present_in_db
      @logger.debug("Skipping Playlist info for song_id= #{song.id}, program_id=#{program.id} as it is already present in the db")
    else
      playlist_info = PlaylistInfo.new(song_id: song.id, program_id: program.id, playlist_position: position)
      playlist_info.save!
      @logger.debug("Saving Playlist info for song_id= #{song.id}, program_id=#{program.id}")
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
    number = song_attributes[0].split(/\./, 2)[0].try(:strip)
    title = song_attributes[0].split(/\./, 2)[1].try(:strip)
    artist = song_attributes[1].try(:strip)
    album = song_attributes[2].try(:strip)
    year = song_attributes[3].try(:strip)

    [Song.new(title: title, artist: artist, album: album, year: year), number]
  end

end
