class Badge < ApplicationRecord
  has_one_attached :icon

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
end
