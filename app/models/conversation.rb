# app/models/conversation.rb
class Conversation < ApplicationRecord
    belongs_to :prd
    has_many :messages, dependent: :destroy
  
    validates :prd, presence: true
  
    # Add this line to use UUID
    self.implicit_order_column = "created_at"
  end
  
