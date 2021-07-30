class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  enum status: [ 'in progress', :completed, :cancelled ]

  validates :status, presence: true

  def self.merchants_invoices(merch_id)
    joins(:items).where('merchant_id = ?', merch_id).select("invoices.*").distinct
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end
end
