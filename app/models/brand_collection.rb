class BrandCollection < ApplicationRecord
  belongs_to :brand

  has_many :perfumes
end
