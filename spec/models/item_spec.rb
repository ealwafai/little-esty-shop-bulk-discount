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
