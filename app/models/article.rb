class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :likes, dependent: :destroy
  validates :title, :subtitle, :content, presence: true
  has_one_attached :photo
  has_rich_text :rich_body
end
