class CitiesController < ApplicationController
	def index
		@cities = City.all
	end

	def show
		@city = City.find_by_id(params[:city_id])
		@posts = Post.where({city_id: params[:city_id]})
	end
end
