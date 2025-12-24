class CreateAiConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :ai_conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :conversation_type

      t.timestamps
    end
  end
end
