class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  enum condition:          { brand_new: 0, near_to_unused: 1, no_scrach: 2, slight_scrach: 3, has_scrach: 4, bad_state: 5 }
  enum status:             { display: 0, sold: 1 }
  enum podtage_payer:      { listing_person: 0, buyer_burden: 1 }
  enum preparation_day:    { early_ship: 0, middle_ship: 1, late_ship: 2 }

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :condition
    validates :postage_payer
    validates :preparation_day
    validates :prefecture_id
    validates :category_id
    validates :postage_type
  end
end
