class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy

  def self.enabled
    where(status: 'enabled')
  end

  def self.disabled
    where(status: 'disabled')
  end

  def self.top_five_by_revenue
    joins(items: [invoices: :transactions]).select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price/100.0) as revenue').where("transactions.result = 'success'").group('merchants.id').order('revenue DESC').limit(5)
  end
end
