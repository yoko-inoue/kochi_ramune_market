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

  has_many :bookmarks, dependent: :destroy
  has_many :users, through: :bookmarks

  validates :name, :price, :introduction, :prefecture_id,
  :category_id, :condition, :postage_payer,
  :preparation_day, :user_id, presence: true
  validates :price, presence: true,
  numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, 
  message: "¥300〜¥9999999の間で入力してください" }

  validate  :image_lists_validation

  def image_lists_validation
    image_validation = images

    count = 0
    images.each do |image|
      if image.marked_for_destruction?
      else
        count += +1
      end
    end

    if count == 0 then
      errors.add(:images, "画像を１枚以上添付してください")
    elsif count > 5
      errors.add(:images, "画像は５枚まで添付可能です")
    end
  end

  def self.parentCategory(item)
    if item.ancestry == nil then
      ancestryNumber = item.id
    else
      if item.ancestry.count("/") == 0 then
        ancestryNumber = item.parent_id
      else
        ancestryNumber = item.parent.parent_id
      end
    end
    return ancestryNumber
  end


  def self.category_sorce(item,currentItemId)
    ancestryNumber = self.parentCategory(item)

    items = Item.all
    itembox = []

    items.each do |iteminformation|
      if iteminformation.category.ancestry == nil then
        if iteminformation.category.id == ancestryNumber then
          itembox << iteminformation
        end
      elsif iteminformation.category.ancestry.count("/") == 0 then
        if iteminformation.category.parent_id == ancestryNumber then
          itembox << iteminformation
        end
      else
        if iteminformation.category.parent.parent_id == ancestryNumber then
          itembox << iteminformation
        end
      end
    end
    itembox.delete_if{|item|
      item.id == currentItemId
    }
    return itembox
  end

  def self.search(search)
    return Item.all unless search
    Item.where(['name LIKE ?', "%#{search}%"])
  end

end

