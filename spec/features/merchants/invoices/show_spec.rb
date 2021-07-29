require 'rails_helper'

RSpec.describe 'Merchant Invoices show page' do
#   Merchant Invoice Show Page
#
# As a merchant
# When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
# Then I see information related to that invoice including:
# - Invoice id
# - Invoice status
# - Invoice created_at date in the format "Monday, July 18, 2019"
# - Customer first and last name
  before :each do
    @merchant = create(:merchant)

    @customer = create(:customer)

    @invoice = create(:invoice, customer_id: @customer.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice.id, status: 1)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice.id, status: 1)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  it 'can see all of that merchants invoice info' do
    expect(page).to have_content("Invoice ##{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created On: #{@invoice.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  # Merchant Invoice Show Page: Invoice Item Information
  #
  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see all of my items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
  # And I do not see any information related to Items for other merchants

  it "displays the invoice item information such as the item name, quantity ordered, price of item, invoice item status" do
    within "#invoice_item-info-#{@invoice_item_1.id}" do
      expect(page).to have_content("Invoice item name: #{@item_1.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_1.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_1.unit_price}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")
    end

    within "#invoice_item-info-#{@invoice_item_2.id}" do
      expect(page).to have_content("Invoice item name: #{@item_2.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_2.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_2.unit_price}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_2.status}")
    end
  end

  # Merchant Invoice Show Page: Total Revenue
  #
  # As a merchant
  # When I visit my merchant invoice show page
  # Then I see the total revenue that will be generated from all of my items on the invoice


  it "displays the total revenue from all items on the invoice" do
    expect(page).to have_content("Total revenue from invoice: #{@invoice.total_revenue}")
  end
end
