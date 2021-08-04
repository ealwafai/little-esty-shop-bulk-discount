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
end
