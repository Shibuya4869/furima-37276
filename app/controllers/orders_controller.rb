class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      Payjp.api_key = "sk_test_34be3d42c8d7d3bcacde5d57"
      Payjp::Charge.create(
        amount: order_params[:price],
        card: order_params[:token],
        currency: 'jpy'
      )
      @order.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_id).merge(user_id: current_user.id, token: params[:token])
  end

  def address_params
    praams.require(:address).permit(:order_id, :post_code, :prefecture_id, :city, :address, :building, :phone)
  end
end
