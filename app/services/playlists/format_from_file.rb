require 'dry/monads/all'

module Playlists
  class FormatFromFile
    include Dry::Monads::Result::Mixin

    BNK_DATA_PATH = "db/bnk_data"

    def initialize(program_number)
      @program_number = program_number
    end

    def call
      Success(program_number: program_number)
          .bind(method(:check_file_exists))
          .bind(method(:readlines))
          .bind(method(:discard_non_playlist_lines))
          .bind(method(:format_playlist_output))
    end

    private

    attr_reader :program_number


    def check_file_exists(program_number:)
      regex = "bnk_#{program_number.to_s.rjust(3,'0')}"
      entries = Dir.entries(BNK_DATA_PATH).select {|f| f.match(/#{Regexp.quote(regex)}/)}
      entry = entries.first
      entry.present? ? Success(entry: entry) : Failure('file doesnt exist')
    end

    def readlines(entry:)
      lines = File.readlines("#{BNK_DATA_PATH}/#{entry}")
      Success(lines: lines)
    end

    def discard_non_playlist_lines(lines:)
      lines.select! {|line| line =~ /^[0-9]/}
      Success(lines: lines)
    end

    def format_playlist_output(lines:)
      output = []
      lines.each do |line|
        number = line.split(':').first
        song_info = line.split(':').second.strip
        title, artist, album, year = song_info.split(';').map(&:strip)

        output << "#{number}. #{title} - #{artist} (#{album}, #{year})"
      end

      Success(output)
    end
  end
end
