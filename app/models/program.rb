class Program  < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos

  validates :number, presence: true, length: { maximum: 3 }
  validates :name, presence: true, length: { minimum: 5 }
end
