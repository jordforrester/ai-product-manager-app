class ProductIdea < ApplicationRecord
    belongs_to :user
    has_many :prds, dependent: :destroy
  
    validates :title, presence: true
    validates :description, presence: true
    validates :status, presence: true
    validates :customer_acv, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
    validates :customer_impact, presence: true, allow_blank: true
    validates :tshirt_size_effort, presence: true, allow_blank: true

    # Add this line to use UUID
    self.implicit_order_column = "created_at"
  
    # If you want to keep strict loading for other associations but allow lazy loading for prds
    #self.strict_loading_by_default = true
    has_many :prds, dependent: :destroy, strict_loading: false
  end
