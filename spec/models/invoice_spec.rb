require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  # before :each do
  #
  # end
  
  describe 'class methods' do
    describe '::incomplete_invoices' do
      it 'retrieves invoices with unshipped items, ordered by creation date' do
        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, status: 0)
        invoice_2 = create(:invoice, customer: customer, status: 0)
        invoice_3 = create(:invoice, customer: customer, status: 0)
        invoice_4 = create(:invoice, customer: customer, status: 0)
        invoice_5 = create(:invoice, customer: customer, status: 0)
        inv_item_1 = create(:invoice_item, invoice: invoice_1, status: 2)
        inv_item_2 = create(:invoice_item, invoice: invoice_2, status: 2)
        inv_item_3 = create(:invoice_item, invoice: invoice_3, status: 2)
        inv_item_4 = create(:invoice_item, invoice: invoice_4, status: 0)
        inv_item_5 = create(:invoice_item, invoice: invoice_5, status: 1)
        invoice_list = [invoice_4, invoice_5]

        expect(Invoice.incomplete_invoices).to eq(invoice_list)
        expect(Invoice.incomplete_invoices[0]).to eq(invoice_4)
        expect(Invoice.incomplete_invoices[1]).to eq(invoice_5)
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
