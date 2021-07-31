require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

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
end
