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
      it 'calculates total revenue for invoice' do
        invoice = create(:invoice)
        item1 = create(:item)
        item2 = create(:item)
        invoice_item1 = InvoiceItem.create!(
          invoice: invoice,
          item: item1,
          quantity: 1,
          unit_price: 100
        )
        invoice_item2 = InvoiceItem.create!(
          invoice: invoice,
          item: item2,
          quantity: 1,
          unit_price: 100
        )
        expect(invoice.total_revenue).to eq(2)
      end

      it 'displays creation time in humanized format' do
        invoice = create(:invoice, created_at: 'Wed, 28 Jul 2021 21:49:20 UTC +00:00')
        expect(invoice.created_at_display).to eq('Wednesday, July 28, 2021')
      end
    end
  end
end
