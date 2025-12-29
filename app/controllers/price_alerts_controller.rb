class PriceAlertsController < ApplicationController
  def create
    @price_alert = PriceAlert.find_or_initialize_by(user: current_user, perfume_id: params[:perfume_id])
    @price_alert.assign_attributes(price_alert_params)
    @price_alert.active = true

    if @price_alert.save
      render json: { success: true, price_alert: @price_alert }
    else
      render json: { success: false, errors: @price_alert.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @price_alert = PriceAlert.find_by(user: current_user, perfume_id: params[:perfume_id])
    
    if @price_alert&.destroy
      render json: { success: true }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def price_alert_params
    params.require(:price_alert).permit(:max_price_cents, :min_quantity_ml)
  end
end