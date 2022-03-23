class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :order_id, :post_code, :prefecture_id, :city, :address, :building, :phone

  validates :token,         presence: true
  validates :post_code,     presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :city,          presence: true
  validates :address,       presence: true
  validates :phone,         presence: true, numericality: { only_integer: true, in: 10..11}

  def save
    Order.create(user_id: @current_user_id, item_id: item_id)
    Address.create(order_id: order_id, post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone)
  end

end
