require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it '建物名は空でも保存できる' do
        @order_address.building = ''
        @order_address.valid?
      end
    end

    context '内容に問題がある場合' do
      it 'カード情報（token）が空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号が空では保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Post code can't be blank"
      end
      it '郵便番号は半角ハイフンを含んだ正しい形式でないと保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Post code is invalid. Include hyphen(-)'
      end
      it '都道府県を選択していないと保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空では保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空では保存できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Address can't be blank"
      end
      it '電話番号が空では保存できない' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Phone can't be blank"
      end
      it '電話番号が9桁以下では保存できない' do
        @order_address.phone = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone is too short (minimum is 10 characters)'
      end
      it '電話番号が12桁以上では保存できない' do
        @order_address.phone = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone is too long (maximum is 11 characters)'
      end
      it '電話番号に半角数字以外が含まれている場合は保存できない' do
        @order_address.phone = '１２３４５６７８９０'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include 'Phone is not a number'
      end
      it 'userが紐づいていなければ保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていなければ保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
