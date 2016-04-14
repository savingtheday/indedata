class HomesController < ApplicationController
  def show
    @trips = BikeTrip.all
    @station = Station.all
    @mytrips = Station.joins(:bike_trips).select(:station_name, :start_time)
  end
end
