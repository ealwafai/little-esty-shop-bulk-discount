require 'rails_helper'

RSpec.describe 'admin merchants edit page' do
  before :each do
    @merchants_1 = create(:merchant)
  end

  it 'admin merchant show page has link to edit page' do
    visit admin_merchant_path(@merchants_1)

    click_link 'Update Merchant'

    expect(current_path).to eq(edit_admin_merchant_path(@merchants_1))
  end

  it 'displays form with existing merchant attributes' do
    visit edit_admin_merchant_path(@merchants_1)
    save_and_open_page
    expect(page).to have_content("#{@merchants_1.name}")
  end

  it 'updates merchant info from form' do
    visit edit_admin_merchant_path(@merchants_1)

    fill_in 'Name', with: 'Chuck Norris'
    click_button('Submit')

    expect(current_path).to eq(admin_merchant_path(@merchants_1))
    expect(page).to have_content('Chuck Norris')
  end
end
