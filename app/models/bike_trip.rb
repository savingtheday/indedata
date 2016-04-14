class BikeTrip < ActiveRecord::Base
  belongs_to :station,
  :foreign_key => "station_id",
  :primary_key => "start_station_id"
end
