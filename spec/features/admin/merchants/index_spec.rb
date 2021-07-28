require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = create(:merchant, status: 'enabled')
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant, status: 'enabled')
    @merchant_4 = create(:merchant)
  end

  it 'displays all of the merchants' do
    visit admin_merchants_path

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
  end

  it 'displays a button to endable merchant with disabled status and update status' do
    visit admin_merchants_path

    within ("#merchant-#{@merchant_2.id}") do
      click_button('Enable')
    end

    expect(current_path).to eq(admin_merchants_path)

    within ("#merchant-#{@merchant_2.id}") do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end
  end

  it 'displays a button to disable merchant with enabled status and update status' do
    visit admin_merchants_path

    within ("#merchant-#{@merchant_1.id}") do
      click_button('Disable')
    end

    expect(current_path).to eq(admin_merchants_path)

    within ("#merchant-#{@merchant_1.id}") do
      expect(page).to_not have_button('Disable')
      expect(page).to have_button('Enable')
    end
  end

  it 'groups merchants by status' do
    visit admin_merchants_path

    within ("#enabled") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_3.name)
    end

    within ("#disabled") do
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_4.name)
    end
  end
end
