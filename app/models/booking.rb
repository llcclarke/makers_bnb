require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource
  property :id,         Serial
  property :check_in_date, Date
  property :check_out_date,   Date


  def self.check_date(date)
    today_date = DateTime.now
    date_to_check = Date.parse(date)
    date_to_check >= today_date
  end
end
