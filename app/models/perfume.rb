# app/models/perfume.rb
class Perfume < ApplicationRecord
  has_one_attached :image

  belongs_to :brand
  belongs_to :brand_collection

  has_many :perfume_notes, dependent: :destroy
  has_many :notes, through: :perfume_notes

  has_many :perfume_visits, dependent: :destroy

  has_many :perfume_perfumers, dependent: :destroy
  has_many :perfumers, through: :perfume_perfumers

  has_many :reviews, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :season_votes, dependent: :destroy
  has_many :price_alerts, dependent: :destroy
  has_many :verifications, dependent: :destroy
  has_many :sale_records, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :recommended_perfumes, dependent: :destroy

  has_many :dupe_relations, class_name: "PerfumeDupe", foreign_key: :original_perfume_id, dependent: :destroy
  has_many :dupes, through: :dupe_relations, source: :dupe

  has_many :original_relations, class_name: "PerfumeDupe", foreign_key: :dupe_id, dependent: :destroy
  has_many :originals, through: :original_relations, source: :original_perfume

  has_many :base_layerings, class_name: "Layering", foreign_key: :base_perfume_id, dependent: :destroy
  has_many :top_layerings, class_name: "Layering", foreign_key: :top_perfume_id, dependent: :destroy

  has_neighbors :embedding
  # after_create :set_embedding

  scope :popular, -> {
    left_joins(:reviews)
      .group(:id)
      .order('COUNT(reviews.id) DESC')
  }

  scope :latest_releases, -> {
    where(launch_year: [Date.current.year, Date.current.year - 1])
      .order(launch_year: :desc, created_at: :desc)
      .limit(6)
  }

  scope :sorted_by, ->(order) {
    case order
    when 'newest' then order(launch_year: :desc, name: :asc)
    when 'rating' then order(Arel.sql('average_overall DESC NULLS LAST'), name: :asc)
    when 'name' then order(name: :asc)
    else order(trending: :desc, launch_year: :desc, name: :asc)  # default = popularity
    end
  }
  
  def preferred_season
    summer = season_votes.where(summer: true).size
    winter = season_votes.where(winter: true).size
    fall = season_votes.where(fall: true).size
    spring = season_votes.where(spring: true).size
    total = summer + winter + fall + spring
    if total > 0
      { 
        summer: {count: summer, percentage: summer*100/total}, 
        winter: {count: winter, percentage: winter*100/total}, 
        fall: {count: fall, percentage: fall*100/total},
        spring: {count: spring, percentage: spring*100/total},
        total: total
      }
    else 
      { total: total }
    end
  end

  def preferred_time
    day = season_votes.where(day: true).size
    night = season_votes.where(night: true).size
    total = day + night
    if total > 0 
      {
      day: {count: day, percentage: day*100/total},
      night: {count: night, percentage: night*100/total}, 
      total: total 
    }
    else
      { total: total }
    end
  end
  
  def rating_distribution(rating)
    counts = reviews.group(rating).count
    total = counts.values.sum
    
    return { total: 0 } if total == 0
    
    result = counts.transform_values do |value|
      { count: value, percentage: value * 100 / total }
    end
    result[:total] = total
    result
  end

  def average_overall
   reviews.average(:rating_overall)&.round(1)
  end

  def placeholder_image
    ActionController::Base.helpers.asset_path("bottle_#{id % 10}.jpg")
  end

  def self.k_size
    count >= 1000 ? "#{count / 1000}K+" : "#{count}"
  end
  
  def notes_ordered 
    top = []
    heart = []
    base = []
    perfume_notes.each do |note|
      if note.note_type == "top"
        top << note.note.name
      elsif note.note_type == "heart"
        heart << note.note.name
      else
        base << note.note.name
      end
    end
   {top: top, heart: heart, base: base}
  end

  private

  # def top_seasons
  #   votes = season_votes
  #   return "all season" if votes.empty?

  #   total = {
  #     spring: votes.where(spring: true).size,
  #     fall: votes.where(fall: true).size,
  #     winter: votes.where(winter: true).size,
  #     summer: votes.where(summer: true).size
  #   }

  #   max_votes = total.values.max
  #   return "all seasons" if max_votes == 0

  #   threshold = max_votes * 0.82
  #   total.select { |k, v| v >= threshold }.keys.join(', ')
  # end

  # def set_embedding
  #   embedding = RubyLLm.embed(
  #                             <<~TEXT
  #                               #{name} by #{brand.name}.
  #                               Gender: #{gender}.
  #                               Best season: #{top_seasons}.
  #                               Notes: #{notes.map(&:name).join(', ')}.
  #                               Families: #{notes.map(&:family).uniq.join(', ')}.
  #                               Perfumers: #{perfumers.map(&:name).join(', ')}.
  #                               #{description}
  #                             TEXT
  #   )

  #   update_column(:embedding, embedding.vectors)
  # end
end
