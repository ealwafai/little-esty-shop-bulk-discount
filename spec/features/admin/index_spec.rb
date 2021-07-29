require 'rails_helper'

RSpec.describe 'Admin Deshboard/Index page' do
  it 'displays admin dashboard header' do
    visit admin_index_path
    expect(page).to have_content('Welcome to the Admin Dashboard')
  end

  it 'shows links to admin merchants and invocies index' do
    visit admin_index_path
    expect(page).to have_content('Merchants Index')
    # click_link 'Admin Merchants Index'
    # expect(current_path).to eq(admin_merchants_path)

    visit admin_index_path
    expect(page).to have_content('Invoices Index')
    # click_link 'Admin Invoices Index'
    # expect(current_path).to eq(admin_invoices_path)
  end
end