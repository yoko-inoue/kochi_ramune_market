class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  has_one :profile
  has_one :sending_destination

  has_one :card

  has_many :bookmarks, dependent: :destroy
  has_many :items, through: :bookmarks

  has_many :comments, dependent: :destroy
end
