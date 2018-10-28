class CreateProgramTags < ActiveRecord::Migration[5.1]
  def change
    create_table :program_tags do |t|
      t.integer :program_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
