require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    # 登録できる
    it '必須事項を入力すれば登録できること' do
      expect(@user).to be_valid
    end
    it 'passwordが6文字以上かつ半角英数混合であれば登録できること' do
      @user.password = '12345q'
      @user.password_confirmation = '12345q'
      expect(@user).to be_valid
    end

    # 登録できない
    it 'nicknameが空だと登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'passwordが空では登録できない' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角英数混合(半角英語のみ)でないと登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'password_confirmationとpasswordが不一致では登録できない' do
      @user.password = '12345q'
      @user.password_confirmation = '123456q'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'last_nameが空では登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'last_nameとfirst_nameは全角(漢字・ひらがな・カタカナ)でないと登録できない' do
      @user.last_name = 'tanaka'
      @user.first_name = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name 全角文字を使用してください', 'Last name 全角文字を使用してください')
    end

    it 'last_name_kanaが空では登録できない' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it 'last_name_kanaとfirst_name_kanaは全角カタカナでないと登録できない' do
      @user.last_name_kana = 'tanaka'
      @user.first_name_kana = 'taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください', 'Last name kana 全角カタカナを使用してください')
    end
  end
end
