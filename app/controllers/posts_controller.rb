class PostsController < ApplicationController

# GET /cities/:city_id/posts/new (shows the create post form)
	def new
		@post = Post.new
	end

# POST /cities/:city_id/posts (creates the submitted form values)
	def create
			# blank? method checks if simple string is blank or not and returns boolean
		blank_post = post_params[:title].blank? || post_params[:description].blank?
		if blank_post
			flash[:alert] = "Must fill in specified fields"
			redirect_to '/cities/' + params[:city_id] + '/posts/new'
		else
			# the form creates a post with relationship to the city from the
			# post by using the post_params hash created below
			# in which user_id and city_id is passed in
			post = Post.create(post_params)
			flash[:notice] = "Successfully created post to " + post.city.location    # <--- uses the city relationship from whats passed into the model in order to get the location
			redirect_to user_path current_user
		end
	end

# GET /cities/:city_id/posts/:id (shows the specific post for the specific city)
	def show
		@post = Post.find_by_id(params[:post_id])
		@city = City.find_by_id(params[:city_id])
		@user = User.find_by_id(session[:user_id])
	end

# GET /posts/:id/edit (shows the edit form)
	def edit
		@post = Post.find_by_id(params[:post_id])
	end

# PATCH /posts/:id (updates the submitted form values)
	def update
		post = Post.find_by_id(params[:post_id])
		post.update(title: post_params[:title], description: post_params[:description])
		redirect_to show_city_post_path({city_id: post.city.id, post_id: post.id})
	end

# DELETE /posts/:id (deletes specific post)
	def destroy
		post = Post.destroy(params[:post_id])
		flash[:notice] = "Successfully deleted post on " + post.city.location
		redirect_to user_path current_user
	end

	private
	# this turns Rails controller params:
	# {"utf8"=>"✓",
	# 	"authenticity_token"=>"oraCiTzjyLg9TR3+jT4Yhz2GrpduEY/9epYK2ZJKu4b5sWwOrrpDCE3HnDI3qmopoeQSpdr3/kmYlGoMHLIirw==",
	# 	"post"=>{"user_id"=>"8", "city_id"=>"3", "title"=>"asda", "description"=>"awdawds"},
	# 	"commit"=>"Add Post",
	# 	"city_id"=>"3"}
	# into this:
		# post_params: { :description, :title, etc...}
	def post_params
		params.require(:post).permit(:title, :description, :user_id, :city_id)
	end
end
