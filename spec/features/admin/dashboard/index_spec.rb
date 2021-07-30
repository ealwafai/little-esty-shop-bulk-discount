require 'rails_helper'

RSpec.describe 'Admin Deshboard/Index page' do
  it 'displays admin dashboard header' do
    visit admin_index_path
    expect(page).to have_content('Welcome to the Admin Dashboard')
  end

  it 'shows links to admin merchants and invocies index' do
    visit admin_index_path
    expect(page).to have_content('Merchants Index')
    click_link 'Admin Merchants Index'
    expect(current_path).to eq(admin_merchants_path)
    
    visit admin_index_path
    expect(page).to have_content('Invoices Index')
    click_link 'Admin Invoices Index'
    expect(current_path).to eq(admin_invoices_path)
  end

  it 'shows top 5 customer names along with successful transactions' do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    Customer.all.each do |customer|
      create_list(:invoice, 1, customer: customer)
    end

    create_list(:transaction, 2, result: 'failed', invoice: @customer_1.invoices.first)
    create_list(:transaction, 2, result: 'success', invoice: @customer_2.invoices.first)
    create_list(:transaction, 3, result: 'success', invoice: @customer_3.invoices.first)
    create_list(:transaction, 4, result: 'success', invoice: @customer_4.invoices.first)
    create_list(:transaction, 5, result: 'success', invoice: @customer_5.invoices.first)
    create_list(:transaction, 6, result: 'success', invoice: @customer_6.invoices.first)
    
    visit admin_index_path
    expect(page).to have_content("Top 5 Customers")
    
    within("#top_five") do
      expect(@customer_6.first_name).to appear_before(@customer_5.first_name)
    end
  end

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