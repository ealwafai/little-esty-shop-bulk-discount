require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  before :each do
    @item_1 = create(:item, status: 'enabled')
    @item_2 = create(:item)
    @item_3 = create(:item)
  end

  describe 'class methods' do
    describe '.status_enabled' do
      it 'returns all items with status enabled' do
        expect(Item.status_enabled).to eq([@item_1])
      end
    end
    describe '.status_disabled' do
      it 'returns all items with status disabled' do
        expect(Item.status_disabled).to eq([@item_2, @item_3])
      end
    end
    describe '.ready_to_ship' do
      it 'returns all items with invoice status pending' do
        customer = create(:customer)

        invoice_1 = create(:invoice, customer: customer, status: 'in progress')
        invoice_2 = create(:invoice, customer: customer, status: 'in progress')
        invoice_3 = create(:invoice, customer: customer, status: 'in progress')
        invoice_4 = create(:invoice, customer: customer, status: :cancelled)
        invoice_5 = create(:invoice, customer: customer, status: 'in progress')
        invoice_6 = create(:invoice, customer: customer, status: 'in progress')
        invoice_7 = create(:invoice, customer: customer, status: 'in progress')
        invoice_8 = create(:invoice, customer: customer, status: :completed)

        transaction_1 = create(:transaction, invoice: invoice_1)
        transaction_2 = create(:transaction, invoice: invoice_2)
        transaction_3 = create(:transaction, invoice: invoice_3)
        transaction_4 = create(:transaction, invoice: invoice_4, result: 'failed')
        transaction_5 = create(:transaction, invoice: invoice_5)
        transaction_6 = create(:transaction, invoice: invoice_6, result: 'failed')
        transaction_7 = create(:transaction, invoice: invoice_7)
        transaction_8 = create(:transaction, invoice: invoice_8)

        invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: invoice_1.id, status: :packaged)
        invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: invoice_2.id, status: :packaged)
        invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: invoice_3.id, status: :packaged)
        invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: invoice_4.id, status: :packaged)
        invoice_item_5 = create(:invoice_item, item_id: @item_2.id, invoice_id: invoice_5.id, status: :packaged)
        invoice_item_6 = create(:invoice_item, item_id: @item_3.id, invoice_id: invoice_6.id, status: :packaged)
        invoice_item_7 = create(:invoice_item, item_id: @item_1.id, invoice_id: invoice_7.id, status: :packaged)
        invoice_item_8 = create(:invoice_item, item_id: @item_2.id, invoice_id: invoice_8.id, status: :shipped)
        # binding.pry
        expect(Item.ready_to_ship.first).to eq(@item_1)
      end
    end
  end

  describe 'instance methods' do
    describe '#unit_price_dollars' do
      it 'converts unit price to dollars' do
        item = create(:item, unit_price: 1250)
        expect(item.unit_price_dollars).to eq(12.5)
      end
    end
  end
end
