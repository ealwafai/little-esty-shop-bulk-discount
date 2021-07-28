require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @invoice_1 = create(:invoice)
  end

  it 'shows information regarding the invoice' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime(" %A, %B %e, %Y"))
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows invoice items and item information' do
    visit admin_invoice_path(@invoice_1)

    # Price
    expect(page).to have_content()
    # Quantity
    expect(page).to have_content()
    # Price
    expect(page).to have_content()
    # Status
    expect(page).to have_content()
  end
  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
end