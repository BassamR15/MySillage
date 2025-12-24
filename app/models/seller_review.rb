class SellerReview < ApplicationRecord
  belongs_to :order
  belongs_to :marketplace_profile
end
