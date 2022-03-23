class OrdersController < ApplicationController
  before_action :find_params, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @current_user_id = current_user.id
    @order_address = OrderAddress.new(order_params)
    binding.pry
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
      :item_id, :order_id, :post_code, :prefecture_id, :city, :address, :building, :phone
    ).merge(
      user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: Item.find(params[:item_id]).price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end
end
