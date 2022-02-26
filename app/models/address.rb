class Address < ApplicationRecord
  validates :post_code,     presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :city,          presence: true
  validates :address,       presence: true
  validates :phone,         presence: true, numericality: { only_integer: true, in: 10..11}

  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
