class SessionsController < ApplicationController

	#GET '/login' (shows the login form)
	def new
		@user = User.new
	end

	#POST '/sessions' (creates a new session / logs in the user)
	def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.confirm(user_params)
  	if @user
      login(@user)
      flash[:notice] = "Successfully logged in."      # <--- Add this flash notice
      redirect_to @user
    else
      flash[:error] = "Incorrect email or password."  # <--- Add this flash error
      redirect_to login_path
    end
  end

	#GET '/logout' (deletes the sessions / logs out the user)
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."        # <--- Add this flash notice
    redirect_to root_path
  end
end
