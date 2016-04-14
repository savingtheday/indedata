class HomesController < ApplicationController
  def show
    @trips = Trip.all
  end
end
