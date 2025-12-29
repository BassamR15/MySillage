class WishlistsController < ApplicationController
  def create
    @wishlist = Wishlist.new(user: current_user, perfume_id: params[:perfume_id])
    
    if @wishlist.save
      render json: { success: true, wishlisted: true }
    else
      render json: { success: false, errors: @wishlist.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @wishlist = Wishlist.find_by(user: current_user, perfume_id: params[:perfume_id])
    
    if @wishlist&.destroy
      render json: { success: true, wishlisted: false }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end
end