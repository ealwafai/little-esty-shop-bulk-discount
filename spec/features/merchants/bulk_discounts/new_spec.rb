require 'rails_helper'

RSpec.describe 'Merchant new discount page' do
  describe 'creation page' do
    it 'can create a new discount for the merchant' do
      merchant = create(:merchant)

      visit new_merchant_bulk_discount_path(merchant)

      fill_in :name, with: "Thanksgiving Day Discount"
      fill_in :percentage, with: 30
      fill_in :threshold, with: 20
      click_on 'Submit'

      expect(current_path).to eq(merchant_bulk_discounts_path(merchant))
      expect(page).to have_content(merchant.bulk_discounts.last.name)
      expect(page).to have_content(merchant.bulk_discounts.last.percentage)
      expect(page).to have_content(merchant.bulk_discounts.last.threshold)
    end
  end
end
