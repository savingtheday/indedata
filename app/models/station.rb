class Station < ActiveRecord::Base
  has_many :bike_trips,
  :foreign_key => "start_station_id",
  :primary_key => "station_id"
end
