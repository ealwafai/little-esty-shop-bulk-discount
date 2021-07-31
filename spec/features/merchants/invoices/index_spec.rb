require 'rails_helper'

RSpec.describe 'Merchant Invoices index page' do
  it 'see all of the invoices that include at least one of my merchants items' do
    #   Merchant Invoices Index
    #
    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    item_3 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id)
    invoice_3 = create(:invoice, customer_id: customer_2.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id)

    visit "/merchants/#{merchant.id}/invoices"

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_link("Invoice ##{invoice_1.id}")
    expect(page).to have_content(invoice_2.id)
    expect(page).to have_link("Invoice ##{invoice_2.id}")
    expect(page).to have_content(invoice_3.id)
    expect(page).to have_link("Invoice ##{invoice_3.id}")
  end
end
