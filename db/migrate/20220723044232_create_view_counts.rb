class CreateViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :view_counts do |t|
      t.integer :book_id, null: false
      t.integer :view_qty, null:false
      t.timestamps
    end
  end
end
