class Song < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos

  def self.search(search)
    where("title LIKE ? OR artist LIKE ? OR album LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end