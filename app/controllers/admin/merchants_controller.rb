class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.create(merchant_params)
    redirect_to admin_merchants_path
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if params[:status]
      merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    elsif params[:merchant]
      merchant.update(merchant_params)
      flash[:notice] = "Merchant Sucessfully Updated"
      redirect_to admin_merchant_path(merchant)
    end
  end

private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
