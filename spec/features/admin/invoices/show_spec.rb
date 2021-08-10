require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @merchant = create(:merchant)

    @customer = create(:customer)

    @invoice = create(:invoice, status: 'in progress', customer_id: @customer.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)
    @item_3 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10000, item_id: @item_1.id, invoice_id: @invoice.id, status: 1)
    @invoice_item_2 = create(:invoice_item, quantity: 5 , unit_price: 5000, item_id: @item_2.id, invoice_id: @invoice.id, status: 1)
    @invoice_item_3 = create(:invoice_item, quantity: 15 , unit_price: 4000, item_id: @item_3.id, invoice_id: @invoice.id, status: 1)

    @bulk_discount = BulkDiscount.create!(name: 'BD 2', percentage: 15, threshold: 10, merchant: @merchant)

    visit admin_invoice_path(@invoice)
  end

  it 'shows information regarding the invoice' do
    expect(page).to have_content(@invoice.id)
    expect(page).to have_content(@invoice.created_at_display)
    expect(page).to have_content(@invoice.customer.first_name)
    expect(page).to have_content(@invoice.customer.last_name)
  end

  it 'shows invoice items and item information' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price / 100)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'displays select field with current invoice status selected' do
    expect(page).to have_content('Status:')
    expect(page).to have_select(selected: "#{@invoice.status.titleize}")
  end

  it 'can update status using select field' do
    expect(@invoice.status).to eq('in progress')
    select('Completed')
    click_button 'Update Invoice'
    @invoice.reload
    expect(@invoice.status).to eq('completed')
  end

  it 'shows total revenue to be earned through invoice' do
    expect(page).to have_content("Total Projected Revenue: $#{@invoice.total_revenue}")
  end

  it 'displays total discoutned revenue to be earned through invoice' do
    expect(page).to have_content("Total Discounted Revenue: $#{@invoice.total_discounted_revenue}")
  end
end
