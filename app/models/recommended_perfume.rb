class RecommendedPerfume < ApplicationRecord
  belongs_to :user
  belongs_to :perfume
end
