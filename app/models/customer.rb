class Customer < ApplicationRecord
  belongs_to :store
  has_many :orders
  has_many :addresses, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, uniqueness: { scope: :store_id, case_sensitive: false }
  validates :name, presence: true
end
