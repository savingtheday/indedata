class HomesController < ApplicationController
  require 'net/http'
  require 'json'

  def indego_api_response
    uri = URI("https://www.rideindego.com/stations/json/")
    Net::HTTP.get(uri)
    #parsed = JSON.parse(response)
  end



  def show
    @trips = BikeTrip.all
    @station = Station.all
    @mytrips = Station.joins(:bike_trips)
  end
end
