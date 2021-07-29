class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    
    if params[:status]
      merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif params[:new_name]
      merchant.update(name: params[:new_name])
      flash[:notice] = "Merchant Sucessfully Updated"
      redirect_to admin_merchant_path(merchant)
    end
  end
end
