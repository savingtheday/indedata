class BikeTrip < ActiveRecord::Base
  belongs_to :station,
  :foreign_key => "station_id",
  :primary_key => "start_station_id"


  MONTHS = [ 'Apr 2015', 'May 2015', 'Jun 2015', 'Jul 2015', 'Aug 2105', 'Sep 2015',
    'Dec 2015', 'Jan 2016',]
end
