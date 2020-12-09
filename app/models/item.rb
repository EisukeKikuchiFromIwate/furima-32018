class Item < ApplicationRecord

# 必須項目の設定
  with_options presence: true do
    # 商品画像
    validates :image, unless: :was_attached?
    # 商品名
    validates :name
    # 商品の説明
    validates :info
    # カテゴリー
    validates :category_id
    # 商品の状態
    validates :status_id
    # 配送料の負担
    validates :shipping_fee_status_id
    # 発送元の地域
    validates :prefecture_id
    # 発送までの日数
    validates :scheduled_delivery_id
    # 販売価格
    validates :price
  end

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id,
            :status_id,
            :shipping_fee_status_id,
            :prefecture_id,
            :scheduled_delivery_id,
            numericality: { other_than: 1 }

  # アソシエーション
  belongs_to :user
  has_one_attached :image

  def was_attached?
    self.image.attached?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  
end
