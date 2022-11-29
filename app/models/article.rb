class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  validates :title, :subtitle, :content, presence: true
end
