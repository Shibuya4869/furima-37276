class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
  end

  private

  def order_params
    params.require(:order).permit(:item_id).merge(user_id: current_user.id)
  end

  def address_params
    praams.require(:address).permit(:order_id, :post_code, :prefecture_id, :city, :address, :building, :phone)
  end
end
