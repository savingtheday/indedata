class HomesController < ApplicationController
  def show
    @trips = Trip.all
    @mytrips = Station.joins(:bike_trips).select(:station_name, :start_time)
  end
end
