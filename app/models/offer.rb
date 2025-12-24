class Offer < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "MarketplaceProfile"

  has_many :offer_items
end
