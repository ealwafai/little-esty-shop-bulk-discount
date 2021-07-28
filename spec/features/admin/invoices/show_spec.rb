require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @invoice_1 = create(:invoice)
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
    expect(page).to have_content(@invoice_1.created_at.strftime(" %A, %B %e, %Y"))
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
    expect(page).to have_select(selected: 'Cancelled')
  end

  xit 'can update status using select field' do
    visit admin_invoice_path(@invoice_1)
    select('Completed', :from => 'Select Box')
  end
  # When I click this select field,
  # Then I can select a new status for the Invoice,
  # And next to the select field I see a button to "Update Invoice Status"
  # When I click this button
  # I am taken back to the admin invoice show page
  # And I see that my Invoice's status has now been updated
end