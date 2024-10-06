class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :product_domain
  has_many :product_documents
  has_many_attached :product_documents
  has_many :product_ideas  # Add this line

  accepts_nested_attributes_for :product_domain


  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :company, presence: true
end
