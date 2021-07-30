require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    describe '::merchants_invoices' do
      it 'returns all invoices for a specific merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        customer_1 = create(:customer)
        customer_2 = create(:customer)

        item_1 = create(:item, merchant_id: merchant_1.id)
        item_2 = create(:item, merchant_id: merchant_1.id)
        item_3 = create(:item, merchant_id: merchant_2.id)

        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_2.id)
        invoice_4 = create(:invoice, customer_id: customer_2.id)

        invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
        invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id)
        invoice_item_4 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id)
        invoice_item_5 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_3.id)
        invoice_item_6 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_4.id)

        expect(Invoice.merchants_invoices(merchant_1.id)).to eq([invoice_1, invoice_2, invoice_3])
      end
    end
  end
  describe 'instance methods' do
    describe '#total_revenue' do
      it 'finds the revenue for all invoice items in a single invoice' do
        customer = create(:customer)
        invoice = create(:invoice, customer: customer)

        item_1 = create(:item)
        item_2 = create(:item)
        item_3 = create(:item)

        invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item_1.id, quantity: 5, unit_price: 20)
        invoice_item_2 = create(:invoice_item, invoice_id: invoice.id, item_id: item_2.id, quantity: 10, unit_price: 25)
        invoice_item_3 = create(:invoice_item, invoice_id: invoice.id, item_id: item_3.id, quantity: 15, unit_price: 30)

        expect(invoice.total_revenue).to eq(800)
      end
    end
  end
end
