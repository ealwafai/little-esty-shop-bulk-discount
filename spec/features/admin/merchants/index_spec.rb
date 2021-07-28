require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchants_1 = create(:merchant)
    @merchants_2 = create(:merchant)
    @merchants_3 = create(:merchant)
    @merchants_4 = create(:merchant)
  end

  it 'displays all of the merchants' do
    visit admin_merchants_path

    expect(page).to have_content(@merchants_1.name)
    expect(page).to have_content(@merchants_2.name)
    expect(page).to have_content(@merchants_3.name)
    expect(page).to have_content(@merchants_4.name)
  end
 #should this live in the show or index spec
  it 'links to merchant show page from in' do
    visit admin_merchants_path

    click_link "#{@merchants_1.name}"

    expect(current_path).to eq(admin_merchant_path)
  end
end
