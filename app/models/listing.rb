require 'data_mapper'
require 'dm-postgres-adapter'

class Listing

  include DataMapper::Resource

  attr_accessor :is_available

  property :id,           Serial
  property :title,        String
  property :description,  String
  property :price,        String
  property :is_available,   Boolean, :default => true



end