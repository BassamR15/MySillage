# app/models/perfume.rb
class Perfume < ApplicationRecord
  has_one_attached :image

  belongs_to :brand

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

  has_many :dupe_relations, class_name: "PerfumeDupe", foreign_key: :original_perfume_id, dependent: :destroy
  has_many :dupes, through: :dupe_relations, source: :dupe

  has_many :original_relations, class_name: "PerfumeDupe", foreign_key: :dupe_id, dependent: :destroy
  has_many :originals, through: :original_relations, source: :original_perfume

  has_many :base_layerings, class_name: "Layering", foreign_key: :base_perfume_id, dependent: :destroy
  has_many :top_layerings, class_name: "Layering", foreign_key: :top_perfume_id, dependent: :destroy
end
