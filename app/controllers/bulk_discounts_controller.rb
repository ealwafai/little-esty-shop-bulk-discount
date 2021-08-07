class BulkDiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_bulk_discount, only: [:show, :edit, :update, :destroy]

  def index
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
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    @bulk_discount.save
  end

  def update
    @bulk_discount.update(bulk_discount_params)
  end

  def destroy
    bulk_discount.destroy
  end

  private

  def set_bulk_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percentage, :threshold, :merchant_id)
  end
end
