class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :comments
  validates :content, presence: true
end
