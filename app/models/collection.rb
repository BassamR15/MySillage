class Collection < ApplicationRecord
  belongs_to :user
  belongs_to :perfume
  
  has_many :offer_items, dependent: :destroy
end
