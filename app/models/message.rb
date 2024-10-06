# app/models/message.rb
class Message < ApplicationRecord
    belongs_to :conversation
  
    validates :content, presence: true
    validates :role, presence: true, inclusion: { in: %w[user assistant] }
  
    # Add this line to use UUID
    self.implicit_order_column = "created_at"
  end