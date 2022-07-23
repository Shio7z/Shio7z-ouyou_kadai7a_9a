class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :users, null: false #自動でuser_idを作成、リレーションをはる
      t.integer :partner_id, null: false #チャット相手
      t.string :message, null: false
      t.timestamps
    end
  end
end
