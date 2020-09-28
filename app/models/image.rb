class Image < ApplicationRecord
  mount_uploader :name, ImageUploader
  belongs_to :item, optional: true
  validates :name, presence: true
end
