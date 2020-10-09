class Image < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploader :image_url, ImageUploader
  validates :images, presence: true
end
