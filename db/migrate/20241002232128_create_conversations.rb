class CreateConversations < ActiveRecord::Migration[7.2]
  def change
    create_table :conversations, id: :uuid do |t|
      t.references :prd, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
