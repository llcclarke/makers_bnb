ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'models/user'
require_relative 'models/listing'
require_relative 'models/booking'


class Bnb < Sinatra::Base

	enable :sessions
	register Sinatra::Flash
	use Rack::MethodOverride
	helpers do
		def current_user
			@current_user ||= User.first(id: session[:user_id])
		end
	end

	get '/' do
		erb :index
	end



	get '/users/new' do
		erb :new_user
	end

	post '/users/new' do
		user = User.create(email: params[:email],
							name: params[:name],
							username: params[:username],
							password: params[:password])
		redirect '/'
	end

	get '/session/new' do
		erb :sign_in
	end

	post '/session/new' do
		user = User.authenticate(params[:email],
								params[:password])
		if user
			session[:user_id] = user.id
			redirect '/'
		else
			flash.now[:errors] = 'The email or password entered was invalid'
			erb :sign_in
		end
	end
	delete '/session' do
		session[:user_id] = nil
		flash.keep[:notice] = 'Thanks for using BnB'
		redirect '/'
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

  get '/listings/:id' do
    @listing = Listing.first(id: params[:id])
    erb :listing
  end


  post '/confirm' do
    @listing = Listing.first(id: params[:id])
    @listing.update(:is_available => false)
    redirect '/confirmation'
  end

  get '/confirmation' do
    erb :confirmation
  end





























































	post '/bookings/new' do
		@bookings = Booking.create(check_in_date: params[:check_in_date],
		check_out_date: params[:check_out_date])
	end

	get '/bookings/new' do
		@bookings = Booking.new
		erb :'bookings/new'
	end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
