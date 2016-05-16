require 'data_mapper'
require 'dm-postgres-adapter'




DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bnb_#{ENV['RACK_ENV']}")

require_relative 'models/listing'
DataMapper.finalize
