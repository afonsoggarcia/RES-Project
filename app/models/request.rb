class Request < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  validates :user, uniqueness: true
end
