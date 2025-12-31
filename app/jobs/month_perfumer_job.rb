class MonthPerfumerJob < ApplicationJob
  queue_as :default

  def perform
    Perfumer.update_all(featured: false)

    reviews_avg = Review
      .joins(perfume: :perfume_perfumers)
      .where(created_at: 1.month.ago..)
      .group('perfume_perfumers.perfumer_id')
      .average(:rating_overall)

    wishlists_count = Wishlist
      .joins(perfume: :perfume_perfumers)
      .where(created_at: 1.month.ago..)
      .group('perfume_perfumers.perfumer_id')
      .count

    perfumer_scores = {}

    Perfumer.includes(perfumes: :reviews).find_each do |perfumer|
      reviews_score = reviews_avg[perfumer.id] || 0
      wishlists_score = wishlists_count[perfumer.id] || 0
      rating = perfumer.rating || 0
      max_wishlists = wishlists_count.values.max || 1
      wishlists_normalized = (wishlists_score.to_f / max_wishlists) * 5

      perfumer_scores[perfumer.id] = rating + reviews_score + wishlists_normalized
    end
    
    winner_id = perfumer_scores.max_by { |_id, score| score }&.first

    Perfumer.where(id: winner_id).update_all(featured: true) if winner_id
  end
end
