class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @latest = Perfume.latest_releases.includes(:brand)
    @perfumes = Perfume.all
    if user_signed_in? && (current_user.collected_perfumes.any? || current_user.wishlisted_perfumes.any?)
      @recommended = current_user.recommendations.includes(:brand).limit(8)
    else
      @recommended = Perfume.popular.includes(:brand).limit(8)
    end
  end
end
