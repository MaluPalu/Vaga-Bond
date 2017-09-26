class User < ApplicationRecord
	has_secure_password
	
  validates :email, uniqueness: true, case_sensitive: false, on: :create

  has_many :posts, dependent: :destroy

	def self.confirm(user_params)
		@user = User.find_by({email: user_params[:email]})
		@user ? @user.authenticate(user_params[:password]) : false
  end
end
