require 'rails_helper'

RSpec.describe 'Discount show page' do
  it 'displays the discount threshold for number of items to be purchased and the percentage off' do
    merchant = create(:merchant)
    bulk_discount = BulkDiscount.create!(name: 'BD 1', percentage: 10, threshold: 20, merchant: merchant)

    visit merchant_bulk_discount_path(merchant, bulk_discount)

    expect(page).to have_content(bulk_discount.name)
    expect(page).to have_content("Percentage Discounted: #{bulk_discount.percentage}%")
    expect(page).to have_content("Number of Items for Eligibility: #{bulk_discount.threshold}+")
  end
end
