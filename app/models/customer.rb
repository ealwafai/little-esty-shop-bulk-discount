class Customer < ApplicationRecord
  has_many :invoices, :dependent => :destroy

  def self.top_five_customers_by_transactions(merchant_id)
    joins(invoices: [:transactions, :items])
    .where('result = ? and merchant_id = ?', "success", merchant_id)
    .select("customers.*, count('transactions.result') AS successful_transactions")
    .group("customers.id")
    .order(successful_transactions: :desc)
    .limit(5)
  end
end
