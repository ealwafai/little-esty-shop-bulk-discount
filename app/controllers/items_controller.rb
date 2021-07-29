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
    if params[:status]
      item.update!(status: params[:status])
      redirect_to merchant_items_path(merchant)
    else
      item.update!(item_params)
      flash[:success] = "Item information has been successfully updated"
      redirect_to merchant_item_path(merchant, item)
    end
  end
  
  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
