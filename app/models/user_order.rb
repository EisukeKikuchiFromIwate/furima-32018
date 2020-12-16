class UserOrder
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number , :user_id, :item_id, :price
  #必須のバリデーション
  with_options presence: true do
    #　価格のバリデーション
    # validates :price
    # #　トークンのバリデーション 
    validates :token
    # 「住所」の郵便番号に関するバリデーション
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    # 「住所」の都道府県に関するバリデーション
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    # 「住所」の市区町村に関するバリデーション
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角文字を使用してください"}
    # 「住所」の番地に関するバリデーション
    validates :addresses
    # 電話番号に関するバリデーション
    validates :phone_number, format: { with: /\A[0-9]{,11}\z/, message: "11桁以内の半角数字を使用してください"}
  end
    
  

  def save
    # 購入情報の保存
    Order.create(user_id: user.id, item_id: item.id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end