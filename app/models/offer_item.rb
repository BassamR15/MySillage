class OfferItem < ApplicationRecord
  has_one_attached :photo
  belongs_to :offer
  belongs_to :listing, optional: true
  belongs_to :collection, optional: true
end
