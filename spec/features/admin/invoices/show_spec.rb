require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @invoice_1 = create(:invoice, status: 'in progress')
    @item_1 = create(:item)
    @invoice_item_1 = InvoiceItem.create!(
      invoice: @invoice_1,
      item: @item_1,
      quantity: 1,
      status: 0,
      unit_price: 11111
    )
  end

  it 'shows information regarding the invoice' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.created_at_display)
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows invoice items and item information' do
    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price / 100)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'shows total revenue to be earned through invoice' do
    visit admin_invoice_path(@invoice_1)
    expect(page).to have_content('Total Projected Revenue: $111.11')
  end

  it 'displays select field with current invoice status selected' do
    visit admin_invoice_path(@invoice_1)
    expect(page).to have_content('Status:')
    expect(page).to have_select(selected: "#{@invoice_1.status.titleize}")
  end

  it 'can update status using select field' do
    visit admin_invoice_path(@invoice_1)
    expect(@invoice_1.status).to eq('in progress')
    select('Completed')
    click_button 'Update Invoice'
    @invoice_1.reload
    expect(@invoice_1.status).to eq('completed')
  end
end