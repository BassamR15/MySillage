class Conversation < ApplicationRecord
  belongs_to :buyer, class_name: "MarketplaceProfile"
  belongs_to :seller, class_name: "MarketplaceProfile"
  belongs_to :listing

  has_many :messages, dependent: :destroy
  has_many :offers, dependent: :destroy

end
