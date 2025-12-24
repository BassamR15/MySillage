class Order < ApplicationRecord
  belongs_to :marketplace_profile
  belongs_to :listing
  belongs_to :perfume

  has_one :dispute, dependent: :destroy
  has_one :seller_review, dependent: :destroy
end
