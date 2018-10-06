class CitiesController < ApplicationController

	#GET /cities (Gets all cities from the database)
	def index
		@cities = City.all
	end

	#GET /cities/:city_id (shows specific city)
	def show
		# Finds the city to show by the params hash
		@city = City.find_by_id(params[:city_id])
		# Finds all the posts that belong to the city_id in the params hash
		@posts = Post.where({city_id: params[:city_id]})
	end
end
