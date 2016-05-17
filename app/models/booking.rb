require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource
  property :id,         Serial
  property :start_date, String
  property :end_date,   String


# def check_date(date)
#   date
# end
end
