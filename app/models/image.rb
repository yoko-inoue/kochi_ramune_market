class Image < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploader :image_url, ImageUploader
  validates :image, presence: true
end
