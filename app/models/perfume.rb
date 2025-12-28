# app/models/perfume.rb
class Perfume < ApplicationRecord
  has_one_attached :image

  belongs_to :brand
  belongs_to :brand_collection

  has_many :perfume_notes, dependent: :destroy
  has_many :notes, through: :perfume_notes

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
   [{top: top} ,{heart: heart} ,{base: base}]
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
