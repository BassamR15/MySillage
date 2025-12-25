# app/jobs/schedule_recommendations_job.rb
class ScheduleRecommendationsJob < ApplicationJob
  queue_as :default

  def perform
    User.where('last_sign_in_at > ?', 1.week.ago)
        .find_each do |user|
      next unless user.collected_perfumes.any? || user.wishlisted_perfumes.any?

      CreateRecommendationJob.perform_later(user)
    end
  end
end
