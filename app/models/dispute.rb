class Dispute < ApplicationRecord
  belongs_to :order
  belongs_to :opened_by, class_name: "MarketplaceProfile"
end
