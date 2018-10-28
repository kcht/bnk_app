require 'dry/monads/all'

module Playlists
  class FormatFromFile
    include Dry::Monads::Result::Mixin

    BNK_DATA_PATH = "db/bnk_data"

    def initialize(filename)
      @filename = filename
    end

    def call
      Success(filename: filename)
          .bind(method(:read_from_file))
          .bind(method(:format_playlist_output))
    end

    private

    attr_reader :filename


    def read_from_file(filename)
      return Right(ProgramInfos::ReadFromFile.new(file_name: filename).call.value!)
    end

    def format_playlist_output(file_content)
      output = []
      file_content[:playlist].each do |song|
        number = song.fetch(:number)
        title = song.fetch(:title)
        artist = song.fetch(:artist)
        album = song.fetch(:album)
        year = song.fetch(:year)

        output << "#{number}. #{title} - #{artist} (#{album}, #{year})"
      end

      Success(output)
    end
  end
end