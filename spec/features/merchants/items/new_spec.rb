require 'rails_helper'
RSpec.describe 'New Item Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')

    visit new_merchant_item_path(@merchant)
  end
  it 'can enter information and submit to be redirected to merchant item index and can see new item' do
    fill_in(:name, with: 'Lotion')
    fill_in(:description, with: 'aloe body lotion')
    fill_in(:unit_price, with: 6.50)
    click_button('Submit')

    expect(current_path).to eq(merchant_items_path(@merchant))

    expect(page).to have_content('Lotion')
    expect(page).to have_button('Enable')
  end
end
