require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end
  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  # before :each do
  #
  # end
  describe 'class methods' do
    before :each do
      @merchant_1 = create(:merchant, status: 'enabled')
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant, status: 'enabled')
      @merchant_4 = create(:merchant, status: 'enabled')
      @merchant_5 = create(:merchant, status: 'enabled')
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)
    end

    describe '.enabled' do
      it 'returns all merchants that are enabled' do
        expect(Merchant.enabled).to eq([@merchant_1, @merchant_3, @merchant_4, @merchant_5])
      end
    end

    describe '.disabled' do
      it 'returns all merchants that are disabled' do
          expect(Merchant.disabled).to eq([@merchant_2, @merchant_6, @merchant_7])
      end
    end
  end
  describe 'instance methods' do
    describe '#items_enabled' do
      it 'returns all merchants items with status enabled' do
        merchant_1 = create(:merchant, status: 'enabled')
        item_1 = create(:item, merchant: merchant_1, status: 'enabled')
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)
        expect(merchant_1.items_enabled).to eq([item_1])
      end
    end
    describe '#items_disabled' do
      it 'returns all merchants items with status disabled' do
        merchant_1 = create(:merchant, status: 'enabled')
        item_1 = create(:item, merchant: merchant_1, status: 'enabled')
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)
        expect(merchant_1.items_disabled).to eq([item_2, item_3])
      end
    end
    describe '#most_popular_items' do
      it 'returns merchants top 5 items by revenue' do
        merchant_1 = create(:merchant, status: 'enabled')
        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, status: 'completed')
        invoice_2 = create(:invoice, customer: customer, status: 'completed')
        item_1 = create(:item, merchant: merchant_1)
        item_2 = create(:item, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_1)
        item_4 = create(:item, merchant: merchant_1)
        item_5 = create(:item, merchant: merchant_1)
        item_6 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 1, unit_price: 5000)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 1, unit_price: 2000)
        invoice_item_3 = create(:invoice_item, invoice: invoice_1, item: item_3, quantity: 1, unit_price: 9000)
        invoice_item_4 = create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 1, unit_price: 4000)
        invoice_item_5 = create(:invoice_item, invoice: invoice_2, item: item_5, quantity: 1, unit_price: 1000)
        invoice_item_6 = create(:invoice_item, invoice: invoice_2, item: item_6, quantity: 1, unit_price: 3000)
        transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
        transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)

        expect(merchant_1.most_popular_items).to eq([item_3, item_1, item_4, item_6, item_2])
      end
    end
    describe '#items_top_day_revenue' do
      it 'returns merchants top date of sales for item' do
        merchant_1 = create(:merchant, status: 'enabled')
        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, status: 'completed', created_at: '2021-03-06 21:54:10 UTC')
        invoice_2 = create(:invoice, customer: customer, status: 'completed')
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 2, unit_price: 5000)
        invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: item_1, quantity: 1, unit_price: 2000)
        transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
        transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
        expect(merchant_1.items_top_day_revenue(item_1.id)).to eq(Time.parse('2021-03-06 21:54:10 UTC'))
      end
    end
  end
end
