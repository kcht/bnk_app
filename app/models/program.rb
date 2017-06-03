class Program < ApplicationRecord
  validates :number, presence: true, length: { maximum: 3 }
  validates :name, presence: true, length: { minimum: 5 }
end
