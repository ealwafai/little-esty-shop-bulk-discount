require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'class methods' do
    describe '::top_five_customers_by_transactions' do
      it 'returns the top 5 customers with largest number of successful transactions' do
        merchant = create(:merchant)

        item = create(:item, merchant_id: merchant.id)

        customer_1 = create(:customer)
        customer_2 = create(:customer)
        customer_3 = create(:customer)
        customer_4 = create(:customer)
        customer_5 = create(:customer)
        customer_6 = create(:customer)
        customer_7 = create(:customer)

        invoice_1 = create(:invoice, customer: customer_1)
        invoice_2 = create(:invoice, customer: customer_2)
        invoice_3 = create(:invoice, customer: customer_3)
        invoice_4 = create(:invoice, customer: customer_4)
        invoice_5 = create(:invoice, customer: customer_5)
        invoice_6 = create(:invoice, customer: customer_6)
        invoice_7 = create(:invoice, customer: customer_7)

        transaction_1 = create(:transaction, invoice: invoice_1)
        transaction_2 = create(:transaction, invoice: invoice_1)
        transaction_4 = create(:transaction, invoice: invoice_2)
        transaction_4 = create(:transaction, invoice: invoice_2)
        transaction_5 = create(:transaction, invoice: invoice_2)
        transaction_6 = create(:transaction, invoice: invoice_2)
        transaction_8 = create(:transaction, invoice: invoice_3)
        transaction_8 = create(:transaction, invoice: invoice_3)
        transaction_9 = create(:transaction, invoice: invoice_3)
        transaction_10 = create(:transaction, invoice: invoice_3)
        transaction_11 = create(:transaction, invoice: invoice_3)
        transaction_12 = create(:transaction, invoice: invoice_4)
        transaction_13 = create(:transaction, invoice: invoice_5)
        transaction_14 = create(:transaction, invoice: invoice_6)
        transaction_15 = create(:transaction, invoice: invoice_6)
        transaction_16 = create(:transaction, invoice: invoice_6)
        transaction_17 = create(:transaction, invoice: invoice_7)
        transaction_18 = create(:transaction, invoice: invoice_7)
        transaction_19 = create(:transaction, invoice: invoice_7)
        transaction_20 = create(:transaction, invoice: invoice_7)
        transaction_21 = create(:transaction, invoice: invoice_7)
        transaction_22 = create(:transaction, invoice: invoice_7)

        invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice_1.id)
        invoice_item_2 = create(:invoice_item, item_id: item.id, invoice_id: invoice_2.id)
        invoice_item_3 = create(:invoice_item, item_id: item.id, invoice_id: invoice_3.id)
        invoice_item_4 = create(:invoice_item, item_id: item.id, invoice_id: invoice_4.id)
        invoice_item_5 = create(:invoice_item, item_id: item.id, invoice_id: invoice_5.id)
        invoice_item_6 = create(:invoice_item, item_id: item.id, invoice_id: invoice_6.id)
        invoice_item_7 = create(:invoice_item, item_id: item.id, invoice_id: invoice_7.id)

        expected = [customer_7, customer_3, customer_2, customer_6, customer_1]

        expect(Customer.top_five_customers_by_transactions(merchant.id)).to eq(expected)
      end
    end
  end
end
