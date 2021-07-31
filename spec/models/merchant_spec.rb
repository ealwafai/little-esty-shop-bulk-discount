require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  before :each do
    @merchant_1 = create(:merchant, status: 'enabled')
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant, status: 'enabled')
    @merchant_4 = create(:merchant, status: 'enabled')
    @merchant_5 = create(:merchant, status: 'enabled')
    @merchant_6 = create(:merchant)
    @merchant_7 = create(:merchant)

    @item_1 = create(:item, unit_price: 12000, merchant_id: @merchant_1.id)
    @item_2 = create(:item, unit_price: 10100, merchant_id: @merchant_1.id)
    @item_3 = create(:item, unit_price: 5000, merchant_id: @merchant_3.id)
    @item_4 = create(:item, unit_price: 7500, merchant_id: @merchant_3.id)
    @item_5 = create(:item, unit_price: 9000, merchant_id: @merchant_4.id)
    @item_6 = create(:item, unit_price: 8500, merchant_id: @merchant_4.id)
    @item_7 = create(:item, unit_price: 10000, merchant_id: @merchant_5.id)
    @item_8 = create(:item, unit_price: 7500, merchant_id: @merchant_5.id)
    @item_9 = create(:item, unit_price: 11500, merchant_id: @merchant_6.id)
    @item_10 = create(:item, unit_price: 10000, merchant_id: @merchant_7.id)

    @invoice_1 = create(:invoice)
    @invoice_2 = create(:invoice)
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
    @invoice_6 = create(:invoice)

    @transactions_1 = create(:transaction, invoice_id: @invoice_1.id)
    @transactions_2 = create(:transaction, invoice_id: @invoice_2.id)
    @transactions_3 = create(:transaction, invoice_id: @invoice_3.id)
    @transactions_4 = create(:transaction, invoice_id: @invoice_4.id)
    @transactions_5 = create(:transaction, invoice_id: @invoice_5.id)
    @transactions_6 = create(:transaction, invoice_id: @invoice_6.id)

    @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 12000, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10100, item_id: @item_2.id, invoice_id: @invoice_1.id)
    @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 20000, item_id: @item_10.id, invoice_id: @invoice_2.id)
    @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item_id: @item_4.id, invoice_id: @invoice_3.id)
    @invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item_id: @item_3.id, invoice_id: @invoice_4.id)
    @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 9000, item_id: @item_5.id, invoice_id: @invoice_5.id)
    @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 23000, item_id: @item_9.id, invoice_id: @invoice_6.id)
  end

  describe 'class methods' do
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

    describe '.top_five_by_revenue' do
      it 'returns the top 5 merchants by revenue' do
        expect(Merchant.top_five_by_revenue).to eq([@merchant_3, @merchant_6, @merchant_7, @merchant_1, @merchant_4])
      end
    end
  end
end
