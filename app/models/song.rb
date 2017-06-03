class Song < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos
end