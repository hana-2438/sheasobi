class CreatePostFacilities < ActiveRecord::Migration[6.1]
  def change
    create_table :post_facilities do |t|
      t.integer :facility_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
