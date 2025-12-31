class PerfumersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @perfumers = Perfumer.all
  end

  def show
    @perfumer = Perfume.find(params[:id])
  end
end
