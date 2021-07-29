require 'rails_helper'

RSpec.describe 'Merchant Item Show Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    @item = create(:item, id: 1, merchant: @merchant)
    visit merchant_item_path(@merchant, @item)
  end
  describe 'View Item and Details' do
    it 'can click link to merchant item index page' do
      visit merchant_items_path(@merchant)
      click_link("#{@item.name}")

      expect(current_path).to eq(merchant_item_path(@merchant, @item))
    end
    it 'can see item and all attributes' do
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.unit_price_dollars)
      expect(page).to have_content('Update Item')
    end
    it 'does not include other items information on page' do
      item_2 = create(:item, id: 2, merchant: @merchant)
      expect(page).to_not have_content(item_2.name)
      expect(page).to_not have_content(item_2.description)
      expect(page).to_not have_content(item_2.unit_price_dollars)
    end
  end
  describe 'Update Item' do
    it 'can click link to update item information' do
      click_link 'Update Item'
      expect(current_path).to eq(edit_merchant_item_path(@merchant, @item))
    end
  end
end
