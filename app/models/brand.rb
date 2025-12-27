class Brand < ApplicationRecord
  has_one_attached :logo

  has_many :perfumes, dependent: :destroy
  has_many :brand_collections, dependent: :destroy
end
