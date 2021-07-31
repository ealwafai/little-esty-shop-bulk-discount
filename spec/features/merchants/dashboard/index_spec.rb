require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  describe "I visit a merchant dashboard" do

    before :each do
      @merchant = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)
      @customer_7 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_2)
      @invoice_3 = create(:invoice, customer: @customer_3)
      @invoice_4 = create(:invoice, customer: @customer_4)
      @invoice_5 = create(:invoice, customer: @customer_5)
      @invoice_6 = create(:invoice, customer: @customer_6)
      @invoice_7 = create(:invoice, customer: @customer_7)

      @transaction_1 = create(:transaction, invoice: @invoice_1)
      @transaction_2 = create(:transaction, invoice: @invoice_1)
      @transaction_4 = create(:transaction, invoice: @invoice_2)
      @transaction_4 = create(:transaction, invoice: @invoice_2)
      @transaction_5 = create(:transaction, invoice: @invoice_2)
      @transaction_6 = create(:transaction, invoice: @invoice_2)
      @transaction_8 = create(:transaction, invoice: @invoice_3)
      @transaction_8 = create(:transaction, invoice: @invoice_3)
      @transaction_9 = create(:transaction, invoice: @invoice_3)
      @transaction_10 = create(:transaction, invoice: @invoice_3)
      @transaction_11 = create(:transaction, invoice: @invoice_3)
      @transaction_12 = create(:transaction, invoice: @invoice_4)
      @transaction_13 = create(:transaction, invoice: @invoice_5)
      @transaction_14 = create(:transaction, invoice: @invoice_6)
      @transaction_15 = create(:transaction, invoice: @invoice_6)
      @transaction_16 = create(:transaction, invoice: @invoice_6)
      @transaction_17 = create(:transaction, invoice: @invoice_7)
      @transaction_18 = create(:transaction, invoice: @invoice_7)
      @transaction_19 = create(:transaction, invoice: @invoice_7)
      @transaction_20 = create(:transaction, invoice: @invoice_7)
      @transaction_21 = create(:transaction, invoice: @invoice_7)
      @transaction_22 = create(:transaction, invoice: @invoice_7)

      @item = create(:item, merchant: @merchant)

      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item)
      @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item)
      @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item)
      @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item)

      visit "/merchants/#{@merchant.id}/dashboard"
    end

    it "displays the merchant name" do
      expect(page).to have_content(@merchant.name)
    end

    it 'displays a link to my items index page and my invoices index page' do
      expect(page).to have_link("My Items")
      click_link("My Items")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/items")

      visit "/merchants/#{@merchant.id}/dashboard"

      expect(page).to have_link("My Invoices")
      click_link("My Invoices")
      expect(page).to have_current_path("/merchants/#{@merchant.id}/invoices")
    end

    it 'displays the names of the top 5 customers by successfull transactions' do
      expect(page).to have_content(@customer_7.first_name)
      expect(page).to have_content(@customer_7.last_name)
      expect(page).to have_content("6 purchases")

      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content("5 purchases")

      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content("4 purchases")

      expect(page).to have_content(@customer_6.first_name)
      expect(page).to have_content(@customer_6.last_name)
      expect(page).to have_content("3 purchases")

      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content("2 purchases")

      expect(page).to_not have_content(@customer_4.first_name)
      expect(page).to_not have_content(@customer_4.last_name)
      expect(page).to_not have_content(@customer_5.first_name)
      expect(page).to_not have_content(@customer_5.last_name)

      expect(@customer_7.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_6.first_name)
      expect(@customer_6.first_name).to appear_before(@customer_1.first_name)
    end
  end
end
