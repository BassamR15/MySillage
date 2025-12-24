class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_pic

  has_one :marketplace_profile, dependent: :destroy
  has_one :scent_profile, dependent: :destroy

  has_many :collections, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :search_histories, dependent: :destroy
  has_many :season_votes, dependent: :destroy
  has_many :price_alerts, dependent: :destroy
  has_many :verifications, dependent: :destroy
  has_many :layerings, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :ai_conversations, dependent: :destroy
  has_many :user_badges, dependent: :destroy
  has_many :badges, through: :user_badges

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
