class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category_id
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to_active_hash :prefecture_id
  belongs_to_active_hash :postage_type

  belongs_to :category
  belongs_to :user, foreign_key: 'user_id'
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true

    validates :name, :introduction,:category_id,:condition,:postage_payer, 
    :preparation_day, :prefecture_id, :postage_type, presence: true
    validates :price, presence: true, 
    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

    def images_presence
      if images.attached?
        # inputに保持されているimagesがあるかを確認
        if images.length > 10
          errors.add(:image, '10枚まで投稿できます')
        end
      else
        errors.add(:image, '画像がありません')
      end
    end
    
end

