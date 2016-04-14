require 'csv'

namespace :import do

  task trips: :environment do
    filename = File.join Rails.root, "trips.csv"
    counter = 0


    CSV.foreach(filename) do |row|
      trip, duration, started, ended, start_station, end_station, trip_category, pass = row
      next if trip == "trip_id"
      trip = Trip.create(
        trip_id: trip,
        duration: duration,
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


task april_2015_trips: :environment do
    filename = File.join Rails.root, "april_2015_trips.csv"
    counter = 0


    CSV.foreach(filename) do |row|
      trip, duration, started, ended, start_station, end_station, trip_category, pass = row
      next if trip == "trip_id"
      trip = April2015Trip.create(
        trip_id: trip,
        duration: duration,
        start_time:  DateTime.strptime(started, '%m/%d/%y %H:%M'),
        end_time: DateTime.strptime(ended, '%m/%d/%y %H:%M'),
        start_station_id: start_station,
        end_station_id: end_station,
        trip_route_category: trip_category,
        passholder_type: pass
      )
      counter += 1 if trip.persisted?
    end

    puts "imported #{counter} April 2015 trips"
  end


end
