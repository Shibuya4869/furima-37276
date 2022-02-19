require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it 'すべてのフォームが正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品名が空欄では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it '商品名が41文字以上では登録できない' do
        @item.name = Faker::Lorem.characters(41)
        @item.valid?
        expect(@item.errors.full_messages).to include "Name is too long (maximum is 40 characters)"
      end
      it '商品説明欄が空欄では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it '商品説明欄が1001文字以上では登録できない' do
        @item.description = Faker::Lorem.characters(number: 1001, min_alpha: 1001 )
        @item.valid?
        expect(@item.errors.full_messages).to include "Description is too long (maximum is 1000 characters)"
      end
      it '商品カテゴリを選択していないと登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it '商品の状態を選択していないと登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end
      it '配送料の負担を選択していないと登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
      end
      it '配送元の地域を選択していないと登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '配送までの日数を選択していないと登録できない' do
        @item.schedule_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Schedule can't be blank"
      end
      it '価格が空欄では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it '価格が300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it '価格が1千万以上では登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is out of setting range"
      end
      it '商品画像を選択していないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
    end
  end
end
