class PlaylistItem < ApplicationRecord
  belongs_to :program
  belongs_to :song

  def self.update_or_create(attributes)
    obj = assign_or_new(attributes)
    obj.save
    obj
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end 