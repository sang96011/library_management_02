class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.string :follower_type
      t.string :followed_type

      t.timestamps
    end
  end
end
