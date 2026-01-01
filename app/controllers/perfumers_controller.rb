class PerfumersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @perfumers = Perfumer.includes(perfumes: :reviews).all
    @featured_perfumer = Perfumer.includes(perfumes: :reviews).find_by(featured: true)

    render inertia: 'Perfumers/Index', props: {
      perfumers: @perfumers.map { |perfumer| serialize_perfumer(perfumer) },
      perfumersCount: @perfumers.count,
      perfumesCount: Perfume.joins(:perfumers).distinct.count,
      userSignedIn: user_signed_in?,
      currentUser: user_signed_in? ? current_user.as_json(only: [:id, :email, :username]) : nil,
      featuredPerfumer: @featured_perfumer ? serialize_perfumer(@featured_perfumer) : nil
    }
  end

  def show
    @perfumer = Perfume.find(params[:id])
  end

  private

  def serialize_perfumer(perfumer)
    perfumer.as_json(only: [:id, :name, :bio]).merge(
      rating: perfumer.rating,
      perfumes_count: perfumer.perfumes.size,
      brands: perfumer.brands.first(2)
    )
  end
end
