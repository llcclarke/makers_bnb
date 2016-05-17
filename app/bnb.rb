ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'models/user'
require_relative 'models/listing'

class Bnb < Sinatra::Base

	enable :sessions
	set :session_secret, 'super secret'
	register Sinatra::Flash
	use Rack::MethodOverride

	helpers do
		def current_user
			@current_user ||= User.get(session[:user_id])
		end
	end

	get '/' do
		erb :index
	end




































































































































































































































	get '/users/new' do
		@user = User.new
		erb :'users/new'
	end

	post '/users' do
		@user = User.create(email: params[:email],
							name: params[:name],
							username: params[:username],
							password: params[:password])
		if @user.save
			session[:user_id] = @user.id
			redirect '/'
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :'users/new'
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

	# start the server if ruby file executed directly
	run! if app_file == $0
end
