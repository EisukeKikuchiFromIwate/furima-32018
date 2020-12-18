class Item < ApplicationRecord
  # 必須項目の設定
  with_options presence: true do
    # 商品画像
    validates :image, unless: :was_attached?
    # 商品名
    validates :name, length: { maximum: 40 }
    # 商品の説明
    validates :info, length: { maximum: 1000 }
    # 販売価格 価格範囲の設定
    validates :price, inclusion: { in: 300..9_999_999 }
  end
  # 半角数字のみ
  validates :price, numericality: { with: /\A[0-9０-９]+\z/, message: 'は半角数字を使用してください' }

  # ジャンルの選択が「--」の時は保存できないようにする
  with_options numericality: { other_than: 1 } do
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
  end

  # アソシエーション
  belongs_to :user
  has_one_attached :image
  has_one :order

  def was_attached?
    image.attached?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end
