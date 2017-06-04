def method_throwing_exception(exception)
  raise exception unless exception.nil?
  "not return value either"
rescue IOError => e
  puts "io error"
rescue StandardError => e
  puts "standard error"
else
  puts "no exception"
  "return value"
ensure
  puts "ensuring"
  "not return value"
end

X = method_throwing_exception(nil)
puts "x is #{X}"