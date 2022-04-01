class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :order_id, :post_code, :prefecture_id, :city, :address, :building, :phone

  with_options presence: true do
    validates :token
    validates :post_code,      format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id,  numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone,          numericality: { only_integer: true }, length: { in: 10..11 }
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                   building: building, phone: phone)
  end
end
