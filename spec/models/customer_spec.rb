require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:) }
  # end
  # before :each do
  #
  # end
  describe 'class methods' do
    before :each do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      Customer.all.each do |customer|
        create_list(:invoice, 1, customer: customer)
      end

      create_list(:transaction, 2, result: 'failed', invoice: @customer_1.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_2.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_3.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_4.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_5.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_6.invoices.first)
    end

    describe '::top_five' do
      it 'returns 5 customers with highest number of successful transactions' do
        customer_list = [@customer_2,@customer_3,@customer_4,@customer_5,@customer_6,]
        expect(Customer.top_five).to eq(customer_list)
      end
    end
  end
  
  describe 'instance methods' do
    before :each do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)

      Customer.all.each do |customer|
        create_list(:invoice, 1, customer: customer)
      end

      create_list(:transaction, 2, result: 'failed', invoice: @customer_1.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customer_2.invoices.first)
      create_list(:transaction, 4, result: 'success', invoice: @customer_3.invoices.first)
    end

    describe '::successful_transactions' do
      it 'displays successful transactions' do
        expect(@customer_1.successful_transactions).to eq(0)
        expect(@customer_2.successful_transactions).to eq(2)
        expect(@customer_3.successful_transactions).to eq(4)
      end
    end
  end
end
