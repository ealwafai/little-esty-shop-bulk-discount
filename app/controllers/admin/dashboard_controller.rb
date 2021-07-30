class Admin::DashboardController < ApplicationController
  def index
    @top_five_customers = Customers.top_five
  end
end