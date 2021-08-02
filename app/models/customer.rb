class Customer < ApplicationRecord
  has_many :invoices, :dependent => :destroy

  def self.top_five
    joins(invoices: :transactions)
    .where("transactions.result = ?", "success")
    .group(:id)
    .select("customers.*, count('transactions.result') as top")
    .order(top: :desc)
    .limit(5)
  end

  def successful_transactions
    invoices.joins(:transactions)
            .where('transactions.result = ?', 'success')
            .count
  end

  def self.top_five_customers_by_transactions(merchant_id)
  joins(invoices: [:transactions, :items])
  .where('result = ? and merchant_id = ?', "success", merchant_id)
  .select("customers.*, count('transactions.result') AS successful_transactions")
  .group("customers.id")
  .order(successful_transactions: :desc)
  .limit(5)
  end
end
