class CreatePlaylistInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :playlist_infos do |t|
      t.integer :program_id
      t.integer :song_id
      t.integer :playlist_position
    end
  end
end
