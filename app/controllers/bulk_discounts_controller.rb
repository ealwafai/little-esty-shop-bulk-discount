class BulkDiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_bulk_discount, only: [:show, :edit, :update, :destroy]

  def index
    @bulk_discounts = @merchant.bulk_discounts
    @holidays = NagerService.next_3_holidays
  end

  def show
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def edit
  end

  def create
    @bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)

    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  def update
  end

  def destroy
    @bulk_discount.destroy
    
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private

  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discount_params
    params.permit(:name, :percentage, :threshold)
  end
end
