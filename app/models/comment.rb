class Comment < ApplicationRecord
  belongs_to :reply
  belongs_to :user
  validates :content, presence: true
end
