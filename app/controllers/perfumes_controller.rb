class PerfumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @perfumes = Perfume.all
  end

  def show
    @perfume = Perfume.find(params[:id])

    render inertia: 'Perfumes/Show', props: {
      perfume: @perfume.as_json(include: {
        brand: { only: [:name] },
        perfumers: { only: [:name] },
        notes: { only: [:name, :family] },
        perfume_notes: { only: [:note_type] },
        reviews: { only: [:rating_overall, :rating_longevity, :rating_sillage, :rating_value, :content] },
        season_votes: { only: [:spring, :summer, :fall, :winter, :day, :night] }
      },
      methods: [:placeholder_image, :notes_ordered]),
      userSignedIn: user_signed_in? ,
      currentUser: user_signed_in? ? current_user.as_json(only: [:id, :email, :username]) : nil
    }
  end
end
