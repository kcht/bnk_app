class Calc
  numbers = %i(zero one two three four five)
  operators = { plus: '+', minus: '-'}

  def initialize
    @args = []
  end

  numbers.each_with_index do |number, index|
   define_method number do
      @args << index
      if @operator
        calculate
      else
        return self
      end
   end
  end

  operators.each do |operator, symbol|
    define_method operator do
      @operator = symbol
      self
    end
  end

  def calculate
    second = @args.pop
    first = @args.pop
    case @operator
    when '+'
      first + second
    when '-'
      first - second
    else
      raise 'eroor'
    end
  end
end

puts Calc.new.one.plus.one
puts Calc.new.five.minus.two
puts Calc.new.three.minus.zero