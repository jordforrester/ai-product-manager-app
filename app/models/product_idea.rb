class ProductIdea < ApplicationRecord
    belongs_to :user
    has_many :prds, dependent: :destroy
  
    # If you want to keep strict loading for other associations but allow lazy loading for prds
    self.strict_loading_by_default = true
    has_many :prds, dependent: :destroy, strict_loading: false
  
    # ... any other validations or methods ...
  end
