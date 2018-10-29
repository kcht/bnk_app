module ProgramInfos
  class InsertIntoDb
    def initialize(program_info_hash)
      @program_info_hash = program_info_hash
    end

    attr_reader :program_info_hash, :ovewrite

    def call
      program = Program.where(number: program_info_hash[:number]).update_or_create(
          name: program_info_hash[:title],
          date: program_info_hash[:date],
          description: program_info_hash[:description]
      )

      program_info_hash[:playlist].each do |playlist_item|
        song = Song.where(
            title: playlist_item[:title], artist: playlist_item[:artist],
            album: playlist_item[:album], year: playlist_item[:year]).first_or_create!

        PlaylistItem.where(song_id: song.id, program_id: program.id).update_or_create(
          position: playlist_item[:number]
        )
      end
    end
  end
end

