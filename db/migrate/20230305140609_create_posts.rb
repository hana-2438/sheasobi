class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member_id, null: false
      t.integer :tag_id, null: false
      t.integer :region_id, null: false
      t.string :title, null: false
      t.string :place, null: false
      t.text :caption, null: false
      t.timestamps
    end
  end
end
