class UpdateTrendingPerfumesJob < ApplicationJob
  queue_as :default

  def perform
    Perfume.update_all(trending: false)
    
    visits = PerfumeVisit
      .where(created_at: 1.month.ago..)
      .group(:perfume_id)
      .count
    wishlists = Wishlist
      .where(created_at: 1.month.ago..)
      .group(:perfume_id)
      .count
    
    perfume_ids = Perfume.pluck(:id)
    perfumes_score = {}
    
    perfume_ids.each do |id|
      perfumes_score[id] = (visits[id] || 0) + ((wishlists[id] || 0) * 2)
    end

    sorted_scores = perfumes_score.values.sort.reverse
    top_count = (sorted_scores.count * 0.1).ceil
    threshold = sorted_scores[top_count - 1] || 0

    trending_ids = perfumes_score.select { |_id, score| score >= threshold && score > 0 }.keys
    Perfume.where(id: trending_ids).update_all(trending: true)
  end
end
