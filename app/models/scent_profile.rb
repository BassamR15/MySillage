class ScentProfile < ApplicationRecord
  belongs_to :user

  has_many :smells, dependent: :destroy
end
