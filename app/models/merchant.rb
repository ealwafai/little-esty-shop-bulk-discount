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

  def items_enabled
    items.status_enabled
  end

  def items_disabled
    items.status_disabled
  end

  def most_popular_items
    items.popular_items
  end

  def items_top_day_revenue(item_id)
    items.item_top_day(item_id)
  end
end
