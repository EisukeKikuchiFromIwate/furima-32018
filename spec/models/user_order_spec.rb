require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  before do
    @user_order = FactoryBot.build(:user_order)
  end
  describe '商品購入' do
    context '出品できる' do
      it "shipping_addressとtokenがあれば保存できること" do
        expect(@user_order).to be_valid
      end
    end
    context '出品できない' do
      it 'tokenが空だと保存できないこと' do
        @user_order.token = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        @user_order.postal_code = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @user_order.postal_code = '1234567'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefectureを選択していないと保存できないこと' do
        @user_order.prefecture_id = 1
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @user_order.city = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end
      it 'addressesが空だと保存できないこと' do
        @user_order.addresses = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Addresses can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @user_order.phone_number = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberには半角ハイフンは不要であること' do
        @user_order.phone_number = '080-1111-1111'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number 11桁以内の半角数字を使用してください")
      end
      it 'phone_numberは11桁以内であること' do
        @user_order.phone_number = '080123412345'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number 11桁以内の半角数字を使用してください")
      end
      it 'phone_numberは半角数字のみでないと登録できないこと' do
        @user_order.phone_number = '０８０１２３４１２３４'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number 11桁以内の半角数字を使用してください")
      end
      it 'user_idが空では登録できないこと' do
        @user_order.user_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できないこと' do
        @user_order.item_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
