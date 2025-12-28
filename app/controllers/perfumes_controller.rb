class PerfumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @perfumes = Perfume.all
  end

  def show
    @perfume = Perfume.find(params[:id])

    render inertia: 'Perfumes/Show', props: {
      perfume: {
        **@perfume.as_json(include: {
          brand: { only: [:name] },
          perfumers: { only: [:name] },
          notes: { only: [:name, :family] },
          perfume_notes: { only: [:note_type] }
        }),
        placeholder_image: @perfume.placeholder_image,
        notes_ordered: @perfume.notes_ordered,
        preferred_time: @perfume.preferred_time,
        preferred_season: @perfume.preferred_season,
        longevity_distribution: @perfume.rating_distribution(:rating_longevity),
        sillage_distribution: @perfume.rating_distribution(:rating_sillage),
        value_distribution: @perfume.rating_distribution(:rating_value)
      },
      userSignedIn: user_signed_in?,
      currentUser: user_signed_in? ? current_user.as_json(only: [:id, :email, :username]) : nil,
      userSeasonVotes: user_signed_in? ? @perfume.season_votes.find_by(user: current_user) : nil,
      userReviews: user_signed_in? ? @perfume.reviews.find_by(user: current_user) : nil
    }
  end
end
