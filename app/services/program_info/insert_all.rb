require 'dry/monads/all'

module ProgramInfos
  class InsertSingle
    include Dry::Monads::Result::Mixin

    def initialize(filename:, overwrite: true)
      @overwrite = overwrite
      @filename = filename
    end

    def call

    end

    private

    attr_reader :overwrite, :filename

  end
end