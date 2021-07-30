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
end
