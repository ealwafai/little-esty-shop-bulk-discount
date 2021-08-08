require 'rails_helper'

RSpec.describe 'Edit discount page' do
  before :each do
    @merchant = create(:merchant)
    @bulk_discount = BulkDiscount.create!(name: 'Thanksgiving Day Discount', percentage: 10, threshold: 20, merchant: @merchant)

    visit edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
  end

  it 'displays a form with discount information that are pre populated' do
    expect(page).to have_field(:name, with: 'Thanksgiving Day Discount')
    expect(page).to have_field(:percentage, with: 10)
    expect(page).to have_field(:threshold, with: 20)
  end

  it 'merchant can edit any field and click on "Edit Discount" and get redirected back to the discount show page' do
    fill_in :name, with: 'Christmas Day Discount'

    click_on 'Edit Discount'

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount))
    expect(page).to_not have_content('Thanksgiving Day Discount')
    expect(page).to have_content('Christmas Day Discount')
    expect(page).to have_content(@bulk_discount.percentage)
    expect(page).to have_content(@bulk_discount.threshold)
  end
end
