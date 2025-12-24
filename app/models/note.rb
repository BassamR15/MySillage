class Note < ApplicationRecord
  has_many :perfume_notes, dependent: :destroy
  has_many :smells, dependent: :destroy
  has_many :perfumes, through: :perfume_notes
end
