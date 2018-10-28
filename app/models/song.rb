class Song < ApplicationRecord
  has_many :playlist_items
  has_many :programs, through: :playlist_items

  def self.search(search)
    where("title LIKE ? OR artist LIKE ? OR album LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end


  def played_more_than_once

  end
end