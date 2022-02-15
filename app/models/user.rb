class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :birthday,        presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password,        with: PASSWORD_REGEX
  validates_format_of :first_name,      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates_format_of :first_name_kana, with: /\A[ァ-ヶ]+\z/
  validates_format_of :last_name,       with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates_format_of :last_name_kana,  with: /\A[ァ-ヶ]+\z/

  # has_many :tweets, :orders 
  # アソシエーションはテーブル作成時に記述する

end
