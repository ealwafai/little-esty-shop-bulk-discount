class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items

  def self.status_enabled
    where(status: 'enabled')
  end

  def self.status_disabled
    where(status: 'disabled')
  end

  def self.ready_to_ship
    select('items.*, invoices.id, invoices.created_at, transactions.result')
    .joins(invoices: :transactions)
    .where("transactions.result = ?", 'success')
    .where.not("invoice_items.status = ?", 2)
    .order('invoices.created_at')
  end

  def unit_price_dollars
    unit_price / 100.0
  end
end
