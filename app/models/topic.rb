class Topic < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy
  validates :title, :description, presence: true
  validates :title, uniqueness: { case_sensitive: false }
end
