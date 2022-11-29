class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes
  validates :title, :subtitle, :content, presence: true
  has_one_attached :photo
end
