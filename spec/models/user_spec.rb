require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネーム、メールアドレス、パスワードがあれば保存できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ニックネームが空だと保存できない" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メールアドレスが空だと保存できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが空だと保存できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードがあってもpassword_confirmationの方ないと保存できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "メールアドレスが重複したら保存できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードが7文字以上だと保存できる" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      expect(user).to be_valid
    end

    it "パスワードが6文字以下だと保存できない" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "メールアドレスがxxx@yyy.zzzの形でないと保存できない" do
      user = build(:user, email: "xxx@yyy")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

  end
end