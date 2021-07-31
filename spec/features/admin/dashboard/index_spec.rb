require 'rails_helper'

RSpec.describe 'Admin Deshboard/Index page' do
  before :each do
    # Incomplete Invoices setup
    @customer = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer, status: 0)
    @invoice_2 = create(:invoice, customer: @customer, status: 0)
    @invoice_3 = create(:invoice, customer: @customer, status: 0)
    @invoice_4 = create(:invoice, customer: @customer, status: 0)
    @invoice_5 = create(:invoice, customer: @customer, status: 0)
    @inv_item_1 = create(:invoice_item, invoice: @invoice_1, status: 2)
    @inv_item_2 = create(:invoice_item, invoice: @invoice_2, status: 2)
    @inv_item_3 = create(:invoice_item, invoice: @invoice_3, status: 2)
    @inv_item_4 = create(:invoice_item, invoice: @invoice_4, status: 0)
    @inv_item_5 = create(:invoice_item, invoice: @invoice_5, status: 1)
  end

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
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    customer_4 = create(:customer)
    customer_5 = create(:customer)
    customer_6 = create(:customer)

    Customer.all.each do |customer|
      create_list(:invoice, 1, customer: customer)
    end

    create_list(:transaction, 2, result: 'failed', invoice: customer_1.invoices.first)
    create_list(:transaction, 2, result: 'success', invoice: customer_2.invoices.first)
    create_list(:transaction, 3, result: 'success', invoice: customer_3.invoices.first)
    create_list(:transaction, 4, result: 'success', invoice: customer_4.invoices.first)
    create_list(:transaction, 5, result: 'success', invoice: customer_5.invoices.first)
    create_list(:transaction, 6, result: 'success', invoice: customer_6.invoices.first)
    
    visit admin_index_path
    expect(page).to have_content("Top 5 Customers")
    
    within("#top_five") do
      expect(customer_6.first_name).to appear_before(customer_5.first_name)
      expect(page).to_not have_content(customer_1.first_name)
    end
  end

  it 'displays incomplete invoices' do
    visit admin_index_path
    expect(page).to have_content('Incomplete Invoices')

    within("#incomplete_invoices") do
      expect(page).to_not have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_5.id)
    end
  end
  
  it 'links to invoice show pages through their IDs' do
    visit admin_index_path

    within("#incomplete_invoices") do
      click_link "#{@invoice_4.id}"
    end

    expect(current_path).to eq(admin_invoice_path(@invoice_4))
  end

  it 'displays creation dates of invoices ordered oldest to newest' do
    # inv_id_1 = "ID: #{@invoice_4.id}"
    # inv_id_2 = "ID: #{@invoice_5.id}"

    visit admin_index_path

    within("#incomplete_invoices") do
      expect(page).to have_content("Date: #{@invoice_4.created_at_display}")
      expect(page).to have_content("Date: #{@invoice_5.created_at_display}")
      save_and_open_page
      expect().to appear_before()
    end
  end
  # In the section for "Incomplete Invoices",
  # Next to each invoice id I see the date that the invoice was created
  # And I see the date formatted like "Monday, July 18, 2019"
  # And I see that the list is ordered from oldest to newest
end