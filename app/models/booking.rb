require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

  include DataMapper::Resource
  property :id,         Serial
  property :check_in_date, String
  property :check_out_date,   String

  belongs_to :user
  belongs_to :listing

  # def self.check_date(date)
  #   today_date = DateTime.now
  #   date_to_check = Date.parse(date)
  #   date_to_check >= today_date
  # end
end
