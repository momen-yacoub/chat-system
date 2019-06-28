class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :messages_count, default: 0
      t.integer :chat_number
      t.references :application, foreign_key: true
    end
  end
end
