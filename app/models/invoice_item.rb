class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  enum status: [ :pending, :packaged, :shipped ]

  def price_display
    unit_price / 100.00
  end

  def revenue_full_price
    (unit_price * quantity) / 100.00
  end

  def ii_discount
    item.merchant.bulk_discounts.where('threshold <= ?', quantity).order(:percentage).last
  end

  def revenue_with_discount
    if ii_discount.present?
    (revenue_full_price * (1 - (ii_discount.percentage / 100.00))).round(2)
    else
      revenue_full_price
    end
  end
end
