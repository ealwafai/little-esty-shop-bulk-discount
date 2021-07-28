class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  enum status: [ 'in progress', :completed, :cancelled ]

  def total_revenue
    invoice_items.sum("unit_price * quantity") / 100.00
  end
end
