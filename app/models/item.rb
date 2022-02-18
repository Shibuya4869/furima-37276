class Item < ApplicationRecord
  validates :name,            presence: true
  validates :description,     presence: true
  validates :category_id,     presence: true
  validates :condition_id,    presence: true
  validates :shipping_fee_id, presence: true
  validates :prefecture_id,   presence: true
  validates :schedule_id,     presence: true
  validates :price,           presence: true

  belongs_to :user
  # has_one :order
  # アソシエーションはテーブル作成時に記述する
end
