class ReviewsController < ApplicationController
    def create 
          # 1. Trouver ou initialiser le season_vote pour cet utilisateur et ce parfum
        # 2. Mettre à jour les valeurs (spring, summer, fall, winter, day, night)
        # 3. Sauvegarder
        # 4. Retourner une réponse JSON
        @review = Review.find_or_initialize_by(user: current_user, perfume_id: params[:perfume_id])
        @review.assign_attributes(reviews_params)
        
        if @review.save
            render json: { success: true, review: @review}
        else
            render json: { success: false, errors: @review.errors}, status: :unprocessable_entity
        end
    end

    private

    def reviews_params
    params.require(:reviews).permit(:rating_longevity, :rating_sillage, :rating_value)
    end
end
