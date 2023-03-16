class CreateReadCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :read_counts do |t|
      t.integer :member_id
      t.integer :post_id

      t.timestamps
    end
  end
end
