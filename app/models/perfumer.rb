class Perfumer < ApplicationRecord
  has_one_attached :photo

  has_many :perfume_perfumers, dependent: :destroy
  has_many :perfume, through: :perfume_perfumers
end
