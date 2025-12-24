class Smell < ApplicationRecord
  belongs_to :scent_profile
  belongs_to :note
end
