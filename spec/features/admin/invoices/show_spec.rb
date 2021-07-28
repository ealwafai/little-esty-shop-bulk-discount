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
end