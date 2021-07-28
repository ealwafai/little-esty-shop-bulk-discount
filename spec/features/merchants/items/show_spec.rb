require 'rails_helper'

RSpec.describe 'Merchant Item Show Page' do
  before :each do
    @merchant = create(:merchant, name: 'Eucalyptus')
    @item = create(:item, merchant: @merchant)
    visit merchant_items_path(@merchant, @item)
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
      expect(page).to have_content(@item.unit_price)
      expect(page).to have_content('Update Item')
    end
    it 'does not include other items information on page' do
      item_2 = create(:item, merchant: @merchant)
      expect(page).to_not have_content(item_2.name)
      expect(page).to_not have_content(item_2.description)
      expect(page).to_not have_content(item_2.unit_price)
    end
  end
  describe 'Update Item' do
    it 'can click link to update item information' do
      click_link 'Update Item'
      expect(path).to eq(edit_merchant_item(@item))
    end
    it 'has previous information on form to edit' do
      click_link 'Update Item'

      expect(page).to have_field(:name, with: "#{@item.name}")
      expect(page).to have_field(:description, with: "#{@item.description}")
      expect(page).to have_field(:unit_price, with: "#{@item.unit_price}")
    end
    it 'can enter new information and submit to be redirected to merchant item page' do
      click_link 'Update Item'

      fill_in(:name, with: 'Lotion')
      fill_in(:description, with: 'aloe body lotion')
      fill_in(:unit_price, with: 650)
      click_button('Submit')

      expect(current_path).to eq(merchant_items_path(@merchant, @item))
      expect(page).to have_content('Lotion')
      expect(page).to have_content('Description: aloe body lotion')
      expect(page).to have_content('Current Price: 650')
    end
    it 'returns flash message that items have sucessfully been updated' do

    end
  end
end
