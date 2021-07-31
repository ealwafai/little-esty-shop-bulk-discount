class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @favorite_customers = Customer.top_five_customers_by_transactions(@merchant.id)
  end
end
