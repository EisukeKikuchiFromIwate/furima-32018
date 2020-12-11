class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全角ひらがな、全角カタカナ、漢字
  FROMAT_ZENKAKU = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  # 全角カタカナ
  FORMAT_KANA = /\A[ァ-ヶー－]+\z/.freeze
  # 英数字混合
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  # パスワード
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には半角英字と半角数字の両方を含めて設定してください'

  # 必須項目の設定
  with_options presence: true do
    # ニックネーム
    validates :nickname
    # 苗字
    validates :last_name, format: { with: FROMAT_ZENKAKU, message: '全角文字を使用してください' }
    # 名前
    validates :first_name, format: { with: FROMAT_ZENKAKU, message: '全角文字を使用してください' }
    # 苗字_カナ
    validates :last_name_kana, presence: true, format: { with: FORMAT_KANA, message: '全角カタカナを使用してください' }
    # 名前_カナ
    validates :first_name_kana, presence: true, format: { with: FORMAT_KANA, message: '全角カタカナを使用してください' }
    # 生年月日
    validates :birth_day
  end

  # アソシエーション
  has_many :items
end
