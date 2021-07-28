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
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
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
