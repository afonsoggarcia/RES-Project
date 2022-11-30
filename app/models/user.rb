class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :topics
  has_many :replies
  has_many :articles
  has_many :likes, dependent: :destroy
  validates :first_name, :last_name, :nickname, presence: true
  validates :nickname, uniqueness: true
  has_one_attached :photo
end
