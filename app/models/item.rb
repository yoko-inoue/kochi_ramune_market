class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :images, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :introduction
    validates :category_id
    validates :condition
    validates :status
    validates :postage_payer
    validates :preparation_day
    validates :prefecture_id
    validates :postage_type
    validates :price
  end
end

