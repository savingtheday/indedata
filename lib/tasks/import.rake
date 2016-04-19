require 'csv'

namespace :import do

  task trips: :environment do
    #BikeTrip.destroy_alltst
        puts 'heck'
    filename = File.join Rails.root, "kris.csv"
    counter = 0


    CSV.foreach(filename) do |row|
      trip, started, ended, start_station, end_station, trip_category, pass = row
      next if trip == "trip_id"
      trip = BikeTrip.create(
        trip_id: trip,
        start_time:  DateTime.strptime(started, '%m/%d/%y %H:%M'),
        end_time: DateTime.strptime(ended, '%m/%d/%y %H:%M'),
        start_station_id: start_station,
        end_station_id: end_station,
        trip_route_category: trip_category,
        passholder_type: pass
      )
      counter += 1 if trip.persisted?
    end

    puts "imported #{counter} trips"
  end


task stations: :environment do
    filename = File.join Rails.root, "stations.csv"
    counter = 0


    CSV.foreach(filename) do |row|
      number, name = row
      next if number == "Station ID"
      number = Station.create(
        station_id: number,
        station_name: name,
      )
      counter += 1 if number.persisted?
    end

    puts "imported #{counter} stations"
  end


end
