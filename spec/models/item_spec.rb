require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品' do
    # 出品できる
    it '必須事項を入力すれば商品を出品できる' do
      expect(@item).to be_valid
    end
    # 出品できない
    # 商品画像
    it '商品画像が必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    # 商品名
    it 'nameが空では出品できない' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    # 商品情報
    it 'infoが空では出品できない' do
      @item.info = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Info can't be blank")
    end
    # カテゴリー
    it 'カテゴリーが空では出品できない' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Category is not a number')
    end
    it 'カテゴリーが「--」の時は保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end
    # 商品の状態
    it '商品の状態が空では出品できない' do
      @item.status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Status is not a number')
    end
    it '商品の状態が「--」の時は保存できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Status must be other than 1')
    end
    # 配送料の負担
    it '配送料の負担が空では出品できない' do
      @item.shipping_fee_status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee status is not a number')
    end
    it '配送料の負担が「--」の時は保存できない' do
      @item.shipping_fee_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping fee status must be other than 1')
    end
    # 発送元の地域
    it '発送元の地域が空では出品できない' do
      @item.prefecture_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture is not a number')
    end
    it '発送元の地域が「--」の時は保存できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
    end
    # 発送までの日数
    it '発送までの日数が空では出品できない' do
      @item.scheduled_delivery_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Scheduled delivery is not a number')
    end
    it '発送までの日数が「--」の時は保存できない' do
      @item.scheduled_delivery_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Scheduled delivery must be other than 1')
    end
    # 価格
    it '販売価格が空では出品できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it '販売価格は半角数字のみ保存可能であること' do
      @item.price = '５０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price は半角数字を使用してください')
    end
    it '価格が299以下の場合は登録できない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
    it '価格が10_000_000以上の場合は登録できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not included in the list')
    end
  end
end
