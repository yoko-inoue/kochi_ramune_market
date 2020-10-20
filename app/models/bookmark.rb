class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :user_id, uniqueness: { scope: :item_id }   ## userとitemのidの組み合わせは一意
end
