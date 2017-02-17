class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :image
      t.datetime :date_of_birth
      t.text :body

      t.timestamps
    end
  end
end
