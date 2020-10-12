class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, foreign_key: 'user_id'
  has_many :images, dependent: :destroy
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :postage_type
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :price, :introduction, :prefecture_id,
  :category_id, :condition, :postage_payer,
  :preparation_day, :user_id, presence: true
  validates :price, presence: true,
  numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
  message: "¥300〜¥9999999の間で入力してください" }

  validate  :image_lists_validation

  def image_lists_validation
    image_validation = images
    if image_validation.length == nil then
      errors.add(:images, "画像を１枚以上添付してください")
    elsif image_validation.length > 5
      errors.add(:images, "画像は５枚まで添付可能です")
    end
  end
end

