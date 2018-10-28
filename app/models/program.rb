class Program  < ApplicationRecord
  has_many :playlist_infos, through: :playlist_infos
  has_many :tags, through: :program_tags

  validates :number, presence: true, length: { maximum: 3 }
  validates :name, presence: true, length: { minimum: 5 }

  RESULTS_PER_PAGE = 5

  scope   :paginated, -> (page) do
    order('number desc').paginate(:page => page, :per_page =>  RESULTS_PER_PAGE)
  end

  scope :after_premiere, -> { where('date < ? ', Time.now ) }
  scope :recent, -> { after_premiere.order('date DESC').first(RESULTS_PER_PAGE) }


  def image_path
    path = "bnk_#{bnk_number}.jpg"
    return Rails.application.assets.find_asset(path).nil? ? "bnk_default.jpg" : path
  end

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

  private

  def bnk_number
    number.to_s.rjust(3, '0')
  end
end
