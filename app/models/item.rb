class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items

  def self.status_enabled
    where(status: 'enabled')
  end

  def self.status_disabled
    where(status: 'disabled')
  end

  def unit_price_dollars
    unit_price / 100.0
  end
end
