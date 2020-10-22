class SendingDestination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :destination_first_name, :destination_last_name, :destination_first_name_kana, :destination_last_name_kana, :prefecture_id, :city, :house_number, presence: true
  validates :destination_first_name, :destination_last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :destination_first_name_kana, :destination_last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/}
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/}
  validates :phone_number, uniqueness: true, allow_blank: true, format: { with: /\A\d{10,11}\z/, allow_blank: true}
end