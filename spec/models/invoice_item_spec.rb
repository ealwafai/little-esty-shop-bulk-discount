require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)
      @invoice = create(:invoice)
      @item = create(:item, merchant: @merchant)
      @invoice_item = InvoiceItem.create!(
        invoice: @invoice,
        item: @item,
        quantity: 15,
        unit_price: 11111,
        status: 0
      )
      @bulk_discount_1 = BulkDiscount.create!(name: 'BD 1', percentage: 10, threshold: 5, merchant: @merchant)
      @bulk_discount_2 = BulkDiscount.create!(name: 'BD 2', percentage: 15, threshold: 10, merchant: @merchant)
      @bulk_discount_3 = BulkDiscount.create!(name: 'BD 3', percentage: 20, threshold: 15, merchant: @merchant)
    end

    describe '#price_display' do
      it 'displays unit_price in dollar amount' do
        expect(@invoice_item.price_display).to eq(111.11)
      end
    end

    describe '#revenue_full_price' do
      it 'returns the revenue for an invoice item with no discounts' do
        expect(@invoice_item.revenue_full_price).to eq(1666.65)
      end
    end

    describe '#ii_discount' do
      it 'returns the discount for an invoice_item' do
        expect(@invoice_item.ii_discount).to eq(@bulk_discount_3)
      end
    end

    describe '#revenue_with_discount' do
      it 'returns the revenue for invoice_item that includes discounts' do
        expect(@invoice_item.revenue_with_discount).to eq(1333.32)
      end
    end
  end
end
