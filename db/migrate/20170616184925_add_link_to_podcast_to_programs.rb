class AddLinkToPodcastToPrograms < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :link_to_podcast, :string
  end
end
