class CollectionsController < ApplicationController

    def create
        @collection = Collection.new(user: current_user, perfume_id: params[:perfume_id])
        @collection.assign_attributes(collection_params)

        if @collection.save
            render json: { success: true, collectioned: true }
        else
            render json: { success: false, errors: @collection.errors }, status: :unprocessable_entity
        end
    end

    private

    def collection_params
        params.require(:collection).permit(:base_quantity_ml, :quantity_ml)
    end
end
