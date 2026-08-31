class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true
  validates :phone, presence: true
  validates :address_line, presence: true

  before_save :ensure_single_default
  before_create :set_default_if_first

  private

  def ensure_single_default
    if is_default?
      customer.addresses.where.not(id: id).update_all(is_default: false)
    end
  end


  def set_default_if_first
    self.is_default = true if customer.addresses.count.zero?
  end
end
