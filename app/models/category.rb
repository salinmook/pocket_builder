class Category < ApplicationRecord
  belongs_to :store

  has_many :products
  validates :name, presence: true
end
