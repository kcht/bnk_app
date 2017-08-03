require 'active_support'
require 'pry'

@nominals = [50,20,10,5,2,1]

def change(cost:, amount:)
  raise 'The amount is lower than cost' if amount < cost
  change = []
  change_to_be_given = ((amount - cost) *100).to_i

  @nominals.each do |nominal|
    binding.pry
    amount_of_coins = change_to_be_given / nominal
    amount_of_coins.to_i.times do
      change << nominal
    end
    change_to_be_given -= amount_of_coins * nominal
    binding.pry

  end

  change
end

#puts change(cost: 9.2, amount: 10)

hash = { a: { b: { c: 42, d: 'foo' }, d: 'bar' }, e: 'baz' }
hash = {a: {b: 34}}

def flatten_me(hash)
  hash.keys.map{ |k| "_#{k}"}
end