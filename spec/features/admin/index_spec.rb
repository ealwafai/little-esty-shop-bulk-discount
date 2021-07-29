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

  xit 'shows top 5 customer names along with successful transactions' do
    visit admin_index_path
  end
  # When I visit the admin dashboard
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions
  # And next to each customer name I see the number of successful transactions
  # they have conducted

  xit 'displays incomplete invoices' do
    visit admin_index_path
  end
  # When I visit the admin dashboard
  # Then I see a section for "Incomplete Invoices"
  # In that section I see a list of the ids of all invoices
  # That have items that have not yet been shipped
  # And each invoice id links to that invoice's admin show page

  xit 'links to invoice show pages through their IDs' do
    visit admin_index_path
  end

  xit 'displays creation dates of invoices ordered oldest to newest' do
    visit admin_index_path
  end
  # When I visit the admin dashboard
  # In the section for "Incomplete Invoices",
  # Next to each invoice id I see the date that the invoice was created
  # And I see the date formatted like "Monday, July 18, 2019"
  # And I see that the list is ordered from oldest to newest
end