class Item < ApplicationRecord
  validates :name,            presence: true
  validates :description,     presence: true
  validates :category_id,     presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,    presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,   presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :schedule_id,     presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price,           presence: true, numericality: { only_integer: true, greater_than: 299 , less_than: 10000000, message: "is out of setting range" }
  validates :image,           presence: true

  belongs_to :user
  # has_one :order ←テーブル作成時に記述する
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :shipping_fee, :prefecture, :schedule
  has_one_attached :image
end
