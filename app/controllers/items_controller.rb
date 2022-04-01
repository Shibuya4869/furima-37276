class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index,      only:   [:edit, :destroy]
  before_action :find_params,        only:   [:show, :edit, :update, :destroy]
  before_action :order_search,       only:   [:show, :edit, :destroy]
  before_action :dont_edit,          only:   [:edit, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
    @order = Order.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :schedule_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def move_to_index
    item = Item.find(params[:id])
    redirect_to action: :index unless current_user.id == item.user_id
  end

  def find_params
    @item = Item.find(params[:id])
  end

  def order_search
    orders = Order.all
    orders.each do |order|
      @search_result = 1 if @item.id == order.item_id
    end
  end

  def dont_edit
    redirect_to root_path if @search_result == 1
  end
end
