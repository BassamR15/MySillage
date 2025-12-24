# app/models/marketplace_profile.rb
class MarketplaceProfile < ApplicationRecord
  belongs_to :user

  has_many :addresses, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :seller_reviews, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :buying_conversations, class_name: "Conversation", foreign_key: :buyer_id, dependent: :destroy
  has_many :selling_conversations, class_name: "Conversation", foreign_key: :seller_id, dependent: :destroy

  has_many :sent_offers, class_name: "Offer", foreign_key: :sender_id, dependent: :destroy

  has_many :opened_disputes, class_name: "Dispute", foreign_key: :opened_by_id, dependent: :destroy
end
  