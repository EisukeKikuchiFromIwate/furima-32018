class UserPurchas
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture, :city, :addresses, :building, :phone_number
  #必須のバリデーション
  with_options presence: true do
    #　価格のバリデーション
    validates :price
    #　トークンのバリデーション 
    validates :token
    # 「住所」の郵便番号に関するバリデーション
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    # 「住所」の都道府県に関するバリデーション
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    # 「住所」の市区町村に関するバリデーション
    validates :city, { with: /\A[ぁ-んァ-ン一-龥]/, message: "全角文字を使用してください"}
    # 「住所」の番地に関するバリデーション
    validates :addresses
  end
    # 電話番号に関するバリデーション
    validates :phone_number, numericality: { less_than_or_equal_to: 11, message: "is out of setting range"}
  end

  def save
    # ユーザーのidを保存
    User.create(user_id: user.id)
    # アイテムのidを保存
    Item.create(item_id: item.id)
    # トークンの情報を保存
    Token.create(token: token)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefecture: prefecture, city: city, addresses: addresses, building: building, phone_number: phone_number)
  end
end