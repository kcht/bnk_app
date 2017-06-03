class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.integer :number
      t.string :name
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
