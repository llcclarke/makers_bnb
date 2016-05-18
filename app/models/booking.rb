require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource
  property :id,         Serial
  property :check_in_date, Date
  property :check_out_date,   Date


# def check_date(date)
#   date
# end
end
