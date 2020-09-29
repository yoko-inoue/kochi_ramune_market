require 'rails_helper'
describe SendingDestination do
  describe '#create' do

    it "全て入力されていると保存できる" do
      sending_destination = build(:sending_destination)
      expect(sending_destination).to be_valid
    end

    it "destination_first_nameが空だと保存できない" do
      sending_destination = build(:sending_destination, destination_first_name: "")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name]).to include("を入力してください")
    end

    it "destination_last_nameが空だと保存できない" do
      sending_destination = build(:sending_destination, destination_last_name: "")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_last_name]).to include("を入力してください")
    end

    it "destination_first_nameのフリガナが空だと保存できない" do
      sending_destination = build(:sending_destination, destination_first_name_kana: "")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name_kana]).to include("を入力してください")
    end

    it "destination_last_nameのフリガナが空だと保存できない" do
      sending_destination = build(:sending_destination, destination_last_name_kana: "")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_last_name_kana]).to include("を入力してください")
    end

    it "郵便番号が空だと保存できない" do
      sending_destination = build(:sending_destination, post_code: "")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("を入力してください")
    end

    it "都道府県が空だと保存できない" do
      sending_destination = build(:sending_destination, prefecture: "")
      sending_destination.valid?
      expect(sending_destination.errors[:prefecture]).to include("を入力してください")
    end

    it "市町村が空だと保存できない" do
      sending_destination = build(:sending_destination, city: "")
      sending_destination.valid?
      expect(sending_destination.errors[:city]).to include("を入力してください")
    end

    it "番地が空だと保存できない" do
      sending_destination = build(:sending_destination, house_number: "")
      sending_destination.valid?
      expect(sending_destination.errors[:house_number]).to include("を入力してください")
    end

    it "電話番号が重複したら保存できない" do
      sending_destination = create(:sending_destination)
      another_sending_destination = build(:sending_destination, phone_number: sending_destination.phone_number)
      another_sending_destination.valid?
      expect(another_sending_destination.errors[:phone_number]).to include("はすでに存在します")
    end

    it "destination_first_nameが全角でないと保存できない" do
      sending_destination = build(:sending_destination, destination_first_name: "ｱｲｳｴｵ")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name]).to include("は不正な値です")
    end

    it "destination_last_nameが全角でないと保存できない" do
      sending_destination = build(:sending_destination, destination_last_name: "ｱｲｳｴｵ")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_last_name]).to include("は不正な値です")
    end

    it "destination_first_nameのフリガナが全角カタカナでないと保存できない" do
      sending_destination = build(:sending_destination, destination_first_name_kana: "あいうえお")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_first_name_kana]).to include("は不正な値です")
    end

    it "destination_last_nameのフリガナが全角カタカナでないと保存できない" do
      sending_destination = build(:sending_destination, destination_last_name_kana: "あいうえお")
      sending_destination.valid?
      expect(sending_destination.errors[:destination_last_name_kana]).to include("は不正な値です")
    end

    it "郵便番号が7桁でないと保存できない" do
      sending_destination = build(:sending_destination, post_code: "123456")
      sending_destination.valid?
      expect(sending_destination.errors[:post_code]).to include("は不正な値です")
    end

    it "電話番号が10桁または11桁でないと保存できない" do
      sending_destination = build(:sending_destination, phone_number: "12345678")
      sending_destination.valid?
      expect(sending_destination.errors[:phone_number]).to include("は不正な値です")
    end

  end
end