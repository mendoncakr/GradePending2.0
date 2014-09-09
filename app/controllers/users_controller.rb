class UsersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@enable_nav = true
		@user = User.find(current_user.id)
		@favorites = @user.favorites
	end
end
