class Coupon < ApplicationRecord
  belongs_to :store


  VALID_TYPES = %w[percentage fixed_amount free_shipping].freeze

  validates :code, presence: true, uniqueness: { scope: :store_id, case_sensitive: false }
  validates :discount_type, inclusion: { in: VALID_TYPES }
  validates :discount_value, presence: true, numericality: { greater_than: 0 }, unless: -> { discount_type == "free_shipping" }

  before_validation { self.code = code.to_s.strip.upcase }
  before_save :normalize_dates

  def valid_now?
    return false unless active
    return false if starts_at.present? && starts_at > Time.current
    return false if ends_at.present? && ends_at < Time.current
    return false if usage_limit.present? && usage_count >= usage_limit
    true
  end

  def meets_minimum?(order_total)
    minimum_order_amount.blank? || order_total >= minimum_order_amount
  end

  def discount_amount(order_total)
    return 0 unless valid_now? && meets_minimum?(order_total)
    case discount_type
    when "percentage"
      (order_total * discount_value / 100).round(2)
    when "fixed_amount"
      [discount_value, order_total].min 
    when "free_shipping"
      0 
    else
      0
    end
  end

  private

  def normalize_dates
    self.starts_at = starts_at.beginning_of_day if starts_at.present?
    self.ends_at = ends_at.end_of_day if ends_at.present?
  end

end 
