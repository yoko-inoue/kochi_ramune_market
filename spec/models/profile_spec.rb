require 'rails_helper'
describe Profile do
  describe '#create' do

    it "全て入力されていると保存できる" do
      profile = build(:profile)
      expect(profile).to be_valid
    end

    it "first_nameが空だと保存できない" do
      profile = build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "last_nameが空だと保存できない" do
      profile = build(:profile, last_name: "")
      profile.valid?
      expect(profile.errors[:last_name]).to include("を入力してください")
    end

    it "first_nameのフリガナが空だと保存できない" do
      profile = build(:profile, first_name_kana: "")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "last_nameのフリガナが空だと保存できない" do
      profile = build(:profile, last_name_kana: "")
      profile.valid?
      expect(profile.errors[:last_name_kana]).to include("を入力してください")
    end

    it "生年月日が空だと保存できない" do
      profile = build(:profile, birth_date: "")
      profile.valid?
      expect(profile.errors[:birth_date]).to include("を入力してください")
    end

    it "first_nameが全角でないと保存できない" do
      profile = build(:profile, first_name: "ｱｲｳｴｵ")
      profile.valid?
      expect(profile.errors[:first_name]).to include("は不正な値です")
    end

    it "last_nameが全角でないと保存できない" do
      profile = build(:profile, last_name: "ｱｲｳｴｵ")
      profile.valid?
      expect(profile.errors[:last_name]).to include("は不正な値です")
    end

    it "first_nameのフリガナが全角カタカナでないと保存できない" do
      profile = build(:profile, first_name_kana: "あいうえお")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "last_nameのフリガナが全角カタカナでないと保存できない" do
      profile = build(:profile, last_name_kana: "あいうえお")
      profile.valid?
      expect(profile.errors[:last_name_kana]).to include("は不正な値です")
    end

  end
end