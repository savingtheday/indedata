class AddIndecesToStations < ActiveRecord::Migration
  def change
    add_index :stations, :station_id
    add_index :bike_trips, :start_station_id
  end
end
