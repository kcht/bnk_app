class AddPicturePathToProgram < ActiveRecord::Migration[5.1]
  def change
    add_column :programs, :picture_path, :string
  end
end
