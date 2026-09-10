class Store < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :about_images
  has_many :categories, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :customers, dependent: :destroy
  
  validates :name, presence: true
  validate :about_images_limit

  private

  def about_images_limit
    if about_images.attached? && about_images.count > 3
      errors.add(:about_images, "can have at most 3 images")
    end
  end
end
