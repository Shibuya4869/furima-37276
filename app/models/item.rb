class Item < ApplicationRecord
  validates :name,            presence: true, length: { minimum: 1, maximum: 40 }
  validates :description,     presence: true, length: { minimum: 1, maximum: 1000 }
  validates :category_id,     presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id,    presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,   presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :schedule_id,     presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price,           presence: true,
                              numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000, message: 'is out of setting range' }
  validates :image,           presence: true

  belongs_to :user
  has_one :order
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :schedule
  has_one_attached :image
end
