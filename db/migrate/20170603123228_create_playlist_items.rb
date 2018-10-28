class CreatePlaylistItems < ActiveRecord::Migration[5.1]
  def change
    create_table :playlist_items do |t|
      t.integer :program_id
      t.integer :song_id
      t.integer :position
    end
  end
end
