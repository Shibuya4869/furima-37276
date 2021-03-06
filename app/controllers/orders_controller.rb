class OrdersController < ApplicationController
  before_action :find_params,        only: [:index, :create]
  before_action :authenticate_user!, only: [:index]

  def index
    redirect_to root_path if (@item.user_id == current_user.id) or (order_search == true)
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def find_params
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :order_id, :post_code, :prefecture_id, :city, :address, :building, :phone
    ).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def order_search
    orders = Order.all
    orders.each do |order|
      return true if @item.id == order.item_id
    end
  end
end
