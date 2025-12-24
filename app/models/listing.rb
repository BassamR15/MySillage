class Listing < ApplicationRecord
  belongs_to :marketplace_profile
  belongs_to :perfume

  has_many :offer_items, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :orders, dependent: :destroy
end
