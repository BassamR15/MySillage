class CreateRecommendationJob < ApplicationJob
  queue_as :default

  def perform(user)
    user_vector = user_taste_vector(user)
    return if user_vector.nil?

    excluded_ids = user.collected_perfumes.pluck(:id) + user.wishlisted_perfumes.pluck(:id)

    recommendations = Perfume.nearest_neighbors(:embedding, user_vector, distance: "cosine")
                             .where.not(id: excluded_ids)
                             .first(10)

    user.recommended_perfumes.destroy_all

    recommendations.each do |perfume|
      RecommendedPerfume.create!(
        user: user,
        perfume: perfume,
        score: perfume.neighbor_distance
      )
    end
  end

  private

  def user_taste_vector(user)
    perfumes_with_dates = []

    user.collections.includes(:perfume).each do |c|
      perfumes_with_dates << { perfume: c.perfume, date: c.created_at, weight: 2.0 }
    end

    user.wishlists.includes(:perfume).each do |w|
      perfumes_with_dates << { perfume: w.perfume, date: w.created_at, weight: 1.0 }
    end

    return nil if perfumes_with_dates.empty?

    now = Time.current
    max_age = 2.years.to_i

    weighted_embeddings = perfumes_with_dates.map do |item|
      embedding = item[:perfume].embedding
      next nil unless embedding

      age = (now - item[:date]).to_i
      recency_weight = [1.0 - (age.to_f / max_age), 0.2].max
      total_weight = item[:weight] * recency_weight

      { embedding: embedding, weight: total_weight }
    end.compact

    return nil if weighted_embeddings.empty?

    total_weight = weighted_embeddings.sum { |e| e[:weight] }
    weighted_sum = weighted_embeddings.reduce(nil) do |sum, e|
      weighted = e[:embedding] * e[:weight]
      sum ? sum + weighted : weighted
    end

    weighted_sum / total_weight
  end
end
