require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant = create(:merchant, id: 1, name: 'Eucalyptus')
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant, status: 'enabled')
    @merchant_2 = create(:merchant, id: 2)
    @item_3 = create(:item, merchant: @merchant_2)

    visit merchant_items_path(@merchant)
  end
  describe 'Merchant Item List' do
    it 'see names of merchant items' do
      expect(page).to have_content(@merchant.name)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
  end
  describe 'Disable/Enable' do
    it 'each item has a button to enable or disable' do
      within("#item-#{@item_1.id}") do
        expect(page).to have_button('Enable')
      end
      within("#item-#{@item_2.id}") do
        expect(page).to have_button('Disable')
      end
    end
    it 'can change status but clicking button' do
      within("#item-#{@item_1.id}") do
        click_button('Enable')
      end
      within("#item-#{@item_1.id}") do
        expect(page).to have_button('Disable')
      end
    end
    it 'has item in sections by status' do
      within(".enabled") do
        expect(page).to have_content(@item_2.name)
      end
      within(".disabled") do
        expect(page).to have_content(@item_1.name)
      end
    end
  end
  describe 'Create New Item' do
    it 'has link to create a new item' do
      click_link 'New Item'
      expect(current_path).to eq(new_merchant_item_path(@merchant))
    end
  end
  describe 'Items Top Revenue Earners' do
    it 'has top 5 revenue earners ranked by revenue' do
      customer = create(:customer)
      invoice_1 = create(:invoice, customer: customer, status: 'completed')
      invoice_2 = create(:invoice, customer: customer, status: 'completed')
      item_4 = create(:item, merchant: @merchant)
      item_5 = create(:item, merchant: @merchant)
      item_6 = create(:item, merchant: @merchant)
      invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: @item_1, quantity: 1, unit_price: 5000)
      invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: @item_2, quantity: 1, unit_price: 2000)
      invoice_item_3 = create(:invoice_item, invoice: invoice_1, item: @item_3, quantity: 1, unit_price: 9000)
      invoice_item_4 = create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 1, unit_price: 4000)
      invoice_item_5 = create(:invoice_item, invoice: invoice_2, item: item_5, quantity: 1, unit_price: 1000)
      invoice_item_6 = create(:invoice_item, invoice: invoice_2, item: item_6, quantity: 1, unit_price: 3000)
      transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
      transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)

      visit merchant_items_path(@merchant)

      within('.top-items') do
        expect(@item_1.name).to appear_before(item_4.name)
        expect(item_4.name).to appear_before(item_6.name)
        expect(item_6.name).to appear_before(@item_2.name)
        expect(@item_2.name).to appear_before(item_5.name)
      end
    end
end
