require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1 = create(:merchant, status: 'enabled')
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant, status: 'enabled')
    @merchant_4 = create(:merchant)
  end

  it 'displays all of the merchants' do
    visit admin_merchants_path

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
  end

  it 'displays a button to endable merchant with disabled status and update status' do
    visit admin_merchants_path

    within ("#merchant-#{@merchant_2.id}") do
      click_button('Enable')
    end

    expect(current_path).to eq(admin_merchants_path)

    within ("#merchant-#{@merchant_2.id}") do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end
  end

  it 'displays a button to disable merchant with enabled status and update status' do
    visit admin_merchants_path

    within ("#merchant-#{@merchant_1.id}") do
      click_button('Disable')
    end

    expect(current_path).to eq(admin_merchants_path)

    within ("#merchant-#{@merchant_1.id}") do
      expect(page).to_not have_button('Disable')
      expect(page).to have_button('Enable')
    end
  end

  it 'groups merchants by status' do
    visit admin_merchants_path

    within ("#enabled") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_3.name)
    end

    within ("#disabled") do
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_4.name)
    end
  end

  it 'displays top five merchants by revenue' do
    merchant_5 = create(:merchant, status: 'enabled')
    merchant_6 = create(:merchant)
    merchant_7 = create(:merchant)

    item_1 = create(:item, merchant_id: @merchant_1.id)
    item_2 = create(:item, merchant_id: @merchant_1.id)
    item_3 = create(:item, merchant_id: @merchant_3.id)
    item_4 = create(:item, merchant_id: @merchant_3.id)
    item_5 = create(:item, merchant_id: @merchant_4.id)
    item_6 = create(:item, merchant_id: @merchant_4.id)
    item_7 = create(:item, merchant_id: merchant_5.id)
    item_8 = create(:item, merchant_id: merchant_5.id)
    item_9 = create(:item, merchant_id: merchant_6.id)
    item_10 = create(:item, merchant_id: merchant_7.id)

    invoice_1 = create(:invoice)
    invoice_2 = create(:invoice)
    invoice_3 = create(:invoice)
    invoice_4 = create(:invoice)
    invoice_5 = create(:invoice)
    invoice_6 = create(:invoice)

    transactions_1 = create(:transaction, invoice_id: invoice_1.id)
    transactions_2 = create(:transaction, invoice_id: invoice_2.id)
    transactions_3 = create(:transaction, invoice_id: invoice_3.id)
    transactions_4 = create(:transaction, invoice_id: invoice_4.id)
    transactions_5 = create(:transaction, invoice_id: invoice_5.id)
    transactions_6 = create(:transaction, invoice_id: invoice_6.id)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 12000, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10100, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 20000, item_id: item_10.id, invoice_id: invoice_2.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item_id: item_4.id, invoice_id: invoice_3.id)
    invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item_id: item_3.id, invoice_id: invoice_4.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 9000, item_id: item_5.id, invoice_id: invoice_5.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 23000, item_id: item_9.id, invoice_id: invoice_6.id)

    visit admin_merchants_path

    within ("#top_revenue") do
      expect(@merchant_3.name).to appear_before(@merchant_1.name)
      expect(merchant_7.name).to_not appear_before(merchant_6.name)
      expect(@merchant_1.name).to appear_before(@merchant_4.name)
      expect(page).to_not have_content(@merchant_2.name)
    end

    within ("#top_revenue") do
      expect(page).to have_content("#{@merchant_1.name} - $221.0 in sales")
      expect(page).to have_content("#{@merchant_3.name} - $750.0 in sales")
      expect(page).to have_content("#{@merchant_4.name} - $90.0 in sales")
    end
  end

  it 'dispalys the top merchants best revenue day' do
    merchant_5 = create(:merchant, status: 'enabled')
    merchant_6 = create(:merchant)
    merchant_7 = create(:merchant)

    item_1 = create(:item, merchant_id: @merchant_1.id)
    item_2 = create(:item, merchant_id: @merchant_1.id)
    item_3 = create(:item, merchant_id: @merchant_3.id)
    item_4 = create(:item, merchant_id: @merchant_3.id)
    item_5 = create(:item, merchant_id: @merchant_4.id)
    item_6 = create(:item, merchant_id: @merchant_4.id)
    item_7 = create(:item, merchant_id: merchant_5.id)
    item_8 = create(:item, merchant_id: merchant_5.id)
    item_9 = create(:item, merchant_id: merchant_6.id)
    item_10 = create(:item, merchant_id: merchant_7.id)

    invoice_1 = create(:invoice, status: 'completed', created_at: '2019-06-24 21:54:10 UTC')
    invoice_2 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')
    invoice_3 = create(:invoice, status: 'completed', created_at: '2019-08-24 21:54:10 UTC')
    invoice_4 = create(:invoice, status: 'completed', created_at: '2019-11-24 21:54:10 UTC')
    invoice_5 = create(:invoice, status: 'completed', created_at: '2019-01-24 21:54:10 UTC')
    invoice_6 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')

    transactions_1 = create(:transaction, invoice_id: invoice_1.id)
    transactions_2 = create(:transaction, invoice_id: invoice_2.id)
    transactions_3 = create(:transaction, invoice_id: invoice_3.id)
    transactions_4 = create(:transaction, invoice_id: invoice_4.id)
    transactions_5 = create(:transaction, invoice_id: invoice_5.id)
    transactions_6 = create(:transaction, invoice_id: invoice_6.id)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 12000, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10100, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 20000, item_id: item_10.id, invoice_id: invoice_2.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item_id: item_4.id, invoice_id: invoice_3.id)
    invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item_id: item_3.id, invoice_id: invoice_4.id)
    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 9000, item_id: item_5.id, invoice_id: invoice_5.id)
    invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 23000, item_id: item_9.id, invoice_id: invoice_6.id)

    visit admin_merchants_path
    within ("#top_revenue") do
      expect(page).to have_content("Top day for #{@merchant_1.name} was 06/24/19")
      expect(page).to have_content("Top day for #{@merchant_3.name} was 11/24/19")
      expect(page).to have_content("Top day for #{@merchant_4.name} was 01/24/19")
      expect(page).to have_content("Top day for #{merchant_6.name} was 07/24/19")
    end
  end
end
