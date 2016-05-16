require 'data_mapper'

class User
	include DataMapper::Resource

	property :id, Serial
	property :email, String
	property :name, String
	property :username, String
	property :password, String

	def self.authenticate(email, password)
		user = self.first(email: email, password: password)
		if user
			user
		else
			nil
		end
	end

end