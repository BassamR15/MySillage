class Favourite < ApplicationRecord
  belongs_to :marketplace_profile
  belongs_to :listing
end
