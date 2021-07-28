require 'rails_helper'

RSpec.describe 'admin merchants show page' do
  before :each do
    @merchants_1 = create(:merchant)
  end

  it 'links to merchant show page from index page' do
    visit admin_merchants_path

    click_link "#{@merchants_1.name}"

    expect(current_path).to eq(admin_merchant_path(@merchants_1))
  end

  it 'displays the merchant name' do
    visit admin_merchant_path(@merchants_1)

    expect(page).to have_content(@merchants_1.name)
  end
end
