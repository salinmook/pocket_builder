class Customer < ApplicationRecord
  belongs_to :store
  has_many :orders

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, uniqueness: { scope: :store_id, case_sensitive: false }
  validates :name, presence: true
end
