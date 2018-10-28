class Tag < ApplicationRecord
  has_many :program_tags
  has_many :programs, through: :program_tags
end