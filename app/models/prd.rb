class Prd < ApplicationRecord
  belongs_to :product_idea
  has_many :conversations, dependent: :destroy

  validates :status, presence: true
  validates :title, presence: true

  # If you want to keep strict loading for other associations but allow lazy loading for product_idea
  self.strict_loading_by_default = true
  belongs_to :product_idea, strict_loading: false

  # Add this line to use UUID
  self.implicit_order_column = "created_at"

  # Add this line to set a default status if none is provided
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= 'pending'
  end
end
