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


  def updated_station_page    #change station dropdown
    data_methods
    @new_station = []
    Station.first.station_id.upto(Station.last.station_id) do |b|
      @new_station << b
    end
    puts "RESULTS ARE: #{@new_station.inspect}"
    @new_station
  end

  def updated_data_page #change date dropdown
    data_methods
    @result = []
    BikeTrip.first.start_time.to_date.upto(BikeTrip.last.start_time.to_date) do |a|
      @result << a.strftime('%F')
    end
    puts "RESULTS ARE: #{@result.inspect}"
    @result
  end

  def show
    @month_start = "2015-04-01"
    @month_end = "2015-12-30"
    @station_variable = 3005
    data_methods
    @date_change = updated_data_page
    @selected_station = updated_station_page
  end

  def newdate
    @month_start = params[:start_month]
    @month_end = params[:end_month]
    @station_variable = params[:choose_station]
    data_methods
    @date_change = updated_data_page
    @selected_station = updated_station_page
    render 'show'
  end

  def overall #showing all station monthly data in huge chart
    data_methods
  end

  def data_methods
    @trip = BikeTrip.new
    #@pretty_month_start = @month_start.strftime('%b %y')
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
