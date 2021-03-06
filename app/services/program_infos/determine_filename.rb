module ProgramInfos
  class DetermineFilename
    BNK_DATA_PATH = "db/bnk_data/"

    def initialize(program_number)
      @program_number = program_number
    end

    def call
      program_number_regex = "bnk_#{program_number.to_s.rjust(3, '0')}"
      entries = Dir.entries(BNK_DATA_PATH).select {|f| f.match(/#{Regexp.quote(program_number_regex)}/)}
      entries.first.present? ? "#{BNK_DATA_PATH}#{entries.first}" : nil
    end

    private

    attr_reader :program_number
  end
end
