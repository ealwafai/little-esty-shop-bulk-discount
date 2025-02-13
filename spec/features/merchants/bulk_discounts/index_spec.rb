require 'rails_helper'

RSpec.describe 'merchant discount index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @bulk_discount_1 = BulkDiscount.create!(name: 'BD 1', percentage: 10, threshold: 20, merchant: @merchant_1)
    @bulk_discount_2 = BulkDiscount.create!(name: 'BD 2', percentage: 20, threshold: 30, merchant: @merchant_1)
    @bulk_discount_3 = BulkDiscount.create!(name: 'BD 3', percentage: 30, threshold: 50, merchant: @merchant_1)
    @bulk_discount_4 = BulkDiscount.create!(name: 'BD 4', percentage: 50, threshold: 100, merchant: @merchant_2)

    visit merchant_bulk_discounts_path(@merchant_1)
  end

  it 'displays the names of all of the merchant discounts' do
   expect(page).to have_content(@bulk_discount_1.name)
   expect(page).to have_content(@bulk_discount_2.name)
   expect(page).to have_content(@bulk_discount_3.name)
   expect(page).to_not have_content(@bulk_discount_4.name)
 end

 it 'displays the percentages and quantity_thresholds of each discount' do
   within "tr#bulk_discount-#{@bulk_discount_1.id}" do
     expect(page).to have_content(@bulk_discount_1.percentage)
     expect(page).to have_content(@bulk_discount_1.threshold)
   end

   within "tr#bulk_discount-#{@bulk_discount_2.id}" do
     expect(page).to have_content(@bulk_discount_2.percentage)
     expect(page).to have_content(@bulk_discount_2.threshold)
   end
 end

 it 'displays a link to each discount show page' do
   within "tr#bulk_discount-#{@bulk_discount_1.id}" do
     click_on 'View Details'
   end
   expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
 end

 it 'displays the next 3 holidays' do
    within 'section#holidays' do
      expect(page).to have_content('Upcoming Holidays')
      expect(page).to have_content('Labor Day')
      expect(page).to have_content('2021-09-06')
      expect(page).to have_content("Columbus Day")
      expect(page).to have_content('2021-10-11')
      expect(page).to have_content('Veterans Day')
      expect(page).to have_content('2021-11-11')
      expect(page).to_not have_content('Thanksgiving Day')
    end
  end

  it 'displays a link to create a new discount' do
    expect(page).to have_link('Create New Discount')

    click_on 'Create New Discount'

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
  end

  it 'displays a delete link next to each bulk discount' do

    within "tr#bulk_discount-#{@bulk_discount_1.id}" do
      expect(page).to have_link('Remove')
    end

    within "tr#bulk_discount-#{@bulk_discount_2.id}" do
      expect(page).to have_link('Remove')
    end
  end

  it 'After clicking "Remove", merchant is redirected back to bulk discounts index page and the bulk discount is no longer listed' do

    within "tr#bulk_discount-#{@bulk_discount_1.id}" do
      click_link 'Remove'
    end

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
    expect(page).to_not have_content(@bulk_discount_1.name)
  end
end
