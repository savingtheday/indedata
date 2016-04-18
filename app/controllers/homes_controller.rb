class HomesController < ApplicationController
  require 'net/http'
  require 'json'

  def indego_api_response
    uri = URI.parse("https://www.rideindego.com/stations/json/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    @data = http.get(uri.request_uri)
  end

  def show
    @trip = BikeTrip.new
    @station = Station.all
    @mytrips = Station.joins(:bike_trips)
    data = indego_api_response.body
    @result = JSON.parse(data)
    @kiosk = @result['features'][1]['properties']

    all_names = []

    @result['features'].each do |child|
      all_names.push( child['properties']['name'])
    end

    @all_kiosks = all_names
  end





  private

    def station_params
      params.require(:station).permit(:addressStreet, :bikes_available, :docks_available,
     :kiosk_id, :name, :total_docks)
    end
end
