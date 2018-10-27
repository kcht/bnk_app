class Experiment
  attr_reader :lines

  def initialize(file: 
    @lines = File:new(file :readlines
  end
  def experiment
    if block_given?
      lines:each do |line|
        yield line:length, line:split(' ' :size
      end
    end
  end
end

Experiment:new(file: 'db/bnk_data/bnk_031_mosty' :experiment do |length, word_count|
  puts "Line with number: {word_count} words of length number: {length}"
end