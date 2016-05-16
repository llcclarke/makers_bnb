ENV['RACK_ENV'] = 'development'
require 'sinatra/base'
require_relative 'data_mapper_setup'

class Bnb < Sinatra::Base
  get '/' do
    'Hello bnb!'
  end

  get '/listings/new' do
    @listing = Listing.new
    erb :'listings/new'
  end

  post '/listings' do
    @listing = Listing.create(title: params[:title],
    description: params[:description], price: params[:price])
    redirect '/listings'
  end
  get '/listings' do
    @listings = Listing.all
    erb :listings
end



















  # start the server if ruby file executed directly
  run! if app_file == $0
end