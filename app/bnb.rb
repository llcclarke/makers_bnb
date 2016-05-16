ENV['RACK_ENV'] ||= 'development'
require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
require_relative 'models/user'

























































































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


  # start the server if ruby file executed directly
  run! if app_file == $0
end
