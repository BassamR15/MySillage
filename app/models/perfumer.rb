class Perfumer < ApplicationRecord
  has_one_attached :photo

  has_many :perfume_perfumers, dependent: :destroy
  has_many :perfumes, through: :perfume_perfumers

  def rating
    avg = Review.joins(perfume: :perfume_perfumers)
                .where(perfume_perfumers: {perfumer_id: id})
                .average(:rating_overall)
    
    avg&.round(1)
  end
end
