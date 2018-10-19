class ProgramTag < ApplicationRecord
  belongs_to :program_info
  belongs_to :tag
end