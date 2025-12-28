class PerfumersController < ApplicationController

  def index
    @perfumers = Perfumer.all
  end

  def show
    @perfumer = Perfume.find(params[:id])
  end
end
