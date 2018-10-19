module ProgramInfo
  class InsertIntoDb
    def initialize(program_info_hash:)
      @program_info_hash = program_info_hash
    end

    attr_reader :program_info_hash

    def call
      program = Program.where(number: program_info_hash[:number]).first_or_create do |program|
        program.name = program_info_hash[:title]
        program.date = program_info_hash[:date]
        program.description = program_info_hash[:description]
      end

      program_info_hash[:playlist].each do |playlist_item|
        song = Song.where(
            title: playlist_item[:title], artist: playlist_item[:artist],
            album: playlist_item[:album], year: playlist_item[:item]).first_or_create!

        PlaylistInfo.where(song_id: song.id, program_id: program, playlist_position: playlist_item[:number]).first_or_create!
      end
    end
  end
end
