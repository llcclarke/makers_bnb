require 'data_mapper'
require 'dm-postgres-adapter'

class Listing

  include DataMapper::Resource

  attr_reader :availability

  property :id,           Serial
  property :title,        String
  property :description,  String
  property :price,        String
  property :availability,   Boolean, :default => true



end