class UsersController < ApplicationController

	# GET /users/ (displays the list of users)
	def index
		@users = User.all
	end

	# GET /users/new/ (shows the create user form)
	def new
		@user = User.new
	end

	#POST /users/ (creates from submitted form values)
	def create
		# create method automatically saves. Uses the user_params hash declared below to create specified properties
		@user = User.create(user_params)
		# if @user instance variable successfully saves to the database run the function
		if @user
			login(@user)
			redirect_to user_path({id: @user.id})
		else
			flash[:error] = "email already in use, please try a different email"
			redirect_to root_path
		end
	end

	#GET /users/:id (shows the individual user)
	def show
		@user = User.find_by_id(session[:user_id])
	end

	#PATCH /users/:id (updates from submitted form values)
	def update
		@user = User.find_by_id(session[:user_id])
		# update method specifies what to set specifically using hashes and our user_params hash.
		@user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], hometown: user_params[:hometown], prof_image: user_params[:prof_image])
		redirect_to @user
	end

	#GET /users/:id/edit (shows the edit form)
	def edit
		@user = User.find_by_id(session[:user_id])
	end

	private
	def user_params
		# this turns Rails controller params:
		# {"utf8"=>"✓",
		#"authenticity_token"=>"qKiOKZhFuv3GQKcn/lz+UlTAIsc2CWba61vchczsCBf4bNjvAwZtl78nqCbnM/yEndPltHlteuajmoYZRF1Dgg==",
		# "user"=>{"first_name"=>"Jesse", "last_name"=>"", "email"=>"malu.peralta808@gmail.com", "password"=>"[FILTERED]", "hometown"=>"", "prof_image"=>""},
		# "commit"=>"Sign Up"}
		# into this:
		# user_params: { first_name, last_name, etc...}
		params.require(:user).permit(:email, :first_name, :last_name, :password, :prof_image, :hometown)
	end

end
