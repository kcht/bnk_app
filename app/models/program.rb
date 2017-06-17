class Program  < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos

  validates :number, presence: true, length: { maximum: 3 }
  validates :name, presence: true, length: { minimum: 5 }

  def image_path
    "bnk_#{bnk_number}.jpg"
  end

  private

  def bnk_number
    if number <10
      return "00#{number}"
    elsif number <100
      return "0#{number}"
    else
      return number.to_s
    end
  end
end
