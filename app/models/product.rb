class Product < ApplicationRecord
  belongs_to :store
  belongs_to :category, optional: true
  has_many_attached :images

  validates :title, presence: true
  validates :price, presence: true
  validate :maximum_images

  private

  def maximum_images
    if images.attachments.size > 5
      errors.add(:images, "maximum 5 images allowed")
    end
  end
end
