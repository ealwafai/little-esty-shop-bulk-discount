class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
      item.update!(item_params)
      flash[:success] = "Item information has been successfully updated"
      redirect_to merchant_item_path(merchant, item)
  
  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
