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



  def updated_station_name_page    #change station dropdown
    data_methods
    @station_name_array = []
    Station.all.each do |c|
      @station_name_array.push([c.station_name, c.station_id])
    end
    puts "***********station name RESULTS ARE: #{@station_name_array.inspect}"
    @station_name_array
  end



  def updated_data_page #change date dropdown
    data_methods
    @result = []
    BikeTrip.first.start_time.to_date.upto(BikeTrip.last.start_time.to_date) do |a|
      @result << a.strftime('%F')
    end
    puts "date RESULTS ARE: #{@result.inspect}"
    @result
  end

  def show
    @month_start = "2015-04-23"
    @month_end = "2015-04-23"
    @station_variable = 3005
    @station_variable_two = nil
    @station_variable_three = nil
    @station_variable_four = nil
    @station_variable_five = nil
    data_methods
    @date_change = updated_data_page
    @selected_station_name = updated_station_name_page
  end

  def newdate
    puts "HERE"
    @month_start = params[:start_month]
    @month_end = params[:end_month]
    @station_variables = []

    for i in 1..5 do
      station_id = params["choose_station_#{i}"]
      name = !station_id.empty? ? Station.where(station_id: station_id).first.station_name : nil
      if name
      ap @station_variables <<  {name: name, data: BikeTrip.group_by_month(:start_time, format: "%b %d, %Y").where(start_station_id: station_id, start_time: @month_start..@month_end).count}
     end
   end

    @station_variables_daily = []

    for i in 1..5 do
      station_id = params["choose_station_#{i}"]
      name = !station_id.empty? ? Station.where(station_id: station_id).first.station_name : nil
      if name
      ap @station_variables_daily <<  {name: name, data: BikeTrip.group_by_day(:start_time, format: "%a %b %d, %Y").where(start_station_id: station_id, start_time: @month_start..@month_end).count}
     end
   end

    @station_variables_weekday = []

    for i in 1..5 do
      station_id = params["choose_station_#{i}"]
      name = !station_id.empty? ? Station.where(station_id: station_id).first.station_name : nil
        if name
        ap @station_variables_weekday <<  {name: name, data: BikeTrip.group_by_day_of_week(:start_time, format: "%a").where(start_station_id: station_id, start_time: @month_start..@month_end).count}
       end
     end


    puts "WE HAVE #{@station_variables.count} STATIONS!!"
    # @station_variable_two = params[:choose_station_two]
    # @station_variable_three = params[:choose_station_three]
    # @station_variable_four = params[:choose_station_four]
    # @station_variable_five = params[:choose_station_five]
    data_methods
    @date_change = updated_data_page
    @selected_station_name = updated_station_name_page
    render 'show'
  end

  def overall #showing all station monthly data in huge chart
    data_methods
  end

  def current_stats #shows json for current kiosk stats
    data = indego_api_response.body
    @result = JSON.parse(data)
    @kiosk = @result['features'][1]['properties']
    all_names = []
    @result['features'].each do |child|
      all_names.push( child['properties']['name'])
    end

    @all_kiosks = all_names
  end

  def data_methods
    @trip = BikeTrip.new
    @station = Station.all
    @mytrips = Station.joins(:bike_trips)
    data = indego_api_response.body
    @result = JSON.parse(data)
    pretty_months
    # @kiosk = @result['features'][1]['properties']
    # all_names = []
    # @result['features'].each do |child|
    #   all_names.push( child['properties']['name'])
    # end

    # @all_kiosks = all_names
  end

  def pretty_months
    @pretty_month_start = Time.parse(@month_start).strftime('%b %d, %Y')
    @pretty_month_end = Time.parse(@month_end).strftime('%b %d, %Y')
  end


  # def name_via_id
  #   data_methods
  #   @selectedname = []
  #   name_from_id = @station.station_name.collect(&:station_id)
  #     @mytrips.each do |mytrips|
  #   @selectedname << mytrips if name_from_id.include?(mytrips.station_id)
  #   end
  # end


  private

    def station_params
      params.require(:station).permit(:addressStreet, :bikes_available, :docks_available,
     :kiosk_id, :name, :total_docks)
    end


end
