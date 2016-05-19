ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'models/user'
require_relative 'models/listing'
require_relative 'models/booking'
require_relative '../lib/booking_validation'


class Bnb < Sinatra::Base

	enable :sessions
	set :session_secret, 'super secret'
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
		@user = User.create(email: params[:email],
							name: params[:name],
							username: params[:username],
							password: params[:password],
							password_confirmation: params[:password_confirmation])
		if @user.save
			session[:user_id] = @user.id
			redirect '/'
		else
			flash.now[:notice] = @user.errors.full_messages
			erb :new_user
		end
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
		unless current_user
			flash.keep[:errors] = ["You must be signed in to post a new listing"]
			redirect '/'
		end
		@listing = Listing.new
		erb :'listings/new'
	end

	post '/listings' do
		@current_user = User.first(id: session[:user_id])
		listing = Listing.create(title: params[:title],
								description: params[:description],
								price: params[:price])
		@current_user.listings << listing
		@current_user.save
		redirect '/listings'
	end

	get '/listings' do
		@listings = Listing.all

		erb :listings
	end

	get '/listings/:id' do
		session[:listing_id] = params[:id]
		@bookings = Booking.all(listing_id: session[:listing_id])
		@listing = Listing.first(id: session[:listing_id])
		erb :listing
	end

	get 'listings/search' do
		erb :'listings/search'
	end

	post 'listings/results' do
		erb :'listings/results'
	end

	# post '/confirm' do
	# 	@listing = Listing.first(id: params[:id])
	# 	@listing.update(:is_available => false)
	# 	redirect '/confirmation'
	# end
	#
	get '/confirmation' do
		erb :confirmation
	end

	get '/bookings/new' do
		@listing = Listing.first(id: session[:listing_id])
		erb :'bookings/new'
	end

	post '/bookings/new' do
			@booking_validation = BookingValidation.new
			@listing = Listing.first(id: session[:listing_id])
			@bookings = @listing.bookings
			p @bookings
		if @booking_validation.super_check?(params[:check_in_date], params[:check_out_date]) && @booking_validation.validation_loop(params[:check_in_date], params[:check_out_date], @bookings)
			booking = Booking.create(check_in_date: params[:check_in_date],
			check_out_date: params[:check_out_date])
			current_user.bookings << booking
			@listing.bookings << booking
			@current_user.save
			@listing.save
			redirect '/confirmation'
		else
			flash.keep[:errors] = ['Are you a time traveller?']
			redirect '/bookings/new'
		end
	end

  # start the server if ruby file executed directly
  run! if app_file == $0

end
