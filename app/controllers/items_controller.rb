class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      redirect_to merchant_items_path(merchant)
    else
      redirect_to new_merchant_item_path(merchant)
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    if params[:status]
      item.update(status: params[:status])
      redirect_to merchant_items_path(merchant)
    else
      item.update(item_params)
      flash[:success] = "Item information has been successfully updated"
      redirect_to merchant_item_path(merchant, item)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
