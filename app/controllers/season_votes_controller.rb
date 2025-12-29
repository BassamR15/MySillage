class SeasonVotesController < ApplicationController
    def create 
        @season_vote = SeasonVote.find_or_initialize_by(user: current_user, perfume_id: params[:perfume_id])
        @season_vote.assign_attributes(season_vote_params)
        
        if @season_vote.save
            render json: { success: true, season_vote: @season_vote}
        else
            render json: { success: false, errors: @season_vote.errors}, status: :unprocessable_entity
        end
    end

    private

    def season_vote_params
        params.require(:season_vote).permit(:spring, :summer, :fall, :winter, :day, :night)
    end
end
