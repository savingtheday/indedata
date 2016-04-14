class CreateBikeTrips < ActiveRecord::Migration
  def change
    create_table :bike_trips do |t|
      t.integer :trip_id
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :start_station_id
      t.integer :end_station_id
      t.string :trip_route_category
      t.string :passholder_type

      t.timestamps null: false
    end
  end
end
