class Program  < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos
  has_many :tags, through: :program_tags

  validates :number, presence: true, length: { maximum: 3 }
  validates :name, presence: true, length: { minimum: 5 }

  RESULTS_PER_PAGE = 5

  scope   :paginated, -> (page) do
    order('number desc').paginate(:page => page, :per_page =>  RESULTS_PER_PAGE)
  end

  def image_path
    path = "bnk_#{bnk_number}.jpg"
    return Rails.application.assets.find_asset(path).nil? ? "bnk_default.jpg" : path
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
