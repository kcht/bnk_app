class Tag < ApplicationRecord
  has_many :programs, through: :program_tags
end