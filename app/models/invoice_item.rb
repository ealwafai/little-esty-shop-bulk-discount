class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: [ :pending, :packaged, :shipped ]

  def price_display
    unit_price / 100.00
  end
end
